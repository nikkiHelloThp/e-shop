#### un produit ne peut couter plus de 999.99 euro

ajouter plus tard la quantite au model order_product, peut etre aussi le total et le prix unitaire

total = unit price * quantity

utiliser react pour le rendu dynamique

utiliser cookies a la place de session

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

## ACTIVE STORAGE
2 tables dans ta BDD :
  active_storage_blobs
  active_storage_attachments
Pour installer Active Storage sur ton app, lance $ rails active_storage:install
Par curiosité, va dans ton dossier /db/migrate/pour jeter un œil à la migration

Prenons l'exemple de nos users à qui on va vouloir attribuer un avatar (une photo de profil quoi). La première étape est d'indiquer au model User qu'il pourra être lié à un objet d'Active Storage portant le nom avatar (c'est nous qui avons décidé de l'appeler comme ça. On aurait pu choisir profil_picture). Il faut utiliser la mention has_one_attached ou has_many_attached dans le code du model

Tu peux tester si une instance dispose d'un avatar en faisant user.avatar.attached?. Il te retourne le booléen correspondant.

Tu peux permettre l'upload de fichier en utilisant un formulaire de type <%= form.file_field :avatar %> dans ta view.

Finalement, tu peux lier à un user l'avatar fraîchement uploadé, depuis le controller qui traite le formulaire d'upload. Cela se fait ainsi : user.avatar.attach(params[:avatar])

dans la vue
<%if @user.avatar.attached?%>
  <%= image_tag @user.avatar, alt: 'avatar' %>
<%else%>
  <p>=== Il n'y a pas encore d'avatar lié à cet utilisateur ===</p>
<%end%>

Nous allons le faire en form_tag et du coup inclure dedans le champ <%= file_field_tag :avatar %> qui va rajouter dans la view un bouton permettant d'aller sélection un fichier à uploader.
<%= form_tag do %>
  <%= file_field_tag :avatar %>
  <%= submit_tag "uploader l'avatar" %>
<% end %>

Un controller avatars
 Bien que ceux-ci ne sont pas des entrées à part entière de notre BDD, nous leur consacrons quand même un controller afin de gérer leur suppression/ajout. Et bien ici, on va faire pareil avec les avatars ! En effet, bien qu'ils ne constituent pas une entrée en BDD (ils sont juste un lien entre les entrées Active Storage et les entrées de nos users), les avatars peuvent être considérés comme une ressource à part entière.

Tu vas donc créer un avatars_controller.

Celui-ci va héberger une méthode create qui aura pour rôle d'ajouter un avatar à un user donné. Voici le contenu du controller :

class AvatarsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @user.avatar.attach(params[:avatar])
    redirect_to(user_path(@user))
  end
end

Évidemment, pour que cette méthode create fonctionne (notamment la partie avec params[:user_id]), il faut une route adéquate. Cette route sera, sans surprise resources :avatars, only: [:create]. Mais par contre, elle doit contenir l'information "sur quel utilisateur travaille-t-on ?", autrement dit, elle doit contenir l'id d'un user : on va donc imbriquer la route dans le resources :users pour lui rajouter un /users/user_id/ en amont.
Ça donne :

Rails.application.routes.draw do
  resources :users, only: [:show] do
    resources :avatars, only: [:create]
  end
end

Le formulaire d'upload complet
Dans la partie 3.2.5, on avait un embryon de formulaire, mais il était incomplet. Il manquait deux choses pour qu'il puisse fonctionner :

Lui indiquer la route qu'il doit pointer (par défaut, form_tag est déjà en POST donc ça, c'est ok) ;
Rajouter un élément indispensable à un form_tag lorsqu'on veut qu'il puisse uploader des fichiers : l'option multipart: true
Rajoute donc le formulaire suivant à la fin du fichier show.html.erb :

<h3>Changer d'avatar ?</h3>
<%= form_tag user_avatars_path(@user), multipart: true do %>
  <%= file_field_tag :avatar %>
  <%= submit_tag "mettre à jour" %>
<% end %>
