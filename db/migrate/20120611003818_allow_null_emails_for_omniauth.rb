class AllowNullEmailsForOmniauth < ActiveRecord::Migration
  def up
    execute("ALTER TABLE users ALTER COLUMN email DROP NOT NULL;")
    execute("DROP INDEX index_users_on_email;")
  end

  def down
    execute("ALTER TABLE users ALTER COLUMN email SET NOT NULL;")
    execute("CREATE UNIQUE INDEX index_users_on_email ON users (email);")
  end
end
