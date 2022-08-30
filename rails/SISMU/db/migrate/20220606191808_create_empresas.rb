class CreateEmpresas < ActiveRecord::Migration[7.0]
  def change
    create_table :empresas do |t|
      t.string :nombre
      t.string :direccion
      t.integer :tel, limit: 8

      t.timestamps
    end
  end
end
