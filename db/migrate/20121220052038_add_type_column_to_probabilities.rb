class AddTypeColumnToProbabilities < ActiveRecord::Migration
  def change
    add_column :probabilities, :pro_type, :integer, :default => 0
  end
end
