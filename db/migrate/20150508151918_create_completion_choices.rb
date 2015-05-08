class CreateCompletionChoices < ActiveRecord::Migration
  def change
    create_table :completion_choices do |t|
      t.integer :completion_id, null: false
      t.intger :choice_id, null: false

      t.timestamps null: false
  end
end
