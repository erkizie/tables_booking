class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :table, null: false, foreign_key: true
      t.timestamp :start_date_time
      t.timestamp :end_date_time

      t.timestamps
    end
  end
end
