require_relative '../config'

class AddColumnPoliticians < ActiveRecord::Migration
  def change
    add_column :politicians, :type, :string
  end
end