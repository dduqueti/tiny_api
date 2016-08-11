class AddParsingBooleanToPage < ActiveRecord::Migration
  def change
    add_column :pages, :parsing, :boolean, default: true
  end
end
