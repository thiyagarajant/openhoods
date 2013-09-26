module ApplicationHelper
  def admin_user?
    if current_user.present? && current_user.role.name=="admin"
      true
    else
      false
    end
  end

  def is_favorite(user, car)
    fav = Favorite.find_by_user_id_and_vehicle_id(user.id, car.id)
    if fav.present? && fav.active==true
      true
    else
      false
    end
  end
end
