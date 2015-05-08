class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :survey_id, null: false
      t.text :question, null: false

      t.timestamps null: false
    end
  end
end
