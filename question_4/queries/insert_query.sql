INSERT INTO session_table
WITH session_min_max AS (
    -- FETCH ALL SESSIONS
    SELECT 
        user_id, 
        session_id,
        MAX(page_view_at) AS max_session_view,  
        MIN(page_view_at) AS min_session_view
    FROM 
        session_table
    -- WE FETCH PAST SESSIONS JUST IN CASE WE HAVE TO CONTINUE A SESSION
    WHERE 
        page_view_at BETWEEN '{{ start_time }}'::timestamp - interval '45 minutes' AND '{{ end_time }}'::timestamp
    GROUP BY 
        user_id, session_id
), event_session_match AS (
    SELECT 
        t1.user_id,
        page_view_at,
        page,
        LAG(page_view_at) OVER (PARTITION BY t1.user_id ORDER BY page_view_at) AS prev_page_view_at,
        LEAD(page_view_at) OVER (PARTITION BY t1.user_id ORDER BY page_view_at) AS next_page_view_at,
        t2.session_id
    FROM 
        event_paige_view t1
    LEFT JOIN 
        session_min_max t2 ON t1.user_id = t2.user_id AND t1.page_view_at BETWEEN t2.min_session_view AND t2.max_session_view
    WHERE 
        -- WE FILTER BY EVENTS JUST TO NOT REINSERT OLD EVENTS
        MD5(t1.user_id::text || t1.page_view_at::text)::UUID NOT IN (SELECT event_id FROM session_table) AND
		-- WE FETCH EVENTS ON THE SAME SELECTED TIME SLOT
		page_view_at BETWEEN '{{ start_time }}'::timestamp AND '{{ end_time }}'::timestamp 
), session_bounds AS (
    SELECT
        user_id,
        page_view_at,
        CASE WHEN prev_page_view_at IS NULL OR EXTRACT(EPOCH FROM (page_view_at - prev_page_view_at)) / 60 >= 30 THEN page_view_at END AS min_session_view,
        CASE WHEN next_page_view_at IS NULL OR EXTRACT(EPOCH FROM (next_page_view_at - page_view_at)) / 60 >= 30 THEN page_view_at END AS max_session_view
    FROM 
        event_session_match
    WHERE 
        session_id IS NULL
), session_groups AS (
    SELECT
        user_id,
        page_view_at,
        min_session_view,
        LEAD(max_session_view) OVER (PARTITION BY user_id ORDER BY page_view_at) AS max_session_view
    FROM 
        session_bounds
    WHERE 
        min_session_view IS NOT NULL OR max_session_view IS NOT NULL
), sessions AS (
    SELECT 
        user_id,
        page_view_at,
        min_session_view,
        max_session_view,
        MD5(user_id::text || clock_timestamp()::text)::UUID AS session_id
    FROM 
        session_groups
    WHERE 
        min_session_view IS NOT NULL
)
SELECT
    t1.user_id,
    MD5(t1.user_id::text || t1.page_view_at::text)::UUID AS event_id,
    COALESCE(t1.session_id, t2.session_id, MD5(t1.user_id::text || clock_timestamp()::text)::UUID) AS session_id,
    t1.page_view_at,
    t1.page
FROM 
    event_session_match t1
LEFT JOIN 
    sessions t2 ON t1.user_id = t2.user_id AND 
    t1.page_view_at >= t2.min_session_view AND t1.page_view_at < t2.max_session_view
ORDER BY 
    t1.user_id, t1.page_view_at;