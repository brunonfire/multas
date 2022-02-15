class ApplicationController < ActionController::Base
  before_action :authenticate_user!



  def current_company
    current_user.company
  end

  def admin?
    self.user_type == "admin"
  end

  def manager?
      self.user_type == "manager"
  end

  protected

  def create_msg
    I18n.t("general.messages.create", model: I18n.t("activerecord.models.#{controller_name.classify.underscore}"))
  end

  def update_msg
    I18n.t("general.messages.update", model: I18n.t("activerecord.models.#{controller_name.classify.underscore}"))
  end

  def destroy_msg
    I18n.t("general.messages.delete", model: I18n.t("activerecord.models.#{controller_name.classify.underscore}"))
  end

  def enable_disable_msg status
    I18n.t("general.messages.status", model: I18n.t("activerecord.attributes.statuses.#{status}"))
  end


end
