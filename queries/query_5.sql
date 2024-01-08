-- Знайти які курси читає певний викладач.

SELECT sub.name, t.first_name || ' ' || t.last_name as full_teacher_name
FROM public.subjects sub
JOIN public.teachers_subjects ts on ts.subject_id = sub.id
JOIN public.teachers t on ts.teacher_id = t.id
WHERE t.id = 1