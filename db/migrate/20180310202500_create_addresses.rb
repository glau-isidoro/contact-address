class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.references :user, foreign_key: true
      t.string :cep
      t.string :city
      t.string :state
      t.string :neighborhood
      t.string :street
      t.string :number
      t.string :complement

      t.timestamps
    end
  end
end
