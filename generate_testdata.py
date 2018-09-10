#!/usr/bin/env python

def write_rows(writer, count):
    import random as r

    from faker import Faker # pip install faker
    fake = Faker('jp_JP')
    fake.seed(4321)

    # Header
    writer.writerow(['uid', 'name', 'code', 'address', 'color', 'random','create_at'])

    from progressbar import ProgressBar # pip install progressbar2
    p = ProgressBar(1, count)

    for i in range(1, count + 1):
        writer.writerow([i, fake.name(), fake.ean13(), fake.address(), fake.color_name(), r.randint(0, int(count/2)), fake.date_time_this_year()])
        p.update(i)

# Entry Point
import argparse
parser = argparse.ArgumentParser(description='Generate csv file that filled fake data')
parser.add_argument('row_count', metavar='N', type=int, help='Number of rows')
parser.add_argument('-o', help='Destination of generated file', default='bench.csv')
args = parser.parse_args()

row_count = vars(args)['row_count']
csv_file  = vars(args)['o']
print('row_count:{}'.format(row_count))
print('destination:{}'.format(csv_file))

with open(csv_file, 'w', encoding='UTF-8') as f:
    import csv
    writer = csv.writer(f)
    write_rows(writer, row_count)
