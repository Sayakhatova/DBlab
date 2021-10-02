--1
SELECT distinct (course_id) FROM course WHERE credits > 3;
SElECT distinct (room_number) FROM classroom WHERE building = 'Watson' or building = 'Packard';
SELECT distinct (course_id) FROM course WHERE dept_name = 'Comp. Sci.';
SELECT distinct (course_id) FROM section WHERE semester = 'Fall';
SELECT distinct (name) FROM student WHERE tot_cred > 45 and tot_cred < 90;
SELECT distinct (name) FROM student WHERE name like '%a' or name like '%e' or name like '%i' or name like '%o' or  name like '%u' or name like '%y';
SELECT distinct (course_id) FROM prereq WHERE prereq_id = 'CS-101';

--3
SELECT distinct (name) FROM student, takes WHERE (takes.grade = 'A' or takes.grade = 'A-') and student.dept_name = 'Comp. Sci.' order by name asc;
SELECT distinct (i_ID) FROM advisor, takes WHERE takes.grade = 'B-' or takes.grade = 'C%' or takes.grade = 'F';
SElECT distinct (dept_name) FROM student, takes WHERE takes.grade != 'F' or takes.grade != 'C';
SELECT distinct (name) FROM instructor, takes WHERE takes.grade != 'A';
SELECT distinct (course_id) FROM section, time_slot WHERE time_slot.time_slot_id = section.time_slot_id and (time_slot.end_hr <= 12 and end_min <= 59) or (time_slot.end_hr <=13 and end_min = 0);

--2
SELECT dept_name, avg(salary) as avg_salary from instructor group by dept_name order by avg_salary asc;
SELECT distinct (building) FROM department, course WHERE course.dept_name = department.dept_name group by building having count(*) =
                                                                                                                          (SELECT max(courses) from (
                                                                                                                                                    SELECT count(*) as courses from department, course WHERE course.dept_name = department.dept_name group by building)
                                                                                                                              as courses);
SELECT distinct (dept_name) FROM course group by dept_name having count(*) =
                                                                  (SELECT min(courses) FROM (SELECT count(*) as courses from course group by dept_name)
                                                                      as courses);
SELECT student.ID, name FROM student, course, takes WHERE course.dept_name = 'Comp. Sci.' and takes.ID = student.ID and takes.course_id = course.course_id group by student.ID, name having count('Comp. Sci.') > 3;
SElECT distinct (name) FROM instructor WHERE dept_name = 'Biology' or dept_name = 'Philosophy' or dept_name = 'Music';
SElECT distinct (name) FROM instructor, teaches WHERE teaches.id = instructor.id and year = '2018' and name not in (
SELECT name FROM instructor, teaches WHERE year = '2017' and teaches.id = instructor.id );