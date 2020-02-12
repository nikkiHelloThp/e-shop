#### un produit ne peut couter plus de 999.99 euro

ajouter plus tard la quantite au model order_product, peut etre aussi le total et le prix unitaire

total = unit price * quantity

utiliser react pour le rendu dynamique

smoothscroll

trop de requetes serveur
=>
Started GET "/cart" for ::1 at 2020-02-07 17:04:05 +0100
Processing by CartsController#show as HTML
  *Order Load* (0.9ms)  SELECT  "orders".* FROM "orders" WHERE "orders"."id" = $1 LIMIT $2  [["id", 10], ["LIMIT", 1]]
  ↳ app/helpers/application_helper.rb:4
  Rendering carts/show.html.erb within layouts/application
  *OrderProduct* Load (0.4ms)  SELECT "order_products".* FROM "order_products" WHERE "order_products"."order_id" = $1  [["order_id", 10]]
  ↳ app/views/carts/show.html.erb:10
  *Product Load* (0.2ms)  SELECT  "products".* FROM "products" WHERE "products"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
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