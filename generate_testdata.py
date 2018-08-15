
ROW_COUNT = 1000000
CSV_FILE = "bench.csv"

# --
import csv


def write_rows(writer, count):
    from faker import Faker # pip install faker
    fake = Faker('jp_JP')
    fake.seed(4321)

    # Header
    writer.writerow(['uid', 'name', 'code', 'address', 'color', 'create_at'])

    for i in range(1, ROW_COUNT + 1):
        writer.writerow([i, fake.name(), fake.ean13(), fake.address(), fake.color_name(), fake.date_time_this_year()])

with open(CSV_FILE, 'w') as f:
    writer = csv.writer(f)
    write_rows(writer, ROW_COUNT)

#
