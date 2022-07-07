class Table < ApplicationRecord
  has_many :bookings

  scope :with_number_of_seats, ->(number_of_guests) { where("number_of_seats >= ?", number_of_guests) }
  scope :booked_at, ->(time) {
    left_joins(:bookings).where("bookings.start_date_time <= ? AND bookings.end_date_time >= ?", time, time).distinct
  }
end
