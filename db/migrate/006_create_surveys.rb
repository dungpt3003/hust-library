Sequel.migration do
  up do
    create_table :surveys do
      primary_key :id
      foreign_key :library_id, :libraries
      String :user_name
      String :user_role
    end

    alter_table :answers do
      drop_foreign_key :library_id
      add_foreign_key :survey_id, :surveys
      drop_column :user_name
      drop_column :user_role
    end
  end

  down do
    alter_table :answers do
      add_foreign_key :library_id, :libraries
      drop_foreign_key :survey_id
      add_column :user_name, String
      add_column :user_role, String
    end
    drop_table :surveys
  end
end
