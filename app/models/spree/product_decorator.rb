Spree::Product.class_eval do




  def self.best_sellers
    
    config = Spree::BestSellersConfiguration.new
    num_max_best_sellers = config[:max_best_sellers] || 2
    min_order_create_date = config[:min_order_create_date] || 30
    begin
      results = Spree::Product.active.select("spree_products.*,spree_products.id, SUM(spree_line_items.quantity) as total_qty").
          joins(:line_items).joins("INNER JOIN spree_orders ON spree_orders.id = spree_line_items.order_id").
          where("spree_orders.state = 'complete'").group("spree_products.id")
    end
    
    #if results.present?
    #   results = results.group("spree_products.id")
    #end
        #group("spree_line_items.variant_id, spree_products.id")

    unless Spree::Config.show_products_without_price
      results = results.where("spree_prices.amount IS NOT NULL").where("spree_prices.currency" => Spree::Config[:currency])
    end
    
    unless min_order_create_date == 0
      results = results.where("spree_orders.created_at >= ? ",min_order_create_date.days.ago)
    end

    results = results.order("total_qty DESC").limit(num_max_best_sellers)

    return results
  end


end