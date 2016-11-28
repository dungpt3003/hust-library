Sequel.migration do
  up do
    create_table :answers do
      primary_key :id
      foreign_key :question_id, :questions
      foreign_key :library_id, :libraries
      String :user_name
      String :user_role
      Integer :min_score
      Integer :per_score
      Integer :des_score
    end
  end

  down do
    drop_table :answers
  end
end
