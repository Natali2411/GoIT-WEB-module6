-- Список курсів, які певному студенту читає певний викладач.

SELECT tt.subject_name
FROM (
        SELECT COUNT(*), s.name as subject_name
        FROM public.teachers t
        JOIN public.teachers_subjects ts on t.id = ts.teacher_id
        JOIN public.subjects s on ts.subject_id = s.id
        JOIN public.students_grades sg ON sg.subject_id = s.id
        JOIN public.students s2 on s2.id = sg.subject_id
        WHERE t.id = 1 AND s2.id = 1
        GROUP BY s.name, t.first_name, t.last_name, s2.first_name, s2.last_name
) tt

