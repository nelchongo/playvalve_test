SELECT 
    user_id, 
    session_id, 
    MIN(page_view_at) AS min_page_view_at, 
    MAX(page_view_at) AS max_page_view_at, 
    COUNT(*) AS page_views_count 
FROM 
    session_table 
GROUP BY 
    user_id, 
    session_id 
ORDER BY 
    user_id, min_page_view_at;