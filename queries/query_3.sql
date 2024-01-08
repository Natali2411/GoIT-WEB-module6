-- Знайти середній бал у групах з певного предмета.

SELECT ROUND(AVG(g.value), 2) as avg_grade, sub.name as subject_name
FROM public.grades g
JOIN public.students_grades sg ON sg.grade_id = g.id
JOIN public.subjects sub ON sub.id = sg.subject_id
WHERE sub.name = 'GEOGRAPHY'
GROUP BY sub.name
