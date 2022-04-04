-- single insertion
INSERT INTO class (class_no, class_section) VALUES (1, 'A');

--multiple insertion
INSERT INTO student (student_name, fk_class_id) VALUES
('arpan sahu', 1),
('deeptanshu tripathi', 1),
('divyanshu joshi', 1),
('abhishek gourh', 1);

INSERT INTO teacher (teacher_name) VALUES
('rachna dubey'),
('megha kamble'),
('arvind lanka');

INSERT INTO subject (subject_name) VALUES
('DSA'),
('OS'),
('PYTHON'),
('C'),
('C++'),
('NETWORKING');

-- single insertion
INSERT INTO class (class_no, class_section) VALUES (2, 'A');

--multiple insertion
INSERT INTO student (student_name, fk_class_id) VALUES
('arpan1 sahu', 2),
('deeptanshu1 tripathi', 2),
('divyanshu1 joshi', 2),
('abhishek1 gourh', 2);

INSERT INTO classteacher (teacher_name, is_classteacher, fk_class) VALUES
('harendra sharma', True, 1),
('shushma jain', True, 2);

INSERT INTO studentsubjectrelation (student_id, subject_id) VALUES
(1,1),
(1, 2),
(1, 3),
(1,4),
(1, 5),
(1, 6),
(2,1),
(2, 2),
(3, 3),
(3,4),
(4, 5),
(4, 6),
(5,1),
(5, 2),
(6, 3),
(7,4),
(8, 5),
(8, 6);

DO
$func$
BEGIN
    FOR count IN 1..8 LOOP
        FOR teach_count IN 1..3 LOOP
        INSERT INTO studentteacherrelation (student_id, teacher_id) VALUES
        (count,teach_count);
        end LOOP;
    END LOOP;
END;
$func$

