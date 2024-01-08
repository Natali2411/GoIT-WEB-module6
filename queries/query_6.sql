-- Знайти список студентів у певній групі.

SELECT g.name as group_name, g.code as group_code, s.first_name || ' ' || s.last_name
    as full_student_name
FROM public.students_groups sg
JOIN public.groups g on sg.group_id = g.id
JOIN public.students s ON sg.student_id = s.id
WHERE g.code = 'Woods'
