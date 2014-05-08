class CreateIcons < ActiveRecord::Migration
  def change
    create_table :icons do |t|
      t.integer :user_id
      t.string :name
      t.binary :content
      t.string :original_filename

      t.timestamps
    end
  end
end
