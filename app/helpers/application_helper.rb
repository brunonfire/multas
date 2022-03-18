module ApplicationHelper

  def current_company
    current_user.company
  end

  def options_for_enum enum_name
    model_name = controller_name.classify.constantize
    values = eval("#{model_name}.#{enum_name}")
    values.keys.map { |w| [t("activerecord.attributes.#{enum_name}.#{w}" ), w] }
  end

  def enum_to_name model, enum_name
    value = model.try(enum_name)
    t("activerecord.attributes.#{enum_name.to_s.pluralize}.#{value}") unless value.blank?
  end

  def editing_name
    model_name = controller_name.classify.underscore
    t("general.messages.editing", model: t("activerecord.models.#{ model_name }") )
  end

  def editing_name_fem
    model_name = controller_name.classify.underscore
    t("general.messages.editing2", model: t("activerecord.models.#{ model_name }") )
  end

  def registering_name
    model_name = controller_name.classify.underscore
    t("general.messages.registering", model: t("activerecord.models.#{ model_name }") )
  end
end

module ActionView
  module Helpers
    class FormBuilder
      def date_select(method, options = {}, html_options = {})
        existing_date = @object.send(method)
        formatted_date = existing_date.to_date.strftime("%F") if existing_date.present?
        @template.content_tag(:div, :class => "input-group") do
          text_field(method, :value => formatted_date, :class => "form-control datepicker", :"data-date-format" => "DD-MM-YYYY") +
            @template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon")
        end
      end

      def datetime_select(method, options = {}, html_options = {})
        existing_time = @object.send(method)
        formatted_time = existing_time.to_time.strftime("%d/%m/%Y %I:%M %p") if existing_time.present?
        @template.content_tag(:div, :class => "form-group") do
          text_field(method, :value => formatted_time, :class => "form-control", :id => 'datetimepicker4',  :"data-date-format" => "DD-MM-YYYY hh:mm A")
        end
      end
    end
  end
end

