from __future__ import annotations

import logging
import os
from contextlib import contextmanager

import psycopg2
from dotenv import load_dotenv

load_dotenv()
DB_NAME = os.getenv("DB_NAME")
DB_HOST = os.getenv("DB_HOST")
DB_USER = os.getenv("DB_USER")
DB_PASS = os.getenv("DB_PASS")
DB_PORT = os.getenv("DB_PORT")


@contextmanager
def create_connection():
    conn = psycopg2.connect(
        database=DB_NAME, user=DB_USER, host=DB_HOST, password=DB_PASS, port=DB_PORT
    )
    yield conn
    conn.rollback()
    conn.close()


SQL = {
    "students": """INSERT INTO students(first_name, last_name, birthdate, gender) 
        VALUES (%s, %s, %s, %s)""",
    "groups": """INSERT INTO groups(name, code) 
        VALUES (%s, %s)""",
    "students_groups": """INSERT INTO students_groups(student_id, group_id) 
        VALUES (%s, %s)""",
    "teachers": """INSERT INTO teachers(first_name, last_name, birthdate, gender) 
        VALUES (%s, %s, %s, %s)""",
    "subjects": """INSERT INTO subjects(name, description) 
        VALUES (%s, %s)""",
    "teachers_subjects": """INSERT INTO teachers_subjects(teacher_id, subject_id) 
        VALUES (%s, %s)""",
    "grades": """INSERT INTO grades(code, value) 
        VALUES (%s, %s)""",
    "students_grades": """INSERT INTO students_grades(student_id, grade_id, subject_id) 
        VALUES (%s, %s, %s)""",
}


def insert_data_to_db_table(data: set | list[tuple], table_name: str):
    with create_connection() as conn:
        cur = conn.cursor()
        sql = SQL.get(table_name)
        if sql:
            print(table_name)
            cur.executemany(sql, data)
            conn.commit()
            logging.info(f"The data was inserted into db table '{table_name}'")
