require 'test_helper'

class AuthAndAuthTest < ActionDispatch::IntegrationTest

  # Visitors who have not logged in should only see the login page.
  test "visitors who have not logged in should only see the login page" do

    get root_path
    assert_redirected_to login_path
    follow_redirect!
    assert_template "new"
    assert_select "#notice", 1
    assert_select "input[type=email]", 1
    assert_select "input[type=password]", 1

    get teachers_path
    assert_redirected_to login_path

    get parents_path
    assert_redirected_to login_path

    get students_path
    assert_redirected_to login_path

    get grades_path
    assert_redirected_to login_path

  end

  # Teachers who have logged in should be able to:
  test "teachers who have logged in should be able to do these things" do

    get root_path
    follow_redirect!
    post login_path, email: "mason@example.com", password: "password"
    follow_redirect!

    # Create teachers
    get teachers_path
    assert_template "index"
    get new_teacher_path
    assert_template "new"
    post teachers_path, teacher: {name: "Anjana Mohanty", email: "anjana@gmail.com", password: "abc1234"}
    follow_redirect!
    assert_template "show"
    assert response.body.include?("Anjana Mohanty")

    # Create students (for a particular teacher)
    get students_path
    assert_template "index"
    get new_student_path
    assert_template "new"
    post students_path, student: {name: "Anjana Mohanty", email: "anjana@gmail.com", password: "abc1234", teacher_id: teachers(:one).id}
    follow_redirect!
    assert_template "show"
    assert response.body.include?("Anjana Mohanty")

    # Create parents (for a particular student)
    get parents_path
    assert_template "index"
    get new_parent_path
    assert_template "new"
    post parents_path, parent: {name: "Anjana Mohanty", email: "anjana@gmail.com", password: "abc1234", student_id: students(:one).id}
    follow_redirect!
    assert_template "show"
    assert response.body.include?("Anjana Mohanty")

    # Enter, edit, or delete grades for a student. These grades would
    # indicate a level of detail like "Anne Smith got a B on the 2/4/2015
    # homework", not just "Anne Smith got a B in the class."
    get grades_path
    assert_template "index"
    get new_grade_path
    assert_template "new"
    post grades_path, grade: {assignment_name: "Homework 1", grade: 4, student_id: students(:one).id}
    follow_redirect!
    assert_template "show"

    get grades_path
    assert_template "index"
    assert_select "tbody tr", Grade.count

    # get edit_grade_path, grades(:one) => @grade
    # assert_template "edit"
    # patch grades_path, grade: {id: grades(:one).id, grade: 5}
    # follow_redirect!
    # assert_template "show"
    # assert response.body.include?("5")

  end


  # Students who have logged in should be able to:
  test "students who have logged in should be able to do these things" do
    
    get root_path
    follow_redirect!
    post login_path, email: "mason@example.com", password: "password"
    follow_redirect!

    # See their grades.
  end

  # Students who have logged in should NOT be able to:
    # Create teachers

    # Create students

    # Create parents

    # Enter, edit, or delete grades for a student. These grades would
    # indicate a level of detail like "Anne Smith got a B on the 2/4/2015
    # homework", not just "Anne Smith got a B in the class."


  # Parents who have logged in should be able to:
    # See their student's grades.


  # Parents who have logged in should NOT be able to:
    # Create teachers

    # Create students

    # Create parents

    # Enter, edit, or delete grades for a student. These grades would
    # indicate a level of detail like "Anne Smith got a B on the 2/4/2015
    # homework", not just "Anne Smith got a B in the class."


  # Any user who has logged in should be able to:
    # Change his or her password.

end
