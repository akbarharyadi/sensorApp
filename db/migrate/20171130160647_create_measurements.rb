class CreateMeasurements < ActiveRecord::Migration[5.1]
  def change
    create_table :measurements do |t|
      t.float :value_temp
      t.float :value_hum
      t.int :device_id

      t.timestamps
    end
  end
end
