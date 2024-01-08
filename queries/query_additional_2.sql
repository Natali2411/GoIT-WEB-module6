-- Оцінки студентів у певній групі з певного предмета на останньому занятті.

SELECT tt.*, gg2.value as grade_value
FROM (
        SELECT MAX(sg.id) as max_student_grade_id, MAX(sg.created_at) as max_created_at,
        s.first_name || '' || ' ' || s .last_name as
        full_student_name, s.id as student_id, g2.code, sub.name as subject_name,
        sub.id as subject_id
        FROM public.students_grades sg
        JOIN public.students s ON s.id = sg.student_id
        JOIN public.subjects sub ON sub.id = sg.subject_id
        JOIN public.students_groups sgr ON sgr.student_id = s.id
        JOIN public.groups g2 on sgr.group_id = g2.id
        WHERE sub.name = 'LITERATURE' AND g2.code = 'Smith'
        GROUP BY s.first_name, s.last_name, g2.code, sub.name, s.id, sub.id
     ) tt
JOIN public.students_grades sg2 ON sg2.id = tt.max_student_grade_id
JOIN public.grades gg2 ON gg2.id = sg2.grade_id
ORDER BY tt.full_student_name