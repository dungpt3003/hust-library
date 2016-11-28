Sequel.migration do
  up do
    create_table :libraries do
      primary_key :id
      
    end
  end

  down do
    drop_table :libraries
  end
end
