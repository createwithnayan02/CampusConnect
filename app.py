
from flask import Flask, render_template, request, redirect, url_for
from database import get_db_connection

app = Flask(__name__)


@app.route("/")
def home():
    return render_template("index.html")


@app.route("/jobs")
def jobs():
    connection = get_db_connection()
    cursor = connection.cursor()

    cursor.execute("""
        SELECT
            jobs.title,
            companies.company_name,
            jobs.job_type,
            jobs.location,
            jobs.minimum_cgpa,
            jobs.application_deadline
        FROM jobs
        JOIN companies
            ON jobs.company_id = companies.company_id
        WHERE jobs.status = 'Open'
        ORDER BY jobs.application_deadline;
    """)

    jobs_data = cursor.fetchall()

    cursor.close()
    connection.close()

    return render_template("jobs.html", jobs=jobs_data)
@app.route("/students")
def students():
    connection = get_db_connection()
    cursor = connection.cursor()

    cursor.execute("""
        SELECT
            student_id,
            roll_number,
            name,
            department,
            year,
            cgpa,
            graduation_year
        FROM students
        ORDER BY student_id;
    """)

    students_data = cursor.fetchall()

    cursor.close()
    connection.close()

    return render_template("students.html", students=students_data)
@app.route("/apply", methods=["GET", "POST"])
def apply():
    connection = get_db_connection()
    cursor = connection.cursor()

    if request.method == "POST":
        student_id = request.form["student_id"]
        job_id = request.form["job_id"]

        try:
            cursor.execute("""
                INSERT INTO applications (student_id, job_id)
                VALUES (%s, %s);
            """, (student_id, job_id))

            connection.commit()

        except Exception as e:
            connection.rollback()
            cursor.close()
            connection.close()
            return f"Application failed: {e}"

        cursor.close()
        connection.close()

        return redirect(url_for("applications"))

    cursor.execute("""
        SELECT student_id, name, roll_number
        FROM students
        ORDER BY name;
    """)
    students_data = cursor.fetchall()

    cursor.execute("""
        SELECT jobs.job_id, jobs.title, companies.company_name
        FROM jobs
        JOIN companies
            ON jobs.company_id = companies.company_id
        WHERE jobs.status = 'Open'
        ORDER BY jobs.title;
    """)
    jobs_data = cursor.fetchall()

    cursor.close()
    connection.close()

    return render_template(
        "apply.html",
        students=students_data,
        jobs=jobs_data
    )
@app.route("/applications")
def applications():
    connection = get_db_connection()
    cursor = connection.cursor()

    cursor.execute("""
        SELECT
            applications.application_id,
            students.name,
            jobs.title,
            companies.company_name,
            applications.applied_at,
            applications.status
        FROM applications
        JOIN students
            ON applications.student_id = students.student_id
        JOIN jobs
            ON applications.job_id = jobs.job_id
        JOIN companies
            ON jobs.company_id = companies.company_id
        ORDER BY applications.application_id DESC;
    """)

    applications_data = cursor.fetchall()

    cursor.close()
    connection.close()

    return render_template(
        "applications.html",
        applications=applications_data
    )

if __name__ == "__main__":
    app.run(debug=True)