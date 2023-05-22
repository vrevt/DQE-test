import argparse

import psycopg2
import datetime

CREATE_TABLE_QUERY = '''
create table {name} (time date);
'''

INSERT_QUERY = '''
insert into times (time) values ('{date}');
'''

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-u', '--user')
    parser.add_argument('-p', '--password')
    parser.add_argument('-ho', '--host', nargs='?', default='localhost')
    parser.add_argument('-d', '--database', nargs='?', default='vizor')
    args = parser.parse_args()
    return args

def db_connection(user, password, host, database):
    conn = psycopg2.connect(
        host=host,
        database=database,
        user=user,
        password=password)

    cur = conn.cursor()
    return cur, conn


if __name__ == '__main__':
    args = parse_args()
    cur, conn = db_connection(user=args.user,
                              password=args.password,
                              host=args.host,
                              database=args.database)

    cur.execute(CREATE_TABLE_QUERY.format(name='times'))
    n = 19498
    m = 20
    for j in range(m):
        for i in range(n):
            query = INSERT_QUERY.format(
                date=datetime.date(1970, 1, 1) + datetime.timedelta(days=i)
            )
            cur.execute(query)
    conn.commit()
