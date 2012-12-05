class CreateProbabilities < ActiveRecord::Migration
  def change
    create_table :probabilities do |t|
      t.datetime  :date
      t.integer   :prize
      t.integer   :count

      t.timestamps
    end
  end
end
