CREATE TABLE AbstractBaseClass(
    created timestamptz not null default current_timestamp,
    updated timestamptz,
    is_deleted BOOLEAN default false
);

CREATE TABLE Class(
    class_id SERIAL PRIMARY KEY ,
    class_no INT,
    class_section CHARACTER
) INHERITS (AbstractBaseClass);


-- Primary key-Foreign key relationship. One to Many
CREATE TABLE Student(
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100),
    fk_class_id INT REFERENCES Class(class_id)
)  INHERITS (AbstractBaseClass);

CREATE TABLE Subject(
    subject_id SERIAL PRIMARY KEY,
    subject_name VARCHAR(200),
    fk_student_id INT REFERENCES  Student(student_id)
)  INHERITS (AbstractBaseClass);

CREATE TABLE Teacher(
    teacher_id SERIAL PRIMARY KEY,
    teacher_name VARCHAR(200)
)  INHERITS (AbstractBaseClass);

--  Many to Many
CREATE TABLE StudentTeacherRelation(
    student_id SERIAL NOT NULL ,
    teacher_id INT NOT NULL ,
    foreign key (student_id) REFERENCES Student(student_id),
    foreign key (teacher_id) REFERENCES Teacher(teacher_id)
)  INHERITS (AbstractBaseClass);

CREATE TABLE StudentSubjectRelation(
    student_id SERIAL NOT NULL ,
    subject_id INT NOT NULL ,
    foreign key (student_id) REFERENCES Student(student_id),
    foreign key (subject_id) REFERENCES Subject(subject_id)
)  INHERITS (AbstractBaseClass);

-- Primary key-Unique foreign key One to One Relationship
-- Inheriting from Teacher
CREATE TABLE ClassTeacher(
    is_classteacher BOOLEAN default FALSE,
    fk_class INT REFERENCES Class (class_id)
)  INHERITS (Teacher);

ALTER TABLE Subject
DROP COLUMN fk_student_id;