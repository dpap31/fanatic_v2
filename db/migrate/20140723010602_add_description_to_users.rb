class AddDescriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :description, :text, default: "Cred YOLO mlkshk flexitarian, mustache beard Cosby sweater crucifix farm-to-table 3 wolf moon dreamcatcher asymmetrical gastropub swag. Flexitarian art party slow-carb food truck, ethical Blue Bottle twee 90's VHS messenger bag 8-bit. Photo booth vinyl bespoke you probably haven't heard of them. Etsy tousled four loko YOLO, pickled tote bag Williamsburg. High Life squid ethnic, Schlitz chillwave cliche American Apparel pour-over pop-up quinoa. Mixtape disrupt selvage, pop-up Shoreditch keffiyeh ethical Intelligentsia Brooklyn direct trade locavore Thundercats banjo. Swag mlkshk post-ironic, messenger bag viral art party Schlitz. Disrupt leggings Pinterest post-ironic wolf Tumblr. Craft beer iPhone actually Thundercats keytar raw denim. Hella Cosby sweater letterpress, Kickstarter kitsch gentrify kale chips lomo aesthetic Etsy Pinterest plaid. Brunch bicycle rights deep v church-key. Sriracha raw denim authentic try-hard umami whatever. Ethnic fingerstache twee, narwhal occupy fap butcher XOXO keytar selfies you probably haven't heard of them craft beer roof party crucifix normcore. Tattooed Truffaut Pinterest cardigan art party, craft beer Helvetica Godard typewriter synth fingerstache lo-fi distillery meh Marfa"
  end
end
