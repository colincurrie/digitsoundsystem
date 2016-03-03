class ContactController < ApplicationController

  def show
    @title = 'Contact'
    @contact ||= Contact.new
  end

  def create
    @contact = Contact.new contact_params
    if @contact.valid?
      BookingMailer.booking_request(contact_params).deliver_now
      flash[:notice] = 'Thanks for your request. We will be in touch as soon as possible.'
      redirect_to root_path
    else
      render 'show'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :date, :venue, :details)
  end
end
