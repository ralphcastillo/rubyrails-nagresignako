class ContactFormController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end

  def create
    logger.info "Sending message"
    begin
      @contact_form = ContactForm.new(params[:contact_form])
      @contact_form.request = request
      if @contact_form.deliver
        logger.info "feedback delivered"
        flash.now[:notice] = 'Thank you for your message!'
      else
        logger.info "feedback not delivered"
        render :new
      end
    rescue ScriptError
      flash[:error] = 'Sorry, this message appears to be spam and was not delivered.'
    end
  end
end
