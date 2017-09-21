# frozen_string_literal: true

module ApplicationHelper
  def active_link(link)
    current_page?(link) ? 'active' : ''
  rescue ActionController::UrlGenerationError
    ''
  end

  def export_csv(records)
    params = search_params.merge(order_params)
    link_to(
      [records, { format: :csv }.merge(params)],
      class: 'btn btn-info btn-sm',
      title: 'Export CSV',
      data: { toggle: 'tooltip', placement: 'top' }
    ) do
      fa_icon 'file-text'
    end
  end

  def search_params
    return {} if params[:search].nil?
    { search: { term: params[:search][:term] } }
  end

  # this it total a hack to get the job done. but it works, Rails 5 has make this work a bit more difficult
  # Original I could do merge and stuff like that but thanks to rails 5 I guess that is no longer possible.
  def order_params
    return {} if params[:order].nil?
    { order: { column: params[:order][:column], direction: params[:order][:direction] } }
  end

  # TODO: this is going to require a lot more work to get right
  # also not this is not great because it is not taking into account what the default order is
  # this method is also way to complicated. I need to reduce the complexity by a lot
  # however I don't have time so I am going to go with this hack
  def sortable(name, options: {}, default_order: nil, order_by_key: nil, type: nil)
    icon = ['sort']
    default_direction = default_direction
    if params[:order] && params[:order][:column] == order_by_key.to_s
      current_direction = params[:order][:direction].to_sym
    elsif default_order
      current_direction = default_order.to_sym
    end
    icon = ['sort', type, current_direction].compact.join('-') if current_direction
    next_direction = current_direction == :desc ? :asc : :desc
    new_params = self.params.dup
    options = { class: icon }.merge(options)
    new_params.merge!(order: { column: order_by_key, direction: next_direction })
    new_params.permit!
    link_to new_params, options do
      "#{name} #{fa_icon(icon)}".html_safe
    end
  end
end
