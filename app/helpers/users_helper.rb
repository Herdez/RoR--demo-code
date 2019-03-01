module UsersHelper


  def all_months(type)
    User.where.not(type.to_sym => nil).order(type.to_sym).group_by {|u| u.send(type).strftime("%Y%m")}.keys
  end

  def all_months_names
    all_months.map do |d|
      "#{Date::MONTHNAMES[d[-2..-1].to_i]}-#{d[0..3]}"
    end
  end

  def users_where_month_and_year(date,type)
    User.send("with_#{type}").order("mode DESC").where("extract(month from #{type}) = ? and extract(year from #{type}) = ?",date[-2..-1],date[0..3])
  end


  def user_graph_class(user)
    color_class = ""

    if user.status == "Potencial"
      color_class << " c_potencial"
    elsif user.status == "Interno" 
      color_class << " c_interno"
    elsif user.status == "Baja"
      if user.fase < 1
        color_class << " c_baja c_baja_completa"
      else
        color_class << " c_baja"
      end
    elsif user.status == "Admin"
       # this code has been delete for this demo
       ...

    end 

    if user.status == "Graduado"
       color_class << " c_graduado" 
    end

    if user.status == "Potencial"
      color_class << " c_potencial"
    end   
    
    ...
      
  end 

  def user_dismiss_by_course
    hash = User.dismiss.order(:mode,:fase).group(["mode","fase"]).count
    new_hash = Hash.new(0)
    hash.each do |k,v|
      if ["MTM","MTT"].include?(k[0])
        new_hash[["MT",k[1]]] += v
      else
        new_hash[k] = v
      end
    end
    new_hash
  end

  ...

end










