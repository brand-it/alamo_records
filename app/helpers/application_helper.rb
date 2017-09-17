# frozen_string_literal: true

module ApplicationHelper
  def active_link(link)
    current_page?(link) ? 'active' : ''
  rescue ActionController::UrlGenerationError
    ''
  end
end
