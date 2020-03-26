module CorevistAPI
  module Services::Paginatable
    extend ActiveSupport::Concern

    included do
      DEFAULT_PAGE_SIZE = 5

      private

      def paginate(hash)
        key = hash.keys.first

        p_size = @params[:page_size].present? ? @params[:page_size].to_i : DEFAULT_PAGE_SIZE
        p_size = p_size < 1 ? 1 : p_size

        p_number = @params[:page].present? ? @params[:page].to_i : 1
        p_number = 0 if p_number <= 1
        p_number = p_number - 1 if p_number > 1


        p_count = (hash[key].size / p_size.to_f).ceil
        p_number = 0 if p_number >= p_count # set to first page if @params[:page] higher than total pages

        total_size = hash[key].size

        items = hash[key].drop(p_size * p_number).first(p_size)

        {
            pagination: {
                total_results: total_size,
                total_pages: p_count,
                page: p_number + 1,
                page_size: p_size,
            },

            key => items.as_json
        }
      end
    end
  end
end
