require_relative '../spec_helper'

describe "StudentsController" do
  before(:all) do
    cohort1 = Cohort.create(name: "Ruby-000", kind: "Web")
    cohort2 = Cohort.create(name: "Ruby-001", kind: "Web")

    cohort1.students << Student.create(name: "John Smith", email: "john.smith@gmail.com")
    cohort1.students << Student.create(name: "Pippi Longstocking", email: "pippi.longstocking@gmail.com")
    cohort2.students << Student.create(name: "Harry Potter", email: "harry.potter@gmail.com")

    cohort1.save
    cohort2.save
  end

  after(:all) do
    Student.destroy_all
    Cohort.destroy_all
  end

  describe "GET /students", type: :request do
    before(:all) do
      get '/students'
    end

    it "lists the students" do
      students_array = JSON.parse(response.body)
      expect(students_array.length).to eq(3)
      expect(students_array.first["name"]).to eq("John Smith")
    end

    it "returns a 200 status code" do
      expect(response.status).to eq(200)
    end
  end

  describe "GET /cohorts/:cohort_id/students", type: :request do
    before (:all) do
      id = Cohort.first.id
      get "/cohorts/#{id}/students"
    end

    it "lists only the students of the specified cohort" do
      students_array = JSON.parse(response.body)
      expect(students_array.length).to eq(2)
      expect(students_array.last["name"]).to eq("Pippi Longstocking")
    end

    it "returns a 200 status code" do
      expect(response.status).to eq(200)
    end
  end

  describe "GET /students/:id", type: :request do
    before(:all) do
      id = Student.first.id
      get "/students/#{id}"
    end

    it "returns the correct Student" do
      student_hash = JSON.parse(response.body)
      expect(student_hash["name"]).to eq("John Smith")
    end

    it "returns Student with the associated Cohort" do
      student_hash = JSON.parse(response.body)
      expect(student_hash["cohort"]["name"]).to eq("Ruby-000")
    end

    it "returns a 200 status code" do
      expect(response.status).to eq(200)
    end

    it "returns a 404 status code if :id is invalid" do
      expect{ get '/students/pig' }.to raise_error("Invalid Student ID!")
    end
  end
end