class AddAutoGeneratedPasswordToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :auto_generated_password, :boolean, default: false
  end
end
