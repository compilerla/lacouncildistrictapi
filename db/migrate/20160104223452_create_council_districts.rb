class CreateCouncilDistricts < ActiveRecord::Migration
  def change
    create_table :council_districts do |t|
      t.integer 'district_number', null: false
       t.geometry :shape
    end
  end
end
