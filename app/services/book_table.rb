class BookTable
  attr_reader :number_of_seats, :timeslot

  def initialize(number_of_seats, timeslot)
    @number_of_seats = number_of_seats
    @timeslot = timeslot
  end

  def call
    tables = filter_tables
    return if tables.blank?

    table = tables.first
    book(table)
    table
  end

  private

  def filter_tables
    tables = Table.with_number_of_seats(number_of_seats)
    tables - tables.booked_at(timeslot)

    # Also we can do it with an empty SQL using it here or in the scope:
    #
    #   Table.find_by_sql(["SELECT t.*
    #   FROM tables t
    #   WHERE t.id NOT IN
    #   (SELECT tables.id FROM bookings b
    #   INNER JOIN tables on tables.id = b.table_id
    #   WHERE b.start_date_time <= ? AND b.end_date_time >= ?)
    #   AND t.number_of_seats >= ?
    #   ", timeslot, timeslot, number_of_seats])
  end

  def book(table)
    table.bookings.create(start_date_time: timeslot, end_date_time: timeslot.to_datetime + 3.hours)
  end
end
