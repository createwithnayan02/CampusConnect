CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    roll_number VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(15),
    department VARCHAR(100) NOT NULL,
    year INT NOT NULL CHECK (year BETWEEN 1 AND 4),
    cgpa NUMERIC(3,2) NOT NULL CHECK (cgpa BETWEEN 0 AND 10),
    graduation_year INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE companies (
    company_id SERIAL PRIMARY KEY,
    company_name VARCHAR(150) NOT NULL UNIQUE,
    industry VARCHAR(100),
    location VARCHAR(100),
    website VARCHAR(255),
    email VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE skills (
    skill_id SERIAL PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(100)
);


CREATE TABLE jobs (
    job_id SERIAL PRIMARY KEY,
    company_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    job_type VARCHAR(30) NOT NULL
        CHECK (job_type IN ('Internship', 'Full-Time', 'Part-Time')),
    description TEXT,
    location VARCHAR(100),
    minimum_cgpa NUMERIC(3,2)
        CHECK (minimum_cgpa BETWEEN 0 AND 10),
    application_deadline DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Open'
        CHECK (status IN ('Open', 'Closed')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (company_id)
        REFERENCES companies(company_id)
);


CREATE TABLE student_skills (
    student_id INT NOT NULL,
    skill_id INT NOT NULL,
    proficiency_level VARCHAR(20) NOT NULL
        CHECK (proficiency_level IN
        ('Beginner', 'Intermediate', 'Advanced')),

    PRIMARY KEY (student_id, skill_id),

    FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON DELETE CASCADE,

    FOREIGN KEY (skill_id)
        REFERENCES skills(skill_id)
        ON DELETE CASCADE
);


CREATE TABLE applications (
    application_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    job_id INT NOT NULL,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'Applied'
        CHECK (status IN
        ('Applied', 'Shortlisted', 'Interview',
         'Selected', 'Rejected', 'Withdrawn')),

    FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON DELETE CASCADE,

    FOREIGN KEY (job_id)
        REFERENCES jobs(job_id)
        ON DELETE CASCADE,

    UNIQUE (student_id, job_id)
);


CREATE TABLE interviews (
    interview_id SERIAL PRIMARY KEY,
    application_id INT NOT NULL,
    round_name VARCHAR(50) NOT NULL,
    scheduled_at TIMESTAMP NOT NULL,
    mode VARCHAR(20) NOT NULL
        CHECK (mode IN ('Online', 'Offline')),
    result VARCHAR(20)
        CHECK (result IN ('Pending', 'Passed', 'Failed')),
    remarks TEXT,

    FOREIGN KEY (application_id)
        REFERENCES applications(application_id)
        ON DELETE CASCADE
);


CREATE TABLE application_status_history (
    history_id SERIAL PRIMARY KEY,
    application_id INT NOT NULL,
    old_status VARCHAR(20),
    new_status VARCHAR(20) NOT NULL,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (application_id)
        REFERENCES applications(application_id)
        ON DELETE CASCADE
);


-- Indexes

CREATE INDEX idx_jobs_company_id
ON jobs(company_id);

CREATE INDEX idx_student_skills_skill_id
ON student_skills(skill_id);

CREATE INDEX idx_applications_student_id
ON applications(student_id);

CREATE INDEX idx_applications_job_id
ON applications(job_id);

CREATE INDEX idx_interviews_application_id
ON interviews(application_id);

CREATE INDEX idx_status_history_application_id
ON application_status_history(application_id);