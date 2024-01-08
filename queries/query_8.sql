-- Знайти середній бал, який ставить певний викладач зі своїх предметів.

SELECT ROUND(AVG(g.value), 2) as avg_grade, t.first_name || ' ' || t.last_name as
    full_teacher_name
FROM public.students_grades sg
JOIN public.grades g on sg.grade_id = g.id
JOIN public.teachers_subjects ts on sg.subject_id = ts.subject_id
JOIN public.teachers t on ts.teacher_id = t.id
GROUP BY t.first_name, t.last_name