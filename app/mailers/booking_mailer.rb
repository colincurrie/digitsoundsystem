class BookingMailer < ApplicationMailer

  default from: 'bookings@digitsoundsystem.co.uk'

  def booking_request(details)
    @details = details
    mail(to: 'digitsoundsystem@gmail.com', subject: 'You Received A Booking Request')
  end
end
