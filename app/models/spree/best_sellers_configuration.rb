class Spree::BestSellersConfiguration < Spree::Preferences::Configuration

  preference :show_best_sellers, :boolean, :default => false
  preference :max_best_sellers, :string, :default => 2
  preference :show_best_sellers_sidebar, :boolean, :default => false
  preference :min_order_create_date, :integer, :default => 30
end
