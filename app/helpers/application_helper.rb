module ApplicationHelper

  def subnet_color ip
    case 
    when ip =~ /^192\.168\.100\.\d+\/24$/ then
      return '#3fc486'
    when ip =~ /^213\.215\.155\.\d+\/27$/ then
      return '#d62d2d'
    when ip =~ /^213\.215\.196\.\d+\/27$/ then
      return '#000'
    when ip =~ /^10\.40[^\/]+\/16$/ then
      return '#000'
    when ip =~ /^10\.41[^\/]+\/16$/ then
      return '#f0be51'
    else
      return '#ccc'
    end
  end

end
