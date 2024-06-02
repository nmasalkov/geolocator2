require 'will_paginate/view_helpers/action_view.rb'

module RemoteLinkPaginationHelper
  class LinkRenderer < WillPaginate::ActionView::LinkRenderer
    def link(text, target, attributes = {})
      attributes['data-turbo-frame'] = 'locations'
      super
    end
  end
end
