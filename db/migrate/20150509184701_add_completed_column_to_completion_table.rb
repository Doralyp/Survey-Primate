class AddCompletedColumnToCompletionTable < ActiveRecord::Migration
  def change
    add_column :completions, :completed, :boolean, null: false, default: false
  end
end
