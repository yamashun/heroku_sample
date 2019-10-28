module BaseApp
  class Client
    module Items
      def items
        @res = get_call_api('/1/items', {})
      end

      def items_search(q)
        @res = get_call_api('/1/items/search', { q: q })
      end

      def items_detail(item_id)
        @res = get_call_api("/1/items/detail/#{iditem_id}")
      end

      def items_add(params)
        @res = post_call_api('/1/items/add', params)
      end

      def items_edit(params)
        @res = post_call_api('/1/items/edit', params)
      end

      def items_delete(item_id)
        @res = post_call_api('/1/items/delete', { item_id: item_id })
      end

      def items_add_image(params)
        @res = post_call_api('/1/items/add_image', params)
      end
    end
  end
end
