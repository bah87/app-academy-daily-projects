function Student (firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.courses = [];
}

Student.prototype.name = function () {
  console.log(`${this.firstName} ${this.lastName}`);
};

Student.prototype.enroll = function (course) {
  if (!this.courses.includes(course)) {
    this.courses.push(course);  
    course.addStudent(this);
  }
};

Student.prototype.courseload = function () {
  let courseLoad = {};
  this.courses.forEach (course => {
    courseLoad[course.department] += course.credits
  });
};

