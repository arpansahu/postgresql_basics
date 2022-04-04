--inner join

SELECT * from student s
INNER JOIN classteacher ct
on s.fk_class_id = ct.fk_class;

--left join

SELECT * from student s
LEFT JOIN studentsubjectrelation s2
on s.student_id = s2.student_id;

--left outer join (just add a null cond with where)

SELECT * from student s
LEFT JOIN studentsubjectrelation s2
on s.student_id = s2.student_id
WHERE s2.student_id is NULL;

--right join

SELECT * from student s
RIGHT JOIN studentsubjectrelation s2
on s.student_id = s2.student_id;

--right outer join
SELECT * from student s
RIGHT JOIN studentsubjectrelation s2
on s.student_id = s2.student_id
WHERE s2.student_id is NULL;

--full outer join
SELECT * from student s
FULL OUTER JOIN studentsubjectrelation s2
on s.student_id = s2.student_id;

--full outer join non matching rows

SELECT * from student s
FULL OUTER JOIN studentsubjectrelation s2
on s.student_id = s2.student_id
WHERE s.student_id is NULL or s2.student_id is NULL;


--natural join (LEFT, RIGHT, INNER)

SELECT  * from studentteacherrelation
NATURAL JOIN student;

--or which is equivalent to
SELECT * FROM studentteacherrelation
INNER JOIN student USING (student_id);


--cross join n*m rows

SELECT * FROM student
CROSS JOIN studentteacherrelation;\

--or which is equivalent to

SELECT * FROM student
INNER JOIN studentteacherrelation ON true;

--self join using tow different aliases of same table
SELECT * from studentteacherrelation s1
INNER JOIN studentteacherrelation s2
ON s1.student_id = s2.teacher_id;
