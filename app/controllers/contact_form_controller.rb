class ContactFormController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end

  def create
    begin
      @contact_form = ContactForm.new(params[:contact_form])
      @contact_form.request = request
      
      UserMailer.send_feedback(@contact_form).deliver
      
      # if @contact_form.deliver
        flash[:notice] = "Thank you for your message! We\'ll get back to you as soon as possible. Go to #{view_context.link_to('Homepage', new_path)}".html_safe
      # else
        # render :new
      # end
    rescue ScriptError
      flash[:error] = 'Sorry, this message appears to be spam and was not delivered.'
    end
  end
end
