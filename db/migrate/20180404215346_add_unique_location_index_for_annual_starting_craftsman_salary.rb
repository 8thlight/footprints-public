class AddUniqueLocationIndexForAnnualStartingCraftsmanSalary < ActiveRecord::Migration
  def change
    add_index :annual_starting_craftsman_salaries, :location, unique: true
  end
end
