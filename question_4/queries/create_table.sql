-- Event tables
CREATE TABLE event_paige_view (
    user_id INT NOT NULL,
    page_view_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    page VARCHAR(255) NOT NULL
);

-- SESSION TABLE
CREATE TABLE session_table (
    user_id INT NOT NULL,
    event_id UUID NOT NULL,
    session_id UUID NOT NULL,
    page_view_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    page VARCHAR(255) NOT NULL
);