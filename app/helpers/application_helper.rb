module ApplicationHelper
  
  def sprite_tag(c) 
    #"<i class='resign-sprite #{c}'></i>"
    content_tag(:i, "", :class => "resign-sprite #{c}")
  end
  
  def is_new?
    action_name == "new"
  end
  
  def is_hot?
    action_name == "hot"
  end
  
  def is_submit?
    action_name == "submit"
  end
  
  def is_topgood?
    action_name == "top_good"
  end
  
  def is_topbad?
    action_name == "top_bad"
  end
end
