Sequel::Model.plugin(:schema)
Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure

#
# Config your Postgresql connection using the following environment variables
# in production and testing environment:
# * PG_USERNAME, e.g. dungpt
# * PG_PASSWORD, e.g. abcabc
# * PG_HOST, e.g. localhost:3000
# * PG_PORT, e.g. 3000
# * LIBRARY_DB: name of the database, e.g. hust-library
#

DB = Sequel::Model.db =
  case Padrino.env
  # when :development
  #   Sequel.connect "sqlite://bayo-dev.db"
  when :production, :test, :development
    Sequel.connect(
      :adapter  => 'postgres',
      :host     => "#{ENV['PG_HOST']}",
      :port     => "#{ENV['PG_PORT']}",
      :user     => "#{ENV['PG_USERNAME']}",
      :password => "#{ENV['PG_PASSWORD']}",
      :database => "#{ENV['LIBRARY_DB']}",
      :loggers  => [logger]
    )
  end
