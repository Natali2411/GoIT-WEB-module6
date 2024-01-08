-- Середній бал, який певний викладач ставить певному студентові.

SELECT ROUND(AVG(g.value), 2) as avg_grade, sg.student_id,
       s.first_name || ' ' || s.last_name as full_student_name, t.id as teacher_id,
       t.first_name || ' ' || t.last_name as full_teacher_name
	FROM public.grades g
	JOIN public.students_grades sg ON sg.grade_id = g.id
	JOIN public.students s ON s.id = sg.student_id
	JOIN public.subjects sub ON sub.id = sg.subject_id
    JOIN public.teachers t ON t.id = sg.subject_id
	WHERE t.id = 1 AND s.id = 1
	GROUP BY sg.student_id, s.first_name, s.last_name, t.id;