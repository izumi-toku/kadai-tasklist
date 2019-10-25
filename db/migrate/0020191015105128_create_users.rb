class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      # id
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps # created_at, updated_at
    end
  end
end
