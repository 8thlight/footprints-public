class AddUniqueIndicesToApplicants < ActiveRecord::Migration
  def change
    add_index :applicants, :code_submission, unique: true
    add_index :applicants, :email, unique: true
  end
end
