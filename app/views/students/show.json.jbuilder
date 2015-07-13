json.(@student, :id, :name, :email)
json.cohort(@student.cohort, :id, :name, :kind)