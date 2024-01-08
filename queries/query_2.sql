-- Знайти студента із найвищим середнім балом з певного предмета.

SELECT MAX(t.avg_grade) as max_grade, t.student_id, t.first_name, t.last_name
FROM (
	SELECT ROUND(AVG(g.value), 2) as avg_grade, sg.student_id, s.first_name, s.last_name
	FROM public.grades g
	JOIN public.students_grades sg ON sg.grade_id = g.id
	JOIN public.students s ON s.id = sg.student_id
	JOIN public.subjects sub ON sub.id = sg.subject_id
	WHERE sub.name = 'GEOGRAPHY'
	GROUP BY sg.student_id, s.first_name, s.last_name
	) t
GROUP BY t.student_id, t.first_name, t.last_name
ORDER BY max_grade desc
LIMIT 1
