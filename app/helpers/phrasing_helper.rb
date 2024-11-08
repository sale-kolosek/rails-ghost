module PhrasingHelper
  def can_edit_phrases?
    current_user.present? && current_user.admin?
  end
end
