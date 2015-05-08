class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.integer :question_id, null: false
      t.text :choice, null: false

      t.timestamps null: false
    end
  end
end
