import faker
from random import randint, choice

from db import insert_data_to_db_table
from enums import GENDER, GRADE, SUBJECT

NUMBER_STUDENTS = 50
NUMBER_GROUPS = 3
NUMBER_STUDENTS_IN_GROUPS = 20
NUMBER_SUBJECTS = len(SUBJECT)
NUMBER_TEACHERS = 5
NUMBER_GRADES = 20


def generate_fake_data() -> dict[str, list]:
    fake_students = []
    fake_groups = []
    fake_students_groups = []
    fake_teachers = []
    fake_subjects = []
    fake_grades = []
    fake_students_grades = []
    fake_teachers_subjects = []

    fake_data = faker.Faker()
    genders = (GENDER.MALE.value, GENDER.FEMALE.value)

    for _ in range(NUMBER_STUDENTS):
        first_name, last_name = fake_data.name().split()[:2]
        fake_students.append((first_name, last_name, fake_data.date(), choice(genders)))

    for _ in range(NUMBER_GROUPS):
        name, code = fake_data.name().split()[:2]
        fake_groups.append((name, code))

    for _ in range(NUMBER_STUDENTS_IN_GROUPS * NUMBER_GROUPS):
        fake_students_groups.append(
            (randint(1, NUMBER_STUDENTS), randint(1, NUMBER_GROUPS))
        )

    for _ in range(NUMBER_TEACHERS):
        first_name, last_name = fake_data.name().split()[:2]
        fake_teachers.append((first_name, last_name, fake_data.date(), choice(genders)))

    for subject in SUBJECT:
        fake_subjects.append((subject.value, f"'{subject.value}' description"))

    for _ in range(NUMBER_SUBJECTS * NUMBER_TEACHERS):
        fake_teachers_subjects.append(
            ((randint(1, NUMBER_TEACHERS), (randint(1, NUMBER_SUBJECTS))))
        )

    for grade in GRADE:
        fake_grades.append((grade.value.get("code"), grade.value.get("value")))

    for _ in range(NUMBER_GRADES * NUMBER_STUDENTS * NUMBER_SUBJECTS):
        fake_students_grades.append(
            (
                randint(1, NUMBER_STUDENTS),
                randint(1, len(GRADE)),
                (randint(1, NUMBER_SUBJECTS)),
            )
        )

    return {
        "students": fake_students,
        "groups": fake_groups,
        "students_groups": fake_students_groups,
        "teachers": fake_teachers,
        "subjects": fake_subjects,
        "teachers_subjects": set(fake_teachers_subjects),
        "grades": fake_grades,
        "students_grades": fake_students_grades,
    }


def insert_data_to_db():
    fake_data = generate_fake_data()
    for table_name, table_data in fake_data.items():
        insert_data_to_db_table(data=table_data, table_name=table_name)


if __name__ == "__main__":
    insert_data_to_db()
