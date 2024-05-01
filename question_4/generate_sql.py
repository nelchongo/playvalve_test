import random
from datetime import datetime, timedelta

# Sample data
user_ids = range(1,10)
pages = ['/about', '/services', '/product/3', '/product/5', '/contact', '/home', '/product/1', '/product/2']
start_date = datetime(2024, 4, 30)
end_date = datetime.now()

# Generate SQL INSERT statements
insert_statements = []
for _ in range(1000):
    user_id = random.choice(user_ids)
    page_view_at = start_date + timedelta(seconds=random.randint(0, int((end_date - start_date).total_seconds())))
    page = random.choice(pages)
    insert_statement = f"INSERT INTO event_paige_view (user_id, page_view_at, page) VALUES ({user_id}, '{page_view_at}', '{page}');"
    insert_statements.append(insert_statement)

# Write SQL INSERT statements to .sql file
with open('./queries/generated_data.sql', 'w') as file:
    for statement in insert_statements:
        file.write(statement + '\n')