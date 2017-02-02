class ContactsController < ApplicationController
  
  # GET Request to /contact-us
  # Show new contact form
  def new
    @contact = Contact.new
  end
  
  # POST request /contacts
  def create
    # Mass asignment of form fields into contact object
    @contact = Contact.new(contact_params)
    # Save the contact object to the database
    if @contact.save
      # Store form fields via params into variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      # Plug variables into contact mailer
      # email method and send email
      ContactMailer.contact_email(name, email, body).deliver
      # store success message in flash hash
      # and redirect to the action
      flash[:success] = "Message sent."
      redirect_to new_contact_path
    else
      # if contact object doesnt save
      # store errors in flash hash
      # and redirect to the new action
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end  
  end  
  
  private
  # to collet data from form we need to use
  # strong params and whitelist form fields
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end  
end