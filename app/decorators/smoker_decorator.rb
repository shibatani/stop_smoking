module SmokerDecorator
  def running_days(created_date)
    today = Date.current
    remain = (today - created_date).to_i 
  end
end
