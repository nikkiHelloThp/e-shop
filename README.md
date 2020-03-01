# PROBLEMES A RESOUDRE

top selling products:
first = OrderProduct.all.each{|order_product| order_product}.map{|p| [p.product_id, p.quantity]}
second = first.inject(Hash.new{|h,k| h[k]=[]}){|h, (k,v)| h[k] << v; h}


products = OrderItem.group(:product_id).sum(:quantity)
  ids = products.sort_by {|k,v| v}.reverse.map(&:first)
  where(id: ids)

Add this method in your product model:

def self.order_by_ids(ids)
  order_by = ["case"]
  ids.each_with_index.map do |id, index|
    order_by << "WHEN id='#{id}' THEN #{index}"
  end
  order_by << "end"
  order(order_by.join(" "))
end
Then:

products = OrderItem.group(:product_id).sum(:quantity)
ids = products.sort_by {|k,v| v}.reverse.map(&:first)
where(id: ids)..order_by_ids(ids)




navbar par-dessus contenu, a revoir !

calculer "top selling products" dans dashboard

conflit routes avec product

cart peut etre attribue a un user non authentifie

utiliser react pour le rendu dynamique


trop de requetes serveur
=>
Started GET "/cart" for ::1 at 2020-02-07 17:04:05 +0100
Processing by CartsController#show as HTML
  *Order Load* (0.9ms)  SELECT  "orders".* FROM "orders" WHERE "orders"."id" = $1 LIMIT $2  [["id", 10], ["LIMIT", 1]]
  ↳ app/helpers/application_helper.rb:4
  Rendering carts/show.html.erb within layouts/application
  *OrderProduct* Load (0.4ms)  SELECT "order_products".* FROM "order_products" WHERE "order_products"."order_id" = $1  [["order_id", 10]]
  ↳ app/views/carts/show.html.erb:10
  *Product Load* (0.2ms)  SELECT  "products".* F(vROM "products" WHERE "products"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
  ↳ app/views/carts/show.html.erb:13
  Rendered carts/show.html.erb within layouts/application (3.4ms)
  *User Load* (0.2ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = $1 ORDER BY "users"."id" ASC LIMIT $2  [["id", 1], ["LIMIT", 1]]
  ↳ app/views/layouts/application.html.erb:17
Completed 200 OK in 31ms (Views: 24.3ms | ActiveRecord: 1.6ms)


*pour consulter les routes depuis le navigateur : localhost:3000/rails/info*

ajouter cles sendgrid sur heroku

ajouter amazon S3

template:
  file:///home/nikki/Bureau/directories/bootstrap/Bootstrap%20Themes/UI%20Kit/Purpose-website-ui-kit-v1.1.3/pages/pages-shop.html

Dashboard:
  view-source:file:///home/nikki/Bureau/directories/bootstrap/Bootstrap%20Themes/Dashboard/Hyper_v1.4.0/dist/index.html

- Ajouter:
  categories
  cart pour les invites, connectez vous pour payer (l'utilisateur n'est defini qu'au paiement?, si l'utilisateur n'est pas connecte il a une session)
