-- Знайти 5 студентів із найбільшим середнім балом з усіх предметів.

SELECT ROUND(AVG(g.value), 2) as avg_grade, sg.student_id, s.first_name, s.last_name
	FROM public.grades g
	JOIN public.students_grades sg ON sg.grade_id = g.id
	JOIN public.students s ON s.id = sg.student_id
	GROUP BY sg.student_id, s.first_name, s.last_name
	ORDER BY avg_grade desc
    LIMIT 5;
