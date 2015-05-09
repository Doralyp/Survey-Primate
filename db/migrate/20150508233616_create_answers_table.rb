class CreateAnswersTable < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :completion_id, null: false
      t.integer :choice_id, null: false

      t.timestamps null: false
    end
  end
end
