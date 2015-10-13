module ApplicationHelper

  def anos_options
    anos = Hash.new

    range = (Time.now.year..2015)
    (range.first).downto(range.last).each do |i|
      anos[i]= i
    end
    return anos
  end

  def month_options
    months = []
    (1..12).each {
        |m| months << [I18n.t("date.month_names")[m].humanize, m]
    }
    return months
  end



end
