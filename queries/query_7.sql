-- Знайти оцінки студентів у окремій групі з певного предмета.

SELECT s.first_name || ' ' || s.last_name as full_student_name, g.value as grade_value,
    g2.code, sub.name as subject_name
	FROM public.grades g
	JOIN public.students_grades sg ON sg.grade_id = g.id
	JOIN public.students s ON s.id = sg.student_id
	JOIN public.subjects sub ON sub.id = sg.subject_id
	JOIN public.students_groups sgr ON sgr.student_id = s.id
	JOIN public.groups g2 on sgr.group_id = g2.id
	WHERE sub.name = 'LITERATURE' AND g2.code = 'Woods'