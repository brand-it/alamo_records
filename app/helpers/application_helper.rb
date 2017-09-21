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
  def sortable(th_name, default_order: 'acs', column: nil) # rubocop:disable MethodLength, AbcSize
    directions = %w[asc desc]
    current_direction = params[:order][:direction] if params[:order]
    if current_direction
      directions.delete(current_direction)
    else
      directions.delete(default_order)
    end
    column ||= th_name.downcase.to_sym
    link_to [Artist, { order: { column: column, direction: directions.first } }.merge(search_params)] do
      concat "#{th_name} "
      if directions.first
        concat fa_icon("sort-#{directions.first}")
      else
        concat fa_icon('sort')
      end
    end
  end
end
