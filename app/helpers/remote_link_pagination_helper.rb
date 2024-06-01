module RemoteLinkPaginationHelper
  class LinkRenderer < WillPaginate::ActionView::LinkRenderer
    def link(text, target, attributes = {})
      attributes['data-turbo-frame'] = 'locations'
      super
    end
  end
end
