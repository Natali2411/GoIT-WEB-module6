-- Знайти список курсів, які відвідує студент.

SELECT tt.subject_name
FROM (
    SELECT COUNT(*), sub.name as subject_name
    FROM public.students s
    JOIN public.students_grades sg on s.id = sg.student_id
    JOIN public.subjects sub ON sub.id = sg.subject_id
    WHERE s.id = 10
    GROUP BY sub.name, s.first_name, s.last_name
     ) tt
