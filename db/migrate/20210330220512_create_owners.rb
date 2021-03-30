class CreateOwners < ActiveRecord::Migration[6.1]
  def change
    create_table :owners do |t|
      t.string :fname
      t.string :lname
      t.string :username
      t.string :company_name
      t.string :password_digest
      t.string :location

      t.timestamps
    end
  end
end
