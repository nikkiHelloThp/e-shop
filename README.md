
# PROBLEMES A RESOUDRE

calculer "top selling products" dans dashboard
OrderProduct.where(created_at: 1.month.ago..Time.now)


flash messages perdus dans la navbar transparente

cart peut etre attribue a un user non authentifie

https://www.youtube.com/watch?time_continue=20&v=EIvizoMrWvY&feature=emb_logo
21minutes


top selling products:
first = OrderProduct.all.each{|order_product| order_product}.map{|p| [p.product_id, p.quantity]}
second = first.inject(Hash.new{|h,k| h[k]=[]}){|h, (k,v)| h[k] << v; h}


products = OrderItem.group(:product_id).sum(:quantity)
  ids = products.sort_by {|k,v| v}.reverse.map(&:first)
  where(id: ids)


ajouter cles sendgrid sur heroku

ajouter amazon S3
