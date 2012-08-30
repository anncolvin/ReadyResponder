class RenameRequiredForToRequiredForPdInCourses < ActiveRecord::Migration
  def change
    rename_column :courses, :required_for, :required_for_pd
    add_column :courses, :required_for_cert, :string
    add_column :courses, :required_for_sar, :string
  end
end
