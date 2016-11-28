Sequel.migration do
  up do
    create_table :advices do
      primary_key :id
      String :content
    end
  end

  down do
    drop_table :advices
  end
end
