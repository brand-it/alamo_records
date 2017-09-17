# frozen_string_literal: true

<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= file_name %>, only: [:show, :edit, :update, :destroy]

<% unless options[:singleton] -%>
  def index
    @<%= table_name %> = <%= class_name %>.page(params[:page])
    respond_with(@<%= table_name %>)
  end
<% end -%>

  def show; end

  def new
    @<%= file_name %> = <%= orm_class.build(class_name) %>
    respond_with(@<%= file_name %>)
  end

  def edit; end

  def create
    @<%= file_name %> = <%= orm_class.build(class_name, "#{file_name}_params") %>
    @<%= orm_instance.save %>
    respond_with(@<%= file_name %>)
  end

  def update
    @<%= orm_instance.update("#{file_name}_params") %>
    respond_with(@<%= file_name %>)
  end

  def destroy
    @<%= orm_instance.destroy %>
    respond_with(@<%= file_name %>)
  end

  private
    def set_<%= file_name %>
      @<%= file_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end
    <%- if defined?(ActionController::StrongParameters) -%>

    def <%= "#{file_name}_params" %>
      <%- if attributes_names.empty? -%>
      params[:<%= file_name %>]
      <%- else -%>
      params.require(:<%= file_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
    <%- end -%>
end
<% end -%>