module UsersHelper
  def gravatar_for(user = nil, obj = {} )
    gravatar_id = Digest::MD5::hexdigest("rapi.castillo@gmail.com") #user.email.downcase
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, class: ("gravatar " + obj[:class])) #alt: user.name, 
  end
end
