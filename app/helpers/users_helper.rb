module UsersHelper
  def caluculate_rank_number(i, continue_days)
    if i != 1 
      if @last_running_days == continue_days 
        decide_number
      else 
        increase_number
        decide_number
      end 
    else 
      increase_number
      decide_number
    end 
  end

  def decide_number
    if @rank_number == 1 
      image_tag asset_path("王冠 金.jpeg")
    elsif @rank_number == 2 
      image_tag asset_path("王冠 銀.jpeg")
    elsif @rank_number == 3 
      image_tag asset_path("王冠 銅.jpeg")
    else
      return @rank_number 
    end 
  end

  def increase_number
    if @last_rank_number == 0 && @rank_number == 0
      @last_rank_number = 1
      @rank_number = 1
    else
      @last_rank_number += 1 
      @rank_number += 1
    end
  end

  def calucalate_last_running_days(continue_days)
    @last_running_days = continue_days
  end
end
