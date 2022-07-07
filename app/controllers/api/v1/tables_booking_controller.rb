class Api::V1::TablesBookingController < ApplicationController
  protect_from_forgery with: :null_session

  def book
    table = BookTable.new(params[:number_of_seats], params[:timeslot]).call
    if table
      render json: table
    else
      render json: { message: "Sorry, there are no free table for that time" }
    end
  end
end
