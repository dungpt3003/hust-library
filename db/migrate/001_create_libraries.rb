Sequel.migration do
  up do
    create_table :libraries do
      primary_key :id
      String :name
      String :address
      String :phone
      Float :p_access
      Float :p_access_point
      Float :p_query
      Float :p_megabyte
    end
  end

  down do
    drop_table :libraries
  end
end
