class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.string :name
      t.string :content
      t.timestamps
    end
  end
end
