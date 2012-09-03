module ApplicationHelper
  def todate(time)
    Time.at(time/1000).to_date
  end
end
