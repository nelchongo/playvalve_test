# QUESTION 4
## SQL
We have the following data about pageviews on a website.

| user_id | page_view_at         | page        |
|---------|----------------------|-------------|
| 123     | 2020-02-02 12:55:16  | /contact    |
| 123     | 2020-02-02 12:55:18  | /home       |
| 456     | 2020-02-02 12:55:18  | /product/1  |
| 456     | 2020-02-02 12:55:18  | /product/2  |
| 789     | 2020-02-02 12:55:18  | /product/4  |

Your task is to: Create a sessions table derived from the data, where the pageviews are aggregated into sessions. We consider a session a series of pageviews followed by a 30-minute window without any page view.

## Answer
For this question folder structure is the following 

    - question_4
    ├── queries
    │   ├── create_query.sql
    │   └── insert_query.sql
    ├── docker-compose.yml
    └── generate_sql.py

1. `generate_sql.py` will generate a new sql file called generated_data.sql this is just a lazy way to populate the DB and test this SQL
    - For executing the file:

            python3 generate_sql.py

2. `docker-compose.yml` a simple docker file to run and install PostgresSQL
    1. For start the DB:

            docker-compose up -d

    2. When the docker image is running and healthy just go into your DB Application of choice and connect with this credentials:

            user:       postgres
            password:   example
            host:       0.0.0.0
            port:       5432
            db:         postgres

3. `queries`: this folder contains all the queries for this test

    1. `create_query.sql` this sql queries will generate the required tables for the test
    2. `generated_data.sql` this file is generated after you run the `generate_sql.py`. This sql query is to populate the table with data in this test we generated `1000` events.
    3. `insert_query.sql` this is the query to populate the `session_table` with an update plan in case new events arraive late or we simply insert new rows.
        - **NOTE**: There's a {{ start_time }} {{ end_time }} in order to show how the query should run in a time frame for a batch processing. In this case just delete that condition
    4. `agg_query.sql` This is the aggregation query requested in question 3. It performs simple aggregations based on sessions.

> **__NOTE__**: We're utilizing PostgreSQL for this query, which could potentially be optimized for other database systems. However, for the simplicity of this test, we're running it within a Docker Image.

## Conclusion
The `session_table` now includes additional attributes: `session_id` and `event_id`. Let's delve into the reasons for these additions:
- **Session Table**: This table was introduced to enhance the performance of aggregation queries. Constantly checking the next row in a table ordered by `user_id` and `page_view_at` to identify if the next event is in a new session can be resource-intensive. To mitigate this, the `session_table` was created to store session information.
- **session_id**: Each session is assigned a unique identifier (`session_id`). This facilitates aggregation operations based on distinct sessions.
- **event_id**: An identification number (`event_id`) is assigned to each event, aiding in the prevention of duplicate insertions.

### Other Considerations
The query plan provided in `insert_query.sql` focuses exclusively on insert operations. This strategy is preferred due to the potential performance impact of updates on a data warehouse (DWH) infrastructure. Additionally, delete queries have the potential to trigger recalculation of existing sessions, further emphasizing the preference for insert-only operations.