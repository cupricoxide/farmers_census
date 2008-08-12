class AddStaticPages < ActiveRecord::Migration
  def self.up
    Page.create(:name => "About the Project",
      :permalink => "about",
      :content => "We're *excited* to use this project to make visual the impact of a swelling new force on the American landscape. There are patriots working in this country today whose commitment to the freedom of the nation is exhibited in their fierce loyalty to its citizens, to their nutrition, their water, their open space, their health and their independence. Farmers have been here all along, but in this time especially of high energy costs, sinking dollar, and the changing climate--local food production has become a key puzzle piece, and with the current agricultural community reaching retirement age, recruitment has become a critical motive. 

      America has always respected its farmers ideologically, but the financial and social rewards have not always followed. The time has come for us to embrace farming and its practitioners--to recognize their service, to praise them, and to pay them a living wage. The time has come for the agricultural arts, so valued by our forefathers, to inspire the best, brightest and most dedicated young people to enter the field. Farming is hard work, it is good work, it is bold work. Farming means nurturing the interface of humanity and ecology, cherishing that delicate, complex and fragrant soil. Bringing forth food, life and a sustained well being for this country.

      We challenge the eaters, thinkers, mothers, markets and policy makers of this country-- to support the young farmers. We challenge the ecologists, humanists, activists, pacifists and survivalists to join in this movement. We vote with our fork, we vote with our vote, let us vote with our lives-- and restore agriculture, that delicious foundation of our human society. It is hard work, and we can only do it together." )
        
    Page.create(:name => "Sponsors",
      :permalink => "sponsors",
      :content => "!http://www.organicvalley.coop/fileadmin/templates/images/logos/ov_logo01.gif!")
      
  end

  def self.down
  end
end