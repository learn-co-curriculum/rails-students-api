require_relative '../spec_helper'

describe "CohortsController" do
  before(:all) do
    (0..3).each do |number|
      Cohort.create(name: "Ruby-00#{number}", kind: "Web")
    end
  end

  after(:all) do
    Cohort.destroy_all
  end

  describe "GET /cohorts", type: :request do
    before(:all) do
      get '/cohorts'
    end

    it "lists the Cohorts" do
      cohorts_array = JSON.parse(response.body)
      expect(cohorts_array.length).to eq(4)
      expect(cohorts_array.first["name"]).to eq("Ruby-000")
    end

    it "returns a 200 status code" do
      expect(response.status).to eq(200)
    end
  end

  describe "GET /cohorts/:id", type: :request do
    before(:all) do
      id = Cohort.first.id
      get "/cohorts/#{id}"
    end

    it "returns the correct Cohort" do
      cohort_hash = JSON.parse(response.body)
      expect(cohort_hash["name"]).to eq("Ruby-000")
    end

    it "returns a 200 status code" do
      expect(response.status).to eq(200)
    end

    it "returns a 404 status code if :id is invalid" do
      expect{ get '/cohorts/pig' }.to raise_error("Invalid ID!")
    end
  end

  describe "POST /cohorts", type: :request do
    before(:all) do
      post "/cohorts", cohort: {name: "Ruby-004", kind: "Web"}
    end

    it "creates a Cohort" do
      cohort = Cohort.last
      expect(cohort.name).to eq("Ruby-004")
    end

    it "returns a 201 status code" do
      expect(response.status).to eq(201)
    end
  end

  describe "PATCH /cohorts/:id", type: :request do
    before(:all) do
      id = Cohort.first.id
      patch "/cohorts/#{id}", cohort: {name: "Web-0912"}
    end

    it "updates the correct Cohort" do
      cohort = Cohort.first
      expect(cohort.name).to eq("Web-0912")
    end

    it "returns a 202 status code" do
      expect(response.status).to eq(202)
    end

    it "returns a 404 status code if :id is invalid" do
      expect{ patch '/cohorts/pig', cohort: {name: "Web-0912"} }.to raise_error("Invalid ID!")
    end
  end

  describe "DELETE /cohorts/:id", type: :request do
    before(:all) do
      id = Cohort.last.id
      delete "/cohorts/#{id}"
    end

    it "deletes the correct Cohort" do
      cohort = Cohort.last
      expect(cohort.name).to eq("Ruby-003")
    end

    it "returns a 202 status code" do
      expect(response.status).to eq(202)
    end

    it "returns a 404 status code if :id is invalid" do
      expect{ delete '/cohorts/pig' }.to raise_error("Invalid ID!")
    end
  end
end