class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :name
      t.text :email
      t.text :department
      t.text :message
      t.string :status

      t.timestamps null: false
    end
  end
end
