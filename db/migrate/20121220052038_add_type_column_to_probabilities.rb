class AddTypeColumnToProbabilities < ActiveRecord::Migration
  def change
    add_column :probabilities, :type, :integer, :default => 0
  end
end
