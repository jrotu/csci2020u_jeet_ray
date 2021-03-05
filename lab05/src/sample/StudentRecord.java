package sample;

public class StudentRecord {
    private String studentID;
    private float assignments;
    private float midterm;
    private float finalExam;

    public StudentRecord(
            String studentID,
            float assignments,
            float midterm,
            float finalExam
    ) {
        this.studentID = studentID;
        this.assignments = assignments;
        this.midterm = midterm;
        this.finalExam = finalExam;
    }

    public String getStudentID() {
        return this.studentID;
    }
    public float getAssignments() {
        return this.assignments;
    }
    public float getMidterm() {
        return this.midterm;
    }
    public float getFinalExam() {
        return this.finalExam;
    }
    public float getFinalMark() {
        return (this.assignments*0.2f)+(this.midterm*0.3f)+(this.finalExam*0.5f);
    }
    public char getLetterGrade() {
        float finalMark = this.getFinalMark();
        if ((finalMark >= 80) && (finalMark <= 100)) {
            return 'A';
        } else if ((finalMark >= 70) && (finalMark <= 79)) {
            return 'B';
        } else if ((finalMark >= 60) && (finalMark <= 69)) {
            return 'C';
        } else if ((finalMark >= 50) && (finalMark <= 59)) {
            return 'D';
        } else {
            return 'F';
        }
    }
}
