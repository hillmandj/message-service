class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :digest
      t.string :text

      t.timestamps
    end

    add_index :messages, [:digest, :text], unique: true
  end
end
