class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.string :code
      t.decimal :amount
      t.references :client

      t.timestamps
    end
  end
end
