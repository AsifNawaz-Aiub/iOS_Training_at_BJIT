import UIKit

// Md. Asif Nawaz 30018

struct Course {
    var courseCode : String
    var credit : Int
    var gpa: Double
}

struct Student {
    static private var totalStudents = 0
    private var id : String
    private var department : String = "CSE"
    private var courses : [Course] = []
    
    mutating func addCourse (course: Course) ->() {
        courses.append(course)
    }
    
    private var earnedCredits: Int {
        var totalCreditsEarned = 0
        for eachValue in courses {
            totalCreditsEarned = totalCreditsEarned + eachValue.credit
        }
        return totalCreditsEarned
    }
    private var cgpa : Double {
        var totalGpaXCreditEarned: Double = 0.00
        for eachValue in courses {
            totalGpaXCreditEarned = (eachValue.gpa * Double(eachValue.credit)) + totalGpaXCreditEarned
        }
        return (totalGpaXCreditEarned/Double(earnedCredits))
    }
    
    func getCreditsEarned () -> Int{
        return self.earnedCredits
    }
    func getCGPA () -> Double{
        return self.cgpa
    }
    
    func getTotalStudents () -> Int{
        return Student.totalStudents
    }
    
    func getId()-> String {
        return self.id
    }
    
    init(id: String){
        self.id = id
        Student.totalStudents = Student.totalStudents + 1
    }
    
    init(id: String, department: String){
        self.id = id
        self.department = department
        Student.totalStudents = Student.totalStudents + 1
    }
}

var s1 = Student(id: "1")
var s2 = Student(id: "2",department: "EEE")

s1.addCourse(course: Course(courseCode: "CSE105", credit: 4, gpa: 3.7))
s1.addCourse(course: Course(courseCode: "CSE107", credit: 4, gpa: 3.5))
s1.addCourse(course: Course(courseCode: "CSE205", credit: 3, gpa: 3.7))
s1.addCourse(course: Course(courseCode: "CSE207", credit: 4, gpa: 3.5))
s1.addCourse(course: Course(courseCode: "CSE225", credit: 4, gpa: 4.0))
s1.addCourse(course: Course(courseCode: "CSE245", credit: 4, gpa: 3.3))

s2.addCourse(course: Course(courseCode: "CSE105", credit: 4, gpa: 3.7))
s2.addCourse(course: Course(courseCode: "CSE107", credit: 4, gpa: 3.5))
s2.addCourse(course: Course(courseCode: "CSE205", credit: 3, gpa: 3.7))
s2.addCourse(course: Course(courseCode: "CSE207", credit: 4, gpa: 3.5))
s2.addCourse(course: Course(courseCode: "CSE225", credit: 4, gpa: 4.0))
s2.addCourse(course: Course(courseCode: "CSE245", credit: 4, gpa: 3.3))

print("Student Id: \(s1.getId()) Total Credits : ",s1.getCreditsEarned())
print("Student Id: \(s1.getId()) CGPA : ",s1.getCGPA())

print("Student Id: \(s2.getId()) Total Credits : ",s2.getCreditsEarned())
print("Student Id: \(s2.getId()) CGPA : ",s2.getCGPA())

//print(s1.getCGPA())
//print(s1.getTotalStudents())
//print(s2.getCreditsEarned())
//print(s2.getCGPA())

print("Total Students = ",s2.getTotalStudents())
