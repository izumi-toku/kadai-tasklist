class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      # id
      t.string :content
      t.references :user, foreign_key: true # user_id

      t.timestamps
    end
  end
end
