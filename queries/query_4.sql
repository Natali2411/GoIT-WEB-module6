-- Знайти середній бал на потоці (по всій таблиці оцінок).

SELECT ROUND(AVG(g.value), 2) as avg_grade
FROM public.grades g
JOIN public.students_grades sg ON sg.grade_id = g.id
