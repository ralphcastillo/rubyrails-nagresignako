module ManageAdvertsHelper
  def load_advert(main, alternative)
    if 
      Resignako::Application.assets.find_asset("adverts/#{main}.png").nil? &&
      Resignako::Application.assets.find_asset("adverts/#{main}.gif").nil? &&
      Resignako::Application.assets.find_asset("adverts/#{main}.jpg").nil?

      alternative
    else
      if !Resignako::Application.assets.find_asset("adverts/#{main}.png").nil? 
          "adverts/#{main}.png"
      elsif !Resignako::Application.assets.find_asset("adverts/#{main}.gif").nil?
          "adverts/#{main}.gif"
      elsif !Resignako::Application.assets.find_asset("adverts/#{main}.jpg").nil?
          "adverts/#{main}.jpg"
      end
    end
  end
end