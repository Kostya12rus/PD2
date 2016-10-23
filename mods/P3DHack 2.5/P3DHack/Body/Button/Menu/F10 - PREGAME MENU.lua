local path = "P3DHack/Body/PreGameAssets/"
 
if not PreGameMenu then

	-- ADD Continental Coins
local function give_cc(value)
	local current = Application:digest_value(managers.custom_safehouse._global.total)
	local future = current + value
	Global.custom_safehouse_manager.total = Application:digest_value(future, true)
end
	--Continental Coins
	-- Progress all Trophies
local function give_trophies()
	for k, v in pairs(Global.custom_safehouse_manager.trophies) do
		for foo, bar in pairs (v.objectives) do
			managers.custom_safehouse:update_progress("progress_id", v.objectives[foo].progress_id, v.objectives[foo].max_progress)
		end
		managers.custom_safehouse:update_progress("progress_id", "trophy_stealth", 15)
	end
end
--Progress all Trophies
	-- LEVEL
	local function change_level(level)
		managers.experience:_set_current_level(level)
	end

	local function add_exp(value)
		managers.experience:debug_add_points(value, false)
	end

	-- MONEY
	local function add_money(value)
		managers.money:_add_to_total(value)
	end

	local function reset_money()
		managers.money:reset()
	end

	-- SKILL POINTS
	local function set_skillpoints(value)
		managers.skilltree:_set_points(value)
	end
   
	-- ADD PERK POINTS
	local function set_perkpoints(xp)
		managers.skilltree:give_specialization_points(xp)
	end
   
	-- RESET PERK POINTS
	local function reset_perkpoints()
		managers.skilltree._global.specializations.points = 0
	end
   
	-- UNLOCK ALL PERKS
	local function unlockperks()   
		for _, specialization in ipairs(tweak_data.skilltree.specializations) do
			for _, tree in ipairs(specialization) do
				if (tree.upgrades) then
					for _, upgrade in ipairs(tree.upgrades) do
						managers.upgrades:aquire(upgrade, false)
					end
				end
			end
		end
	end
   
	-- UNLOCK ALL SKILLS
	local function unlock_all_skills()
		set_skillpoints(725)
	   
		for tree_id,tree_data in pairs(Global.skilltree_manager.trees) do
			if not tree_data.unlocked then
				managers.skilltree:unlock_tree(tree_id)
			end		   
			for _,skills in pairs(tweak_data.skilltree.trees[tree_id].tiers) do
				for _,skill_id in ipairs(skills) do
					managers.skilltree:unlock(tree_id, skill_id)
				end    
			end    
		end    
	end

	-- Infamy
	local function set_infamy_level(level)
		managers.experience:set_current_rank(level)
	end

	local function set_infamy_points(value)
		managers.infamy:_set_points(value)
	end

	-- Inventory
	local function unlock_slots()
		for i = 1, 300 do
			Global.blackmarket_manager.unlocked_mask_slots[i] = true
			Global.blackmarket_manager.unlocked_weapon_slots.primaries[i] = true
			Global.blackmarket_manager.unlocked_weapon_slots.secondaries[i] = true
		end    
	end
   
	local function unlock_items(item_type)
	--unlock_items
	--Purpose: unlocks all blackmarket items.

local unlock_items_category, unlock_all_items, unlock_weapons, get_global_value

unlock_items = function(item_type)
	if item_type == "all" then
		unlock_all_items()
	elseif item_type == "weapons" then
		unlock_weapons()
	else
		unlock_items_category(item_type)
	end
end

unlock_all_items = function()
	local types = {"weapon_mods", "masks", "materials", "textures", "colors"}
	for _, item_type in pairs(types) do
		unlock_items_category(item_type)
	end
	unlock_weapons()
end

unlock_weapons = function()
	for weapon_id in pairs(Global.blackmarket_manager.weapons) do
		managers.upgrades:aquire(weapon_id)
		Global.blackmarket_manager.weapons[weapon_id].unlocked = true
	end
end

unlock_items_category = function(item_type)
	for id, data in pairs(tweak_data.blackmarket[item_type]) do
		if data.infamy_lock then
			data.infamy_lock = false
		end	
		local global_value = get_global_value(data)
		managers.blackmarket:add_to_inventory(global_value, item_type, id)
	end
end

get_global_value = function(data)
	if data.global_value then
		return data.global_value
	elseif data.infamous then
		return "infamous"
	elseif data.dlcs or data.dlc then
		local dlcs = data.dlcs or {}
		if data.dlc then 
			table.insert(dlcs, data.dlc)
		end
		return dlcs[math.random(#dlcs)]
	else
		return "normal"
	end
end
	--unlock_items
		unlock_items(item_type)
	end

	local function delete_items()
		local blackmarket_tweak_data = tweak_data.blackmarket
		for global_value, gv_table in pairs( Global.blackmarket_manager.inventory ) do
			for type_id, type_table in pairs( gv_table ) do
				local item_data = blackmarket_tweak_data[type_id]
				if item_data then
					for item_id, item_amount in pairs( type_table ) do
						type_table[item_id] = nil
					end	
				end	
			end	
		end			
		managers.blackmarket:_load_done()
	end

	local clear_slots = function(category)
	--clear_slots
	-- Remove items from inventory

local clear_slot_category, clear_all_slots, no_money

clear_slots = function( category )
	if category == "all" then
		clear_all_slots()
	else
		clear_slot_category( category )
	end
end

clear_all_slots = function()
	local types = { "masks", "primaries", "secondaries" }
	
	for _, item_type in pairs( types ) do
		clear_slot_category( item_type )
	end
end

clear_slot_category = function( category )
	no_money()
	
	local crafted_items = Global.blackmarket_manager.crafted_items

	for slot in pairs( crafted_items[ category ] ) do
		if slot ~= 1 then -- items from first slot cannot be deleted
			if category == "masks" then
				managers.blackmarket:on_sell_mask( slot )
			else
				managers.blackmarket:on_sell_weapon( category, slot )
			end
		end
	end
	
	backuper:restore('MoneyManager.on_sell_weapon')
	backuper:restore('MoneyManager.on_sell_mask')
end

no_money = function()
	backuper:backup('MoneyManager.on_sell_weapon')
	function MoneyManager:on_sell_weapon() end
	
	backuper:backup('MoneyManager.on_sell_mask')
	function MoneyManager:on_sell_mask() end
end
	--clear_slots
		clear_slots(category)
	end
   
	local function giveitems(argumentTable)
		local itype = argumentTable["type"]
		local times = argumentTable["times"]
		local types = {"weapon_mods", "masks", "materials", "textures", "colors"}
		local skip = {masks = {"character_locked"}, materials = {"plastic"}, colors = {"nothing"}, textures = {"no_color_full_material","no_color_no_material"}}
		if not times then times = 1 end
			if type(itype) == "table" then types = itype end
			if itype == "all" or type(itype) == "table" then
			for i = 1, #types do giveitems({["type"] = types[i], ["times"] = times}) end
			return
		end
		for i=1, times do
			for mat_id,_ in pairs(tweak_data.blackmarket[itype]) do
				if not in_table(skip[itype], mat_id) then
					local global_value = "normal"
					if _.global_value then
						global_value = _.global_value
					elseif _.infamous then
						global_value = "infamous"
					elseif _.dlcs or _.dlc then
						local dlcs = _.dlcs or {}
					if _.dlc then table.insert(dlcs, _.dlc) end
						global_value = dlcs[ math.random(#dlcs) ]
					end
					if _.unlocked == false then 
						_.unlocked = true 
					end
					managers.blackmarket:add_to_inventory(global_value, itype, mat_id, false)
				end    
			end    
		end    
	end
   
	function clearitems(argumentTable)
		local itype = argumentTable["type"]
		local globalval = argumentTable["globalval"]
		local types = {"weapon_mods", "masks", "materials", "textures", "colors"}
		if not globalval then globalval = "all" end
		if type(itype) == "table" then types = itype end
		if itype == "all" or type(itype) == "table" then
				for i = 1, #types do
						clearitems({["type"] = types[i], ["globalval"] = globalval})
				end
		end
		for global_value, categories in pairs(Global.blackmarket_manager.inventory) do
			if (globalval == "all" or globalval == global_value) and categories[itype] then
				for id,amount in pairs(categories[itype]) do
					Global.blackmarket_manager.inventory[global_value][itype][id] = nil
				end
			end
		end
	end
   
	-- Other
	local function unlock_achievements()
		for id in pairs(managers.achievment.achievments) do
			managers.achievment:award(id)
		end    
	end
   
	local function lock_achievements()
		managers.achievment:clear_all_steam()
	end
   
	local function remexclmark()
		Global.blackmarket_manager.new_drops = {}
	end
	-- Achievement Table
	local achieveid = {
		-- Base Game
		armed_and_dangerous = "Armed and Dangerous",
		armed_to_the_teeth = "Armed to the Teeth",
		big_deal = "Big Deal",
		big_shot = "Career Criminal",
		bilbo_baggin = "They See Me Baggin', They Hatin'",
		bullet_dodger = "Bullet Dodger",
		caribbean_pirate = "Caribbean Pirate",
		diamonds_are_forever = "Diamonds Are Forever",
		doctor_fantastic = "Doctor Fantastic",
		fish_ai = "Fish A.I.",
		frappucino_to_go_please = "Cappuccino to Go, Please",
		fully_loaded = "Fully Loaded",
		f_in_chemistry = "F in Chemistry",
		going_all_in = "Im Going All-in!",
		going_places = "Going Places",
		gone_in_30_seconds = "Smooth Criminal",
		guilty_of_crime = "Guilty of Crime",
		hot_wheels = "Coming in Hot",
		how_do_you_like_me_now = "How Do You Like Me Now?",
		im_a_healer_tank_damage_dealer = "Im a Healer-Tank-Damage-Dealer",
		iron_man = "Man of Iron",
		i_knew_what_i_was_doing_was_wrong = "I Knew What I Did Was Wrong",
		i_wasnt_even_there = "I Wasnt Even There!",
		king_of_the_hill = "King of the Hill",
		lets_do_this = "Lets Do Th...",
		like_an_angry_bear = "Like an Angry Bear",
		lord_of_war = "Lord of War",
		masked_villain = "Masked Villain",
		most_wanted = "Most Wanted",
		murphys_laws = "I Got It, I Got It!",
		no_one_cared_who_i_was = "No One Cared Who I Was...",
		no_turning_back = "No Turning Back",
		squek = "State of the Art",
		pink_panther = "Painting Yourself Into a Corner",
		short_fuse = "Short Fuse",
		spend_money_to_make_money = "Spend Money to Make Money",
		the_first_line = "The First Line",
		the_wire = "Guessing Game",
		tip_the_scales = "Tip the Scales",
		weapon_collector = "Weapon Collector",
		window_cleaner = "Shoot the Glass!",
		would_you_like_your_receipt = "Would You Like Your Receipt?",
		yeah_hes_a_gold_digger = "Yeah He's a Gold Digger",
		you_gotta_start_somewhere = "You Gotta Start Somewhere",
		you_shall_not_pass = "You Shall Not Pass!",
		
		-- Community
		frog_1 = "Tabula Rasa",
		gorilla_1 = "Knockout",
		
		-- Infamy
		ignominy_1 = "Becoming Infamous",
		ignominy_2 = "Becoming Disgraceful",
		ignominy_3 = "Becoming Wicked",
		ignominy_4 = "Becoming Notorious",
		ignominy_5 = "Becoming Vicious",
		ignominy_6 = "Becoming Villainous",
		ignominy_7 = "Becoming Abominable",
		ignominy_8 = "Becoming Fiendish",
		ignominy_9 = "Becoming Heinous",
		ignominy_10 = "Becoming Mean",
		ignominy_11 = "Becoming Dangerous",
		ignominy_12 = "Becoming Fearless",
		ignominy_13 = "Becoming Nefarious",
		ignominy_14 = "Becoming Disreputable",
		ignominy_15 = "Becoming Fearful",
		ignominy_16 = "Becoming Opprobrious",
		ignominy_17 = "Becoming Shady",
		ignominy_18 = "Becoming Savage",
		ignominy_19 = "Becoming Abhorrent",
		ignominy_20 = "Becoming Sly",
		ignominy_21 = "Becoming Crafty",
		ignominy_22 = "Becoming Shameless",
		ignominy_23 = "Becoming Diabolical",
		ignominy_24 = "Becoming Ferocious",
		ignominy_25 = "Becoming Monstrous",
		
		-- Death Wish
		death_1 = "Wedding Crashers",
		death_2 = "Came in Like a Wrecking Ball",
		death_3 = "Becoming a Regular",
		death_4 = "Blood on the Dance Floor",
		death_5 = "Like a Fucking Sputnik!",
		death_6 = "Who Let the Doge Out?",
		death_7 = "If You Cant Take the Heat...",
		death_8 = "Into the Lions Den",
		death_9 = "High Way to Hell",
		death_10 = "Making Crime Into an Art Form",
		death_11 = "Changing the World..",
		death_12 = "For Better or Worse",
		death_13 = "Snatch and Grab",
		death_14 = "Tough As Diamonds",
		death_15 = "Cash In Before You Cash Out!",
		death_16 = "Because That's Where the Money Is",
		death_17 = "Striking Gold",
		death_18 = "Cash Is King",
		death_19 = "Yes Hello, Id Like to Make a De-paws-it",
		death_20 = "At a Crossroads",
		death_21 = "Downtown Madness",
		death_22 = "Shipment and Handling",
		death_23 = "A Walk in the Park",
		death_24 = "Its Always Foggy in Washington D.C.",
		death_26 = "Long-Term Relationship",
		death_27 = "Tough Act to Follow",
		death_28 = "Shit Just Got Real",
		death_29 = "Completely OVERKILL!",
		death_30 = "OVERKILL Salutes You!",
		death_31 = "With an Iron Fist",
		death_32 = "I'm a Firestarter",
		death_33 = "Breaking Bad",
		death_34 = "Special Delivery",
		death_35 = "Moonlighting",
		
		-- Halloween
		halloween_1 = "I Am the One Who Knocks",
		halloween_2 = "Full Measure",
		halloween_3 = "Afraid of the Dark",
		halloween_4 = "Witch Doctor",
		halloween_5 = "Its Alive! ITS ALIVE!",
		halloween_6 = "Pump-Action",
		halloween_7 = "No One Can Hear You Scream",
		halloween_8 = "The Pumpkin King Made Me Do It!",
		halloween_9 = "Christmas Came Early",
		halloween_10 = "From Russia With Love",
		halloween_nightmare_1 = "First Nightmare",
		halloween_nightmare_2 = "Second Nightmare",
		halloween_nightmare_3 = "Third Nightmare",
		halloween_nightmare_4 = "Fourth Nightmare",
		halloween_nightmare_5 = "Fifth Nightmare",
		
		-- Gage Courier Mod
		gmod_1 = "Praying Mantis",
		gmod_2 = "Bulls-Eye",
		gmod_3 = "My Spider Sense is Tingling",
		gmod_4 = "Eagle Eyes",
		gmod_5 = "Like A Boy Killing Snakes",
		gmod_6 = "There and Back Again",
		gmod_7 = "High Speed, Low Drag",
		gmod_8 = "Point n Shoot",
		gmod_9 = "Mall Ninja",
		gmod_10 = "Russian Operator",
		
		-- Gage Weapon Pack 1
		gage_1 = "Wanted",
		gage_2 = "3000 Miles to the Safe House",
		gage_3 = "Commando",
		gage_4 = "Public Enemies",
		gage_5 = "Inception",
		gage_6 = "Hard Corps",
		gage_7 = "Above the Law",
		gage_8 = "Guns Are Like Shoes",
		gage_9 = "Fire in the Hole!",
		gage_10 = "Share the Love",
		
		-- Gage Weapon Pack 2
		gage2_1 = "Doctor Miserable",
		gage2_2 = "Cloak and Dagger",
		gage2_3 = "The Eighth and Final Rule",
		gage2_4 = "Killin's As Easy As Breathing",
		gage2_5 = "They Drew First Blood, Not Me",
		gage2_6 = "In Town You're the Law, Out Here Its Me",
		gage2_7 = "Don't Push It",
		gage2_8 = "HOLY SHI-",
		gage2_9 = "I Ain't Got Time to Bleed",
		gage2_10 = "Are You Kidding Me?",
		
		-- Gage Sniper Pack
		gage3_1 = "Build Me an Army Worthy of Crime.net",
		gage3_2 = "The Man With the Golden Gun",
		gage3_3 = "Lord of the Flies",
		gage3_4 = "Arachne's Curse",
		gage3_5 = "Pest Control",
		gage3_6 = "Seer of Death",
		gage3_7 = "Far, Far Away",
		gage3_8 = "Last Action Villain",
		gage3_9 = "Triple Kill",
		gage3_10 = "Maximum Penetration",
		gage3_11 = "Dodge This",
		gage3_12 = "Surprise Motherfucker",
		gage3_13 = "Didn't See That Coming Did You?",
		gage3_14 = "A Taste of Their Own Medicine",
		gage3_15 = "You Cant Hide",
		gage3_16 = "Double Kill",
		gage3_17 = "Public Enemy No. 1",
		
		-- Gage Shotgun Pack
		gage4_1 = "Police Brutality",
		gage4_2 = "Lock, Stock & Eight Smoking Barrels",
		gage4_3 = "Swing Dancing",
		gage4_4 = "Seven Eleven",
		gage4_5 = "Shotgun 101",
		gage4_6 = "Knock, Knock",
		gage4_7 = "Everyday I'm Shovelin'",
		gage4_8 = "Clay Pigeon Shooting",
		gage4_9 = "Shock and Awe",
		gage4_10 = "Bang for the Buck",
		gage4_11 = "No Heist for Old Men",
		gage4_12 = "Four Monkeys",
		
		-- Gage Assault Pack
		gage5_1 = "Precision Aiming",
		gage5_2 = "Big Bada Boom",
		gage5_3 = "Army of One",
		gage5_4 = "So Many Choices",
		gage5_5 = "Artillery Barrage",
		gage5_6 = "Unusual Suspects",
		gage5_7 = "Not Today",
		gage5_8 = "Hammertime",
		gage5_9 = "Rabbit Hunting",
		gage5_10 = "Tour de Clarion",
		
		-- Gage Historical Pack
		eagle_1 = "Death From Below",
		eagle_2 = "Special Operations Executions",
		eagle_3 = "Wind Of Change",
		eagle_4 = "So Uncivilized",
		eagle_5 = "Bullet Hell",
		
		-- Butcher CAR / AK Mod Pack
		ameno_1 = "Ove Saw 72000",
		ameno_2 = "Hey Mr. DJ",
		ameno_3 = "$1.8M Speedrun",
		ameno_4 = "Here Comes the Pain Train",
		ameno_5 = "The Wolf Lures You to Your Grave",
		ameno_6 = "The Turtle Always Wins",
		ameno_7 = "Private Party",
		ameno_8 = "The Collector",
		
		-- OVERKILL Pack
		ovk_1 = "Cooking With Style",
		ovk_2 = "I Have No Idea What I'm Doing",
		ovk_3 = "Oh, That's How You Do It",
		ovk_4 = "We Are Rockstars On This Job",
		ovk_5 = "Reputation Beyond Reproach",
		ovk_6 = "House Keeping",
		ovk_7 = "120 Proof",
		ovk_8 = "Boston Saints",
		ovk_9 = "Bring Your Cop To Work Day",
		ovk_10 = "Wasteful",
		
		-- GO Bank
		charliesierra_1 = "Sewer Rats",
		charliesierra_2 = "Is Everything OK?",
		charliesierra_3 = "Merry Christmas!",
		charliesierra_4 = "Upside Down",
		charliesierra_5 = "All Eggs in One Basket",
		charliesierra_6 = "We Are All Professionals",
		charliesierra_7 = "Eco Round",
		charliesierra_8 = "Dead Presents",
		charliesierra_9 = "Reindeer Games",
		
		-- Election Day
		bob_1 = "A Vote for Change",
		bob_2 = "I Invented the Internet",
		bob_3 = "I'm a Swinger",
		bob_4 = "Storage Hunter",
		bob_5 = "Master Detective",
		bob_6 = "Murphy's Law",
		bob_7 = "Death Wish Swinger",
		bob_8 = "Hot Lava 2.0",
		bob_9 = "Yes We Can!",
		bob_10 = "Ghost Riders",
		
		-- Shadow Raid
		kosugi_1 = "I Will Fade to Dark",
		kosugi_2 = "I Will Pass Through Walls",
		kosugi_3 = "I Will Take With Impunity",
		kosugi_4 = "I Will Walk Faceless Among Men",
		kosugi_5 = "I Am Ninja",
		kosugi_6 = "I Will Die and Die and Die Again",
		
		-- Armored Transport
		armored_1 = "Were Gonna Need a Bigger Boat",
		armored_2 = "But Wait - There's More!",
		armored_3 = "If You Liked It You Should Have Put a Ring on It",
		armored_4 = "I Do What I Do Best, I Take Scores",
		armored_5 = "License to Kill",
		armored_6 = "Let Them Watch",
		armored_7 = "I'm Not a Crook!",
		armored_8 = "I Did Not Have Sexual Relations With That Bulldozer",
		armored_9 = "Fool Me Once, Shame on You.",
		armored_10 = "Affordable Healthcare",
		armored_11 = "Heat Around the Corner",
		
		-- Big Bank
		bigbank_1 = "It Takes Two to Tango",
		bigbank_2 = "It Takes a Pig to Kill a Pig",
		bigbank_3 = "Sweet Sixteen",
		bigbank_4 = "12 Angry Minutes",
		bigbank_5 = "Don't Bring the Heat",
		bigbank_6 = "Backing Bobblehead Bob",
		bigbank_7 = "Entrapment",
		bigbank_8 = "You Owe Me One",
		bigbank_9 = "Don't Forget to Floss",
		bigbank_10 = "Funding Father",
		
		-- Hotline Miami
		pig_1 = "Wrong Number",
		pig_2 = "Walk Faster",
		pig_3 = "Do You Like Hurting Other People?",
		pig_4 = "Overdose",
		pig_5 = "Sounds of Animals Fighting",
		pig_6 = "+1 (786) 519-3708",
		pig_7 = "Phew!",
		
		-- Hoxton Breakout
		bulldog_1 = "Why Don't We Just Use A Spoon?",
		bulldog_2 = "No Bars Can Hold Me",
		bulldog_3 = "Havoc in the Streets",
		bulldog_4 = "Cavity",
		
		-- White Xmas
		deer_1 = "Vlad's Little Helpers",
		deer_2 = "Stealing Christmas",
		deer_3 = "Cancelling Santa's Christmas",
		deer_4 = "Claustrophobia",
		deer_5 = "Like Turkeys Voting for an Early Christmas",
		deer_6 = "Riders On the Snowstorm",
		deer_7 = "Impossible, It Can't Be. Is It?",
		
		-- The Diamond
		bat_1 = "Devil of a Job",
		bat_2 = "Cat Burglar",
		bat_3 = "Culture Vultures",
		bat_4 = "Smoke And Mirrors",
		bat_5 = "Honor Among Thieves",
		bat_6 = "Diamonds in the Rough",
		
		-- Bomb Heists
		cow_1 = "Derailed",
		cow_2 = "A Pine in the Ass",
		cow_3 = "Beaver Team",
		cow_4 = "Pump It Up",
		cow_5 = "Oppressor",
		cow_6 = "Maiden Voyage",
		cow_7 = "Fishermans Fiend",
		cow_8 = "Sneaking With The Fishes",
		cow_9 = "Breaking Dead",
		cow_10 = "I've Got the Power",
		cow_11 = "Done in 60 Seconds",
		
		-- Spring Break
		slakt_1 = "Speedlock Holmes",
		slakt_2 = "Nothing Out of the Ordinary",
		slakt_3 = "Situation Normal",
		slakt_4 = "Keep the Party Going",
		slakt_5 = "It's Getting Hot in Here",
		djur_1 = "Cooking By The Book",
		fort_1 = "High Octane",
		fort_2 = "Pink Slip",
		fort_3 = "Tag, You're It!",
		fort_4 = "Gone in 240 Seconds",
		payback_1 = "A Dish Best Served Cold",
		payback_2 = "Silent But Deadly",
		payback_3 = "I'm An Avenger!",
		
		-- BBQ Pack
		grill_1 = "Disco Inferno",
		grill_2 = "Stick a Fork in Me, I'm Done",
		grill_3 = "Not Invited",
		grill_4 = "OVERGRILL",
		
		-- Butcher Western Pack
		scorpion_1 = "Recycling",
		scorpion_2 = "The Nobel Prize",
		scorpion_3 = "Hedgehog",
		scorpion_4 = "Fastest Gun in the West",
		
		-- Meltdown
		melt_1 = "Pedal to the Metal",
		melt_2 = "Sunday Drive",
		melt_3 = "They Don't Pay Us Enough",
		melt_4 = "There Was a Car?!",
		
		-- Alesso
		live_1 = "We Built This City on Electric Progressive House Music",
		live_2 = "Sound of Silence",
		live_3 = "Even Steven",
		live_4 = "Fuck It, We're Walking",
		live_5 = "M.F. Stev",
		
		-- Golden Grin Casino
		kenaz_1 = "How the Fuck Can You Grin?",
		kenaz_2 = "Blind Eye in the Sky",
		kenaz_3 = "City of Sin and Well-Oiled Gears",
		kenaz_4 = "High Roller",
		kenaz_5 = "Hail to the King, Baby",
		
		-- Gage Ninja Pack
		turtles_1 = "Names Are for Friends, so I Don't Need One",
		turtles_2 = "Swiss Cheese",
		turtles_3 = "Shuriken Shenanigans",
		turtles_4 = "Fugu Fighter",
		
		-- Gage Chivalry Pack
		steel_1 = "Heisters of the Round Table",
		steel_2 = "Their Armor Is Thick and Their Shields Broad",
		steel_3 = "Skewer",
		steel_4 = "Black Knight",
		
		-- Aftershock
		sinus_1 = "400 Bucks",
		sinus_2 = "Aftershocked",
		
		-- First World Bank
		green_1 = "Hidden Hostages",
		green_2 = "Original Heisters",
		green_3 = "1337",
		green_4 = "Cloaker Fear",
		green_5 = "CVL+",
		green_6 = "OVERDRILL",
		green_7 = "Au Ticket",
		
		-- Slaughterhouse
		farm_1 = "Not Hard Enough",
		farm_2 = "But How?",
		farm_3 = "Making a Statement",
		farm_4 = "Pyromaniacs",
		farm_5 = "Dead Meat",
		farm_6 = "Pork Royale",
		
		-- CrimeFest 2015
		brooklyn_1 = "I Want to Get Away",
		brooklyn_2 = "Bunnyhopping",
		brooklyn_3 = "I Never Asked for This",
		brooklyn_4 = "Jump! Jump! Jump!",
		
		-- Halloween Event 2015
		lab_1 = "Skill Shot",
		lab_2 = "Trick or Treat!",
		lab_3 = "Not Scary Enough",
		
		-- Beneath the Mountain
		berry_1 = "Hall of the Mountain King",
		berry_2 = "Clean House",
		berry_3 = "Commando Crew",
		berry_4 = "Juggernauts",
		berry_5 = "No Scope",
		
		-- Birth of Sky
		jerry_1 = "The Sky Is the Limit",
		jerry_2 = "Pinpoint Landing",
		jerry_3 = "No Blood on the Carpet",
		jerry_4 = "1... 2... 3... JUMP!",
		jerry_5 = "Black Tie Event",
		
		-- Santa's Workshop
		cane_1 = "On the Seventh Try on Death Wish, My True Bain Gave to Me",
		cane_2 = "Santa Slays Slackers",
		cane_3 = "Euro Bag Simulator",
		cane_4 = "Pumped Up and Jolly",
		cane_5 = "Only Santa Brings Gifts",
		
		-- Christmas Update
		flake_1 = "We Do It Live!",
		
		-- Goat Simulator
		peta_1 = "Coffee Stain",
		peta_2 = "Goat In 60 Seconds",
		peta_3 = "Hazzard County",
		peta_4 = "BAAaa... *BANG* ...aaAAH",
		peta_5 = "Farmer Miserable",
		
		-- Goat Hotfix
		bah_1 = "You Can Run, but Not Hide",
		
		-- Counterfeit
		pal_1 = "Under Pressure",
		pal_2 = "Dr. Evil",
		pal_3 = "Cutting the Red Wire",
		pal_4 = "Basement Dwellers",
		pal_5 = "Crowd Control",
		
		-- Undercover
		man_1 = "In for a dime, in for a Dollar",
		man_2 = "Not Even Once",
		man_3 = "Keep Clear of the Windows",
		man_4 = "The Saviour",
		man_5 = "Blow-Out"
	}

	function remachieve(achieveid)
		if managers.achievment then
			for id,_ in pairs(managers.achievment.achievments) do
				if managers.achievment:get_info(achieveid).awarded then
					managers.achievment:clear_steam(achieveid)
				end    
			end    
		end    
	end
						   
	function addachieve(achieveid)
		if managers.achievment then
			for id,_ in pairs(managers.achievment.achievments) do
				managers.achievment:award(achieveid)
			end
		end    
	end
---------------------------------------------------------------------------------------------------------------------------------
	PreGameMenu = CustomMenuClass:new()
	PreGameMenu:addMainMenu('main_menu', {title = 'Выберите функцию', maxRows = 11})
	PreGameMenu:addMenu('continental_coins_menu', {title = 'Continental Coins'})
	PreGameMenu:addMenu('infamy_level_menu', {title = 'Дурная репутация'})
	PreGameMenu:addMenu('infamy_points_menu', {title = 'Очки дурной репутации'})
	PreGameMenu:addMenu('inventory_menu', {title = 'Инвентарь', maxRows = 12})
	PreGameMenu:addMenu('clear_inventory_menu', {title = 'Отчистить инвентарь'})
	PreGameMenu:addMenu('add_inventory_menu', {title = 'Добавить в инвентарь'})
	PreGameMenu:addMenu('level_menu', {title = 'Уровень', maxRows = 11})
	PreGameMenu:addMenu('money_menu', {title = 'Деньги'})
	PreGameMenu:addMenu('skill_menu', {title = 'Навыки и Перки'})
	PreGameMenu:addMenu('add_achieve_menu', {title = 'Добавить достижение - Выберите достижение' , maxColumns = 2, maxRows = 11})
	PreGameMenu:addMenu('rem_achieve_menu', {title = 'Убрать достижение - Выберите достижение', maxColumns = 2, maxRows = 11})
   
	PreGameMenu:addInformationOption('main_menu', 'МЕНЮ', {textColor = Color.red})
	PreGameMenu:addMenuOption('main_menu', 'Дурная репутация', 'infamy_level_menu', {rectHighlightColor = Color.red})
	-- Infamy Menu Column 1
	PreGameMenu:addInformationOption('infamy_level_menu', 'ОПЦИИ ДУРНОЙ РЕПУТАЦИИ', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('infamy_level_menu', 'Сборосить дурную репутацию', {callback = function() set_infamy_level(0) end})
	PreGameMenu:addGap('infamy_level_menu')
	PreGameMenu:addInformationOption('infamy_level_menu', 'УРОВНИ ДУРНОЙ РЕПУТАЦИИ', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 1', {callback = set_infamy_level, callbackData = 1, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 2', {callback = set_infamy_level, callbackData = 2, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 3', {callback = set_infamy_level, callbackData = 3, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 4', {callback = set_infamy_level, callbackData = 4, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 5', {callback = set_infamy_level, callbackData = 5, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 6', {callback = set_infamy_level, callbackData = 6, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 7', {callback = set_infamy_level, callbackData = 7, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 8', {callback = set_infamy_level, callbackData = 8, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 9', {callback = set_infamy_level, callbackData = 9, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 10', {callback = set_infamy_level, callbackData = 10, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 11', {callback = set_infamy_level, callbackData = 11, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 12', {callback = set_infamy_level, callbackData = 12, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 13', {callback = set_infamy_level, callbackData = 13, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 14', {callback = set_infamy_level, callbackData = 14, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 15', {callback = set_infamy_level, callbackData = 15, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 16', {callback = set_infamy_level, callbackData = 16, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 17', {callback = set_infamy_level, callbackData = 17, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 18', {callback = set_infamy_level, callbackData = 18, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 19', {callback = set_infamy_level, callbackData = 19, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 20', {callback = set_infamy_level, callbackData = 20, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 21', {callback = set_infamy_level, callbackData = 21, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 22', {callback = set_infamy_level, callbackData = 22, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 23', {callback = set_infamy_level, callbackData = 23, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 24', {callback = set_infamy_level, callbackData = 24, closeMenu = true})
	PreGameMenu:addOption('infamy_level_menu', 'Установить на 25', {callback = set_infamy_level, callbackData = 25, closeMenu = true})

	PreGameMenu:addMenuOption('main_menu', 'Очки дурной репутации', 'infamy_points_menu', {rectHighlightColor = Color.red})
	-- Infamy Menu Column 1
	PreGameMenu:addInformationOption('infamy_points_menu', 'ДУРНАЯ РЕПУТАЦИЯ', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('infamy_points_menu', 'Сбросить дурную репутацию', {callback = function() set_infamy_level(0) end})
	PreGameMenu:addGap('infamy_points_menu')
	PreGameMenu:addInformationOption('infamy_points_menu', 'ОЧКИ ДУРНОЙ РЕПУТАЦИИ', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 1', {callback = function() set_infamy_points(1) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 2', {callback = function() set_infamy_points(2) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 3', {callback = function() set_infamy_points(3) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 4', {callback = function() set_infamy_points(4) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 5', {callback = function() set_infamy_points(5) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 6', {callback = function() set_infamy_points(6) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 7', {callback = function() set_infamy_points(7) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 8', {callback = function() set_infamy_points(8) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 9', {callback = function() set_infamy_points(9) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 10', {callback = function() set_infamy_points(10) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 11', {callback = function() set_infamy_points(11) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 12', {callback = function() set_infamy_points(12) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 13', {callback = function() set_infamy_points(13) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 14', {callback = function() set_infamy_points(14) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 15', {callback = function() set_infamy_points(15) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 16', {callback = function() set_infamy_points(16) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 17', {callback = function() set_infamy_points(17) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 18', {callback = function() set_infamy_points(18) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 19', {callback = function() set_infamy_points(19) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 20', {callback = function() set_infamy_points(20) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 21', {callback = function() set_infamy_points(21) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 22', {callback = function() set_infamy_points(22) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 23', {callback = function() set_infamy_points(23) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 24', {callback = function() set_infamy_points(24) end, closeMenu = true})
	PreGameMenu:addOption('infamy_points_menu', 'Установить на 25', {callback = function() set_infamy_points(25) end, closeMenu = true})

	PreGameMenu:addMenuOption('main_menu', 'Инвентарь', 'inventory_menu', {rectHighlightColor = Color.red})
	-- Inventory Menu Column 1
	PreGameMenu:addInformationOption('inventory_menu', 'ИНВЕНТАРЬ', {textColor = Color.red})
	PreGameMenu:addMenuOption('inventory_menu', 'Добавить в инвентарь', 'add_inventory_menu', {rectHighlightColor = Color.red})
	PreGameMenu:addMenuOption('inventory_menu', 'Отчистить инвентарь', 'clear_inventory_menu', {rectHighlightColor = Color.red})
	PreGameMenu:addGap('inventory_menu')
	PreGameMenu:addInformationOption('inventory_menu', 'Разблокировать', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('inventory_menu', 'Разблокировать все предметы', {callback = unlock_items, callbackData = "all"})
	PreGameMenu:addOption('inventory_menu', 'Разблокировать все слоты', {callback = unlock_slots})
	PreGameMenu:addOption('inventory_menu', 'Разблокировать цвета', {callback = unlock_items, callbackData = "colors"})
	PreGameMenu:addOption('inventory_menu', 'Разблокировать маски', {callback = unlock_items, callbackData = "masks"})
	PreGameMenu:addOption('inventory_menu', 'Разблокировать материалы', {callback = unlock_items, callbackData = "materials"})
	PreGameMenu:addOption('inventory_menu', 'Разблокировать текстуры', {callback = unlock_items, callbackData = "textures"})
	PreGameMenu:addOption('inventory_menu', 'Разблокировать оружие', {callback = unlock_items, callbackData = "weapons"})
	PreGameMenu:addOption('inventory_menu', 'Разблокировать все трофеи', {callback = give_trophies, closeMenu = true})
	-- Inventory Menu Column 2
	PreGameMenu:addInformationOption('inventory_menu', 'Другое', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('inventory_menu', 'Удалить предметы с восклицательным знаком', {callback = remexclmark})
	PreGameMenu:addGap('inventory_menu')
	PreGameMenu:addGap('inventory_menu')
	PreGameMenu:addInformationOption('inventory_menu', 'РАЗБЛОКИРОВКА (Dlc)', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('inventory_menu', 'Разблокировать моды для оружия', {callback = unlock_items, callbackData = "weapon_mods"})
   
	-- Clear Inventory Menu Column 1
	PreGameMenu:addInformationOption('clear_inventory_menu', 'УДАЛЕНИЕ ПРЕДМЕТОВ', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('clear_inventory_menu', 'Удалить все слоты масок', {callback = clear_slots, callbackData = "masks"})
	PreGameMenu:addOption('clear_inventory_menu', 'Удалить все слоты первого оружия', {callback = clear_slots, callbackData = "primaries"})
	PreGameMenu:addOption('clear_inventory_menu', 'Удалить все слоты второго оружия', {callback = clear_slots, callbackData = "secondaries"})
	PreGameMenu:addGap('clear_inventory_menu')
	PreGameMenu:addInformationOption('clear_inventory_menu', 'УДАЛИТЬ ИЛИ ЗАБЛОКИРОВАТЬ СЛОТЫ', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('clear_inventory_menu', 'Удалить все предметы', {callback = clearitems, callbackData = {["type"] = "all", ["globalval"] = "all"}})
	PreGameMenu:addOption('clear_inventory_menu', 'Удалить все слоты', {callback = clear_slots, callbackData = "all"})
	PreGameMenu:addOption('clear_inventory_menu', 'Заблокировать все предметы', {callback = delete_items})
	PreGameMenu:addGap('clear_inventory_menu')
	-- Clear Inventory Menu Column 2
	PreGameMenu:addInformationOption('clear_inventory_menu', 'УДАЛИТЬ ПРЕДМЕТЫ', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('clear_inventory_menu', 'Удалить все цвета', {callback = clearitems, callbackData = {["type"] = "colors", ["globalval"] = "all"}})
	PreGameMenu:addOption('clear_inventory_menu', 'Удалить все маски', {callback = clearitems, callbackData = {["type"] = "masks", ["globalval"] = "all"}})
	PreGameMenu:addOption('clear_inventory_menu', 'Удалить все материалы', {callback = clearitems, callbackData = {["type"] = "materials", ["globalval"] = "all"}})
	PreGameMenu:addOption('clear_inventory_menu', 'Удалить все рисунки', {callback = clearitems, callbackData = {["type"] = "textures", ["globalval"] = "all"}})
	PreGameMenu:addOption('clear_inventory_menu', 'Удалить все моды оружия', {callback = clearitems, callbackData = {["type"] = "weapon_mods", ["globalval"] = "all"}})
	for i=7,10 do
			PreGameMenu:addGap('clear_inventory_menu')
	end    
   
	-- Add To Inventory Menu Column 1
	PreGameMenu:addInformationOption('add_inventory_menu', 'ДОБАВИТЬ ПО 1 ПРЕДМЕТУ', {textColor = Color.red})
	PreGameMenu:addOption('add_inventory_menu', 'Добавить 1 ко всем цветам', {callback = giveitems, callbackData = {["type"] = "colors", ["times"] = nil}})
	PreGameMenu:addOption('add_inventory_menu', 'Добавить 1 ко всему', {callback = giveitems, callbackData = {["type"] = "all", ["times"] = nil}})
	PreGameMenu:addOption('add_inventory_menu', 'Добавить 1 всех масок', {callback = giveitems, callbackData = {["type"] = "masks", ["times"] = nil}})
	PreGameMenu:addOption('add_inventory_menu', 'Добавить 1 всех материалов', {callback = giveitems, callbackData = {["type"] = "materials", ["times"] = nil}})
	PreGameMenu:addOption('add_inventory_menu', 'Добавить 1 всех рисунков', {callback = giveitems, callbackData = {["type"] = "textures", ["times"] = nil}})
	PreGameMenu:addOption('add_inventory_menu', 'Добавить 1 всех оружейных модов', {callback = giveitems, callbackData = {["type"] = "weapon_mods", ["times"] = nil}})
	PreGameMenu:addGap('add_inventory_menu')
	PreGameMenu:addGap('add_inventory_menu')
	PreGameMenu:addGap('add_inventory_menu')
	-- Add To Inventory Menu Column 2
	PreGameMenu:addInformationOption('add_inventory_menu', 'ДОБАВИТЬ ПО 5 ПРЕДМЕТОВ', {textColor = Color.red})
	PreGameMenu:addOption('add_inventory_menu', 'Добавить 5 ко всем цветам', {callback = giveitems, callbackData = {["type"] = "colors", ["times"] = 5}})
	PreGameMenu:addOption('add_inventory_menu', 'Добавить 5 ко всему', {callback = giveitems, callbackData = {["type"] = "all", ["times"] = 5}})
	PreGameMenu:addOption('add_inventory_menu', 'Добавить 5 всех масок', {callback = giveitems, callbackData = {["type"] = "masks", ["times"] = 5}})
	PreGameMenu:addOption('add_inventory_menu', 'Добавить 5 всех материалов', {callback = giveitems, callbackData = {["type"] = "materials", ["times"] = 5}})
	PreGameMenu:addOption('add_inventory_menu', 'Добавить 5 всех рисунков', {callback = giveitems, callbackData = {["type"] = "textures", ["times"] = 5}})
	PreGameMenu:addOption('add_inventory_menu', 'Добавить 5 всех оружейных модов', {callback = giveitems, callbackData = {["type"] = "weapon_mods", ["times"] = 5}})
	PreGameMenu:addMenuOption('main_menu', 'Уровни', 'level_menu', {rectHighlightColor = Color.red})
   
	-- Level Menu Column 1
	PreGameMenu:addInformationOption('level_menu', 'ОПЫТ', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('level_menu', 'Добавить 100 опыта', {callback = function() add_exp(100) end, closeMenu = true})
	PreGameMenu:addOption('level_menu', 'Добавить 1,000 опыта', {callback = function() add_exp(1000) end, closeMenu = true})
	PreGameMenu:addOption('level_menu', 'Добавить 10,000 опыта', {callback = function() add_exp(10000) end, closeMenu = true})
	PreGameMenu:addOption('level_menu', 'Добавить 50,000 опыта', {callback = function() add_exp(50000) end, closeMenu = true})
	PreGameMenu:addOption('level_menu', 'Добавить 100,000 опыта', {callback = function() add_exp(100000) end, closeMenu = true})
	PreGameMenu:addOption('level_menu', 'Добавить 200,000 опыта', {callback = function() add_exp(200000) end, closeMenu = true})
	PreGameMenu:addGap('level_menu')
	PreGameMenu:addGap('level_menu')
	PreGameMenu:addGap('level_menu')
	PreGameMenu:addGap('level_menu')
	-- Level Menu Column 2
	PreGameMenu:addInformationOption('level_menu', 'УРОВНИ', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('level_menu', 'Ваш уровень теперь 10', {callback = function() change_level(10) end, closeMenu = true})
	PreGameMenu:addOption('level_menu', 'Ваш уровень теперь 20', {callback = function() change_level(20) end, closeMenu = true})
	PreGameMenu:addOption('level_menu', 'Ваш уровень теперь 30', {callback = function() change_level(30) end, closeMenu = true})
	PreGameMenu:addOption('level_menu', 'Ваш уровень теперь 40', {callback = function() change_level(40) end, closeMenu = true})
	PreGameMenu:addOption('level_menu', 'Ваш уровень теперь 50', {callback = function() change_level(50) end, closeMenu = true})
	PreGameMenu:addGap('level_menu')
	PreGameMenu:addGap('level_menu')
	PreGameMenu:addGap('level_menu')
	PreGameMenu:addGap('level_menu')       
	-- Level Menu Column 3
	PreGameMenu:addGap('level_menu')
	PreGameMenu:addGap('level_menu')
	PreGameMenu:addOption('level_menu', 'Ваш уровень теперь 60', {callback = function() change_level(60) end, closeMenu = true})
	PreGameMenu:addOption('level_menu', 'Ваш уровень теперь 70', {callback = function() change_level(70) end, closeMenu = true})
	PreGameMenu:addOption('level_menu', 'Ваш уровень теперь 80', {callback = function() change_level(80) end, closeMenu = true})
	PreGameMenu:addOption('level_menu', 'Ваш уровень теперь 90', {callback = function() change_level(90) end, closeMenu = true})
	PreGameMenu:addOption('level_menu', 'Ваш уровень теперь 100', {callback = function() change_level(100) end, closeMenu = true})
   
	PreGameMenu:addMenuOption('main_menu', 'Деньги', 'money_menu', {rectHighlightColor = Color.red})
	-- Money Menu Column 1
	PreGameMenu:addInformationOption('money_menu', 'СБРОС ДЕНЕГ', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('money_menu','Сбросить деньги', {callback = reset_money})
	PreGameMenu:addGap('money_menu')
	PreGameMenu:addInformationOption('money_menu', 'ДОБАВИТЬ ДЕНЕГ', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('money_menu', 'Добавить 1 миллион + 4 миллиона офшорных', {callback = function() add_money(5000000) end, closeMenu = true})
	PreGameMenu:addOption('money_menu', 'Добавить 10 миллионов + 40 миллионов офшорных', {callback = function() add_money(50000000) end, closeMenu = true})
	PreGameMenu:addOption('money_menu', 'Добавить 100 миллионов + 400 миллионов офшорных', {callback = function() add_money(500000000) end, closeMenu = true})
	PreGameMenu:addOption('money_menu', 'Добавить 1 миллиард + 4 миллиарда офшорных', {callback = function() add_money(5000000000) end, closeMenu = true})
   
	PreGameMenu:addMenuOption('main_menu', 'Навыки и Перки', 'skill_menu', {rectHighlightColor = Color.red})
	-- Skill Menu Column 1
	PreGameMenu:addInformationOption('skill_menu', 'НАВЫКИ', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('skill_menu','Сбросить очки навыков', {callback = function() set_skillpoints(0) end, closeMenu = true})
	PreGameMenu:addOption('skill_menu','Разблокировать все навыки', {callback = function() for i=1,2 do unlock_all_skills() end end, closeMenu = true})
	PreGameMenu:addGap('skill_menu')
	PreGameMenu:addInformationOption('skill_menu', 'НАВЫКИ - ОЧКИ', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('skill_menu', 'Установить очки навыков на 120', {callback = function() set_skillpoints(120) end, help = 'Можно прокачать одну ветку полностью', closeMenu = true})
	PreGameMenu:addOption('skill_menu', 'Установить очки навыков на 290', {callback = function() set_skillpoints(290) end, help = 'Можно прокачать одну ветку полностью', closeMenu = true})
	PreGameMenu:addOption('skill_menu', 'Установить очки навыков на 435', {callback = function() set_skillpoints(435) end, help = 'Можно прокачать одну ветку полностью', closeMenu = true})
	PreGameMenu:addOption('skill_menu', 'Установить очки навыков на 580', {callback = function() set_skillpoints(580) end, help = 'Можно прокачать одну ветку полностью', closeMenu = true})
	PreGameMenu:addOption('skill_menu', 'Установить очки навыков на 725', {callback = function() set_skillpoints(725) end, help = 'Можно прокачать одну ветку полностью', closeMenu = true})
	-- Skill Menu Column 2
	PreGameMenu:addInformationOption('skill_menu', 'ПЕРКИ', {textColor = Color.DodgerBlue}) 
	PreGameMenu:addOption('skill_menu', 'Сбросить очки перок', {callback = reset_perkpoints, closeMenu = true})
	PreGameMenu:addOption('skill_menu', 'Разблокировать все перки', {callback = unlockperks, closeMenu = true, help = 'Это не визуальный эфект, зайдите в игру, чтобы увидеть Активные Перки'})
	PreGameMenu:addGap('skill_menu')
	PreGameMenu:addInformationOption('skill_menu', 'ОЧКИ ПЕРКОВ', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('skill_menu', 'Добавить 500 очков', {callback = function() set_perkpoints(500000) end, closeMenu = true})
	PreGameMenu:addOption('skill_menu', 'Добавить 1,000 очков', {callback = function() set_perkpoints(1000000) end, closeMenu = true})
	PreGameMenu:addOption('skill_menu', 'Добавить 2,500 очков', {callback = function() set_perkpoints(2500000) end, closeMenu = true})
	PreGameMenu:addOption('skill_menu', 'Добавить 5,000 очков', {callback = function() set_perkpoints(5000000) end, closeMenu = true})
	PreGameMenu:addOption('skill_menu', 'Добавить 10,000 очков', {callback = function() set_perkpoints(10000000) end, closeMenu = true})
   --Continental_coins
   	PreGameMenu:addMenuOption('main_menu', 'Continental Coins', 'continental_coins_menu', {rectHighlightColor = Color.red})
	-- continental_coins_menu Menu Column 1
	PreGameMenu:addInformationOption('continental_coins_menu', 'Continental Coins', {textColor = Color.DodgerBlue})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 1 монету', {callback = function() give_cc(1) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 5 монет', {callback = function() give_cc(5) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 10 монет', {callback = function() give_cc(10) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 15 монет', {callback = function() give_cc(15) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 20 монет', {callback = function() give_cc(20) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 25 монет', {callback = function() give_cc(25) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 30 монет', {callback = function() give_cc(30) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 35 монет', {callback = function() give_cc(35) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 40 монет', {callback = function() give_cc(40) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 50 монет', {callback = function() give_cc(50) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 60 монет', {callback = function() give_cc(60) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 70 монет', {callback = function() give_cc(70) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 80 монет', {callback = function() give_cc(80) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 90 монет', {callback = function() give_cc(90) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 100 монет', {callback = function() give_cc(100) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 150 монет', {callback = function() give_cc(150) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 200 монет', {callback = function() give_cc(200) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 250 монет', {callback = function() give_cc(250) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 300 монет', {callback = function() give_cc(300) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 400 монет', {callback = function() give_cc(400) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 500 монет', {callback = function() give_cc(500) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 600 монет', {callback = function() give_cc(600) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 700 монет', {callback = function() give_cc(700) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 800 монет', {callback = function() give_cc(800) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 900 монет', {callback = function() give_cc(900) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 1000 монет', {callback = function() give_cc(1000) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 1500 монет', {callback = function() give_cc(1500) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 2000 монет', {callback = function() give_cc(2000) end, closeMenu = true})
	PreGameMenu:addOption('continental_coins_menu', 'Добавить 50000 монет', {callback = function() give_cc(50000) end, closeMenu = true})
	-- Options
	PreGameMenu:addInformationOption('main_menu', 'ДОСТИЖЕНИЯ', {textColor = Color.DodgerBlue})
	-- Add Achievements
	PreGameMenu:addMenuOption('main_menu', 'Добавить отдельное достижение', 'add_achieve_menu', {rectHighlightColor = Color.red})
	for id,name in pairs(achieveid) do
		PreGameMenu:addOption('add_achieve_menu', name, {callback = addachieve, callbackData = id})
	end
	-- Remove Achievements
	PreGameMenu:addMenuOption('main_menu', 'Убрать отдельное достижение', 'rem_achieve_menu', {rectHighlightColor = Color.red})
	for id,name in pairs(achieveid) do
		PreGameMenu:addOption('rem_achieve_menu', name, {callback = remachieve, callbackData = id})
	end
	for i=1,9 do
		PreGameMenu:addGap('main_menu')
	end
	PreGameMenu:addOption('main_menu', 'Заблокировать достижения', {callback = lock_achievements, closeMenu = true})
	PreGameMenu:addOption('main_menu', 'Разблокировать достижения', {callback = unlock_achievements, closeMenu = true})
end

if not inGame() and not isPlaying() then       
	if PreGameMenu:isOpen() then
		PreGameMenu:close()
	else
		if JobSelectMenu then
			if JobSelectMenu:isOpen() then
				JobSelectMenu:close()
			end
		end
		if DifficultyMenu then
			if DifficultyMenu:isOpen() then
				DifficultyMenu:close()
			end
		end
		PreGameMenu:open()
	end    
end
-------------------------------------------------------------------------------------------------------------------------------
if not JobMenu then    
	-- JOB MENU    
	-- ALL AI
	spooccuffer = spooccuffer or function()
		function TeamAIMovement:on_SPOOCed()
			self._unit:brain():set_logic("surrender")
			self._unit:network():send("arrested")
			self._unit:character_damage():on_arrested()
		end     
	end
   
	-- DALLAS / RUSSIAN
	dallasnormalspeed = dallasnormalspeed or function()
		tweak_data.character.russian.move_speed = tweak_data.character.presets.move_speed.fast
	end
	dallasfastspeed = dallasfastspeed or function()
		tweak_data.character.russian.move_speed = tweak_data.character.presets.move_speed.lightning
	end
	dallasdodge = dallasdodge or function()
		tweak_data.character.russian.dodge = tweak_data.character.presets.dodge.athletic
	end
	dallasguard = dallasguard or function()
		tweak_data.character.russian.deathguard = nil
	end
	dallasweaponset1 = dallasweaponset1 or function()
		tweak_data.character.russian.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_lmg_m249/wpn_npc_lmg_m249"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mac11/wpn_npc_mac11")
		}
	end
	dallasweaponset2 = dallasweaponset2 or function()
		tweak_data.character.russian.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_sawnoff_shotgun/wpn_npc_sawnoff_shotgun"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull")
		}
	end
	dallasweaponset3 = dallasweaponset3 or function()
		tweak_data.character.russian.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_g36/wpn_npc_g36"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mp5_tactical/wpn_npc_mp5_tactical")
		}
	end

	-- WOLF / GERMAN
	wolfnormalspeed = wolfnormalspeed or function()
		tweak_data.character.german.move_speed = tweak_data.character.presets.move_speed.fast
	end
	wolffastspeed = wolffastspeed or function()
		tweak_data.character.german.move_speed = tweak_data.character.presets.move_speed.lightning
	end
	wolfdodge = wolfdodge or function()
		tweak_data.character.german.dodge = tweak_data.character.presets.dodge.athletic
	end
	wolfguard = wolfguard or function()
		tweak_data.character.german.deathguard = nil
	end
	wolfweaponset1 = wolfweaponset1 or function()
		tweak_data.character.german.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_lmg_m249/wpn_npc_lmg_m249"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mac11/wpn_npc_mac11")
		}
	end
	wolfweaponset2 = wolfweaponset2 or function()
		tweak_data.character.german.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_sawnoff_shotgun/wpn_npc_sawnoff_shotgun"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull")
		}
	end
	wolfweaponset3 = wolfweaponset3 or function()
		tweak_data.character.german.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_g36/wpn_npc_g36"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mp5_tactical/wpn_npc_mp5_tactical")
		}
	end

	-- HOXTON / AMERICAN
	hoxtonnormalspeed = hoxtonnormalspeed or function()
		tweak_data.character.american.move_speed = tweak_data.character.presets.move_speed.fast
	end
	hoxtonfastspeed = hoxtonfastspeed or function()
		tweak_data.character.american.move_speed = tweak_data.character.presets.move_speed.lightning
	end
	hoxtondodge = hoxtondodge or function()
		tweak_data.character.american.dodge = tweak_data.character.presets.dodge.athletic
	end
	hoxtonguard = hoxtonguard or function()
		tweak_data.character.american.deathguard = nil
	end
	hoxtonweaponset1 = hoxtonweaponset1 or function()
		tweak_data.character.american.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_lmg_m249/wpn_npc_lmg_m249"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mac11/wpn_npc_mac11")
		}
	end
	hoxtonweaponset2 = hoxtonweaponset2 or function()
		tweak_data.character.american.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_sawnoff_shotgun/wpn_npc_sawnoff_shotgun"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull")
		}
	end
	hoxtonweaponset3 = hoxtonweaponset3 or function()
		tweak_data.character.american.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_g36/wpn_npc_g36"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mp5_tactical/wpn_npc_mp5_tactical")
		}
	end

	-- CHAINS / SPANISH
	chainsnormalspeed = chainsnormalspeed or function()
		tweak_data.character.spanish.move_speed = tweak_data.character.presets.move_speed.fast
	end
	chainsfastspeed = chainsfastspeed or function()
		tweak_data.character.spanish.move_speed = tweak_data.character.presets.move_speed.lightning
	end
	chainsdodge = chainsdodge or function()
		tweak_data.character.spanish.dodge = tweak_data.character.presets.dodge.athletic
	end
	chainsguard = chainsguard or function()
		tweak_data.character.spanish.deathguard = nil
	end
	chainsweaponset1 = chainsweaponset1 or function()
		tweak_data.character.spanish.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_lmg_m249/wpn_npc_lmg_m249"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mac11/wpn_npc_mac11")
		}
	end
	chainsweaponset2 = chainsweaponset2 or function()
		tweak_data.character.spanish.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_sawnoff_shotgun/wpn_npc_sawnoff_shotgun"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull")
		}
	end
	chainsweaponset3 = chainsweaponset3 or function()
		tweak_data.character.spanish.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_g36/wpn_npc_g36"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mp5_tactical/wpn_npc_mp5_tactical")
		}
	end

-- JOHN WICK / JOWI
	wicknormalspeed = wicknormalspeed or function()
		tweak_data.character.jowi.move_speed = tweak_data.character.presets.move_speed.fast
	end
	wickfastspeed = wickfastspeed or function()
		tweak_data.character.jowi.move_speed = tweak_data.character.presets.move_speed.lightning
	end
	wickdodge = wickdodge or function()
		tweak_data.character.jowi.dodge = tweak_data.character.presets.dodge.athletic
	end
	wickguard = wickguard or function()
		tweak_data.character.jowi.deathguard = nil
	end
	wickweaponset1 = wickweaponset1 or function()
		tweak_data.character.jowi.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_lmg_m249/wpn_npc_lmg_m249"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mac11/wpn_npc_mac11")
		}
	end
	wickweaponset2 = wickweaponset2 or function()
		tweak_data.character.jowi.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_sawnoff_shotgun/wpn_npc_sawnoff_shotgun"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull")
		}
	end
	wickweaponset3 = wickweaponset3 or function()
		tweak_data.character.jowi.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_g36/wpn_npc_g36"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mp5_tactical/wpn_npc_mp5_tactical")
		}
	end
   
	-- OLD HOXTON / OLD_HOXTON
	oldhoxnormalspeed = oldhoxnormalspeed or function()
		tweak_data.character.old_hoxton.move_speed = tweak_data.character.presets.move_speed.fast
	end
	oldhoxfastspeed = oldhoxfastspeed or function()
		tweak_data.character.old_hoxton.move_speed = tweak_data.character.presets.move_speed.lightning
	end
	oldhoxdodge = oldhoxdodge or function()
		tweak_data.character.old_hoxton.dodge = tweak_data.character.presets.dodge.athletic
	end
	oldhoxguard = oldhoxguard or function()
		tweak_data.character.old_hoxton.deathguard = nil
	end
	oldhoxweaponset1 = oldhoxweaponset1 or function()
		tweak_data.character.old_hoxton.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_lmg_m249/wpn_npc_lmg_m249"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mac11/wpn_npc_mac11")
		}
	end
	oldhoxweaponset2 = oldhoxweaponset2 or function()
		tweak_data.character.old_hoxton.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_sawnoff_shotgun/wpn_npc_sawnoff_shotgun"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull")
		}
	end
	oldhoxweaponset3 = oldhoxweaponset3 or function()
		tweak_data.character.old_hoxton.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_g36/wpn_npc_g36"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mp5_tactical/wpn_npc_mp5_tactical")
		}
	end
   
	-- CLOVER/ FEMALE_1
	clovernormalspeed = clovernormalspeed or function()
		tweak_data.character.female_1.move_speed = tweak_data.character.presets.move_speed.fast
	end
	cloverfastspeed = cloverfastspeed or function()
		tweak_data.character.female_1.move_speed = tweak_data.character.presets.move_speed.lightning
	end
	cloverdodge = cloverdodge or function()
		tweak_data.character.female_1.dodge = tweak_data.character.presets.dodge.athletic
	end
	cloverguard = cloverguard or function()
		tweak_data.character.female_1.deathguard = nil
	end
	cloverweaponset1 = cloverweaponset1 or function()
		tweak_data.character.female_1.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_lmg_m249/wpn_npc_lmg_m249"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mac11/wpn_npc_mac11")
		}
	end
	cloverweaponset2 = cloverweaponset2 or function()
		tweak_data.character.female_1.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_sawnoff_shotgun/wpn_npc_sawnoff_shotgun"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull")
		}
	end
	cloverweaponset3 = cloverweaponset3 or function()
		tweak_data.character.female_1.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_g36/wpn_npc_g36"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mp5_tactical/wpn_npc_mp5_tactical")
		}
	end    
   
	-- DRAGAN/ DRAGAN
	dragannormalspeed = dragannormalspeed or function()
		tweak_data.character.dragan.move_speed = tweak_data.character.presets.move_speed.fast
	end
	draganfastspeed = draganfastspeed or function()
		tweak_data.character.dragan.move_speed = tweak_data.character.presets.move_speed.lightning
	end
	dragandodge = dragandodge or function()
		tweak_data.character.dragan.dodge = tweak_data.character.presets.dodge.athletic
	end
	draganguard = draganguard or function()
		tweak_data.character.dragan.deathguard = nil
	end
	draganweaponset1 = draganweaponset1 or function()
		tweak_data.character.dragan.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_lmg_m249/wpn_npc_lmg_m249"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mac11/wpn_npc_mac11")
		}
	end
	draganweaponset2 = draganweaponset2 or function()
		tweak_data.character.dragan.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_sawnoff_shotgun/wpn_npc_sawnoff_shotgun"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull")
		}
	end
	draganweaponset3 = draganweaponset3 or function()
		tweak_data.character.dragan.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_g36/wpn_npc_g36"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mp5_tactical/wpn_npc_mp5_tactical")
		}
	end	
	
	-- Jacket/ jacket
	jacketnormalspeed = jacketnormalspeed or function()
		tweak_data.character.jacket.move_speed = tweak_data.character.presets.move_speed.fast
	end
	jacketfastspeed = jacketfastspeed or function()
		tweak_data.character.jacket.move_speed = tweak_data.character.presets.move_speed.lightning
	end
	jacketdodge = jacketdodge or function()
		tweak_data.character.jacket.dodge = tweak_data.character.presets.dodge.athletic
	end
	jacketguard = jacketguard or function()
		tweak_data.character.jacket.deathguard = nil
	end
	jacketweaponset1 = jacketweaponset1 or function()
		tweak_data.character.jacket.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_lmg_m249/wpn_npc_lmg_m249"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mac11/wpn_npc_mac11")
		}
	end
	jacketweaponset2 = jacketweaponset2 or function()
		tweak_data.character.jacket.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_sawnoff_shotgun/wpn_npc_sawnoff_shotgun"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull")
		}
	end
	jacketweaponset3 = jacketweaponset3 or function()
		tweak_data.character.jacket.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_g36/wpn_npc_g36"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mp5_tactical/wpn_npc_mp5_tactical")
		}
	end	
	
	-- Bonnie/ bonnie
	bonnienormalspeed = bonnienormalspeed or function()
		tweak_data.character.bonnie.move_speed = tweak_data.character.presets.move_speed.fast
	end
	bonniefastspeed = bonniefastspeed or function()
		tweak_data.character.bonnie.move_speed = tweak_data.character.presets.move_speed.lightning
	end
	bonniedodge = bonniedodge or function()
		tweak_data.character.bonnie.dodge = tweak_data.character.presets.dodge.athletic
	end
	bonnieguard = bonnieguard or function()
		tweak_data.character.bonnie.deathguard = nil
	end
	bonnieweaponset1 = bonnieweaponset1 or function()
		tweak_data.character.bonnie.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_lmg_m249/wpn_npc_lmg_m249"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mac11/wpn_npc_mac11")
		}
	end
	bonnieweaponset2 = bonnieweaponset2 or function()
		tweak_data.character.bonnie.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_sawnoff_shotgun/wpn_npc_sawnoff_shotgun"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull")
		}
	end
	bonnieweaponset3 = bonnieweaponset3 or function()
		tweak_data.character.bonnie.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_g36/wpn_npc_g36"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mp5_tactical/wpn_npc_mp5_tactical")
		}
	end	
	
	-- Sokol/ sokol
	function sokolnormalspeed()
		tweak_data.character.sokol.move_speed = tweak_data.character.presets.move_speed.fast
	end
	function sokolfastspeed()
		tweak_data.character.sokol.move_speed = tweak_data.character.presets.move_speed.lightning
	end
	function sokoldodge()
		tweak_data.character.sokol.dodge = tweak_data.character.presets.dodge.athletic
	end
	function sokolguard()
		tweak_data.character.sokol.deathguard = nil
	end
	function sokolweaponset1()
		tweak_data.character.sokol.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_lmg_m249/wpn_npc_lmg_m249"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mac11/wpn_npc_mac11")
		}
	end
	function sokolweaponset2()
		tweak_data.character.sokol.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_sawnoff_shotgun/wpn_npc_sawnoff_shotgun"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull")
		}
	end
	function sokolweaponset3()
		tweak_data.character.sokol.weapon.weapons_of_choice = {
			primary = Idstring("units/payday2/weapons/wpn_npc_g36/wpn_npc_g36"),
			secondary = Idstring("units/payday2/weapons/wpn_npc_mp5_tactical/wpn_npc_mp5_tactical")
		}
	end

	buffemall = function()
		-- SPOOCCUFFS
		spooccuffer()
		-- AI MOVESPEED
		dallasfastspeed()
		wolffastspeed()
		hoxtonfastspeed()
		chainsfastspeed()
		wickfastspeed()
		oldhoxfastspeed()
		cloverfastspeed()
		draganfastspeed()
		jacketfastspeed()
		bonniefastspeed()
		sokolfastspeed()
		-- AI DODGE
		dallasdodge()
		wolfdodge()
		hoxtondodge()
		chainsdodge()
		wickdodge()
		oldhoxdodge()
		cloverdodge()
		dragandodge()
		jacketdodge()
		bonniedodge()
		sokoldodge()
		-- AI WEAPONSET
		dallasweaponset1()
		wolfweaponset1()
		hoxtonweaponset1()
		chainsweaponset1()
		wickweaponset1()
		oldhoxweaponset1()
		cloverweaponset1()
		draganweaponset1()
		jacketweaponset1()
		bonnieweaponset1()
		sokolweaponset1()
		-- AI DEATHGUARD
		dallasguard()
		wolfguard()
		hoxtonguard()
		chainsguard()
		wickguard()
		oldhoxguard()
		cloverguard()
		draganguard()
		jacketguard()
		bonnieguard()
		sokolguard()
	end
   
	-- DISABLE ESCAPE TIMER by Harfatus
	function notimer()
		function ElementPointOfNoReturn:on_executed(...) end
	end
   
	-- PREVENT WAITING FOR PLAYERS AT START
	function dontwait()
		if managers.network:session() then
			managers.network:session():spawn_players()
		end    
	end
   
	-- UNLOCK ALL ASSETS
	function getemall()
		if inGame() then
			for _,asset_id in pairs(managers.assets:get_all_asset_ids(true)) do
				managers.assets:unlock_asset(asset_id)
			end    
		end    
	end
-------------------------------------------------------------------------------
	JobMenu = CustomMenuClass:new()
	JobMenu:addMainMenu('main_menu', {title = 'Меню работ'})
	JobMenu:addMenu('ai_menu', {title = 'Team AI Menu - Select Option', maxRows = 12})
	JobMenu:addMenu('chains_menu', {title = 'Чейнс МЕНЮ'})
	JobMenu:addMenu('dallas_menu', {title = 'Даллас МЕНЮ'})
	JobMenu:addMenu('hoxton_menu', {title = 'Хьюстно МЕНЮ'})
	JobMenu:addMenu('wolf_menu', {title = 'Вулф МЕНЮ'})
	JobMenu:addMenu('wick_menu', {title = 'Джон Уик МЕНЮ'})
	JobMenu:addMenu('oldhox_menu', {title = 'Старый Хокстон МЕНЮ'})
	JobMenu:addMenu('clover_menu', {title = 'Кловер МЕНЮ'})
	JobMenu:addMenu('dragan_menu', {title = 'Драган МЕНЮ'})
	JobMenu:addMenu('jacket_menu', {title = 'Джекет МЕНЮ'})
	JobMenu:addMenu('bonnie_menu', {title = 'Бонни МЕНЮ'})
	JobMenu:addMenu('sokol_menu', {title = 'Сокол МЕНЮ'})
   
	-- Job Menu
	JobMenu:addInformationOption('main_menu', 'Меню команды', {textColor = Color.red})
	if isHost() then
		JobMenu:addMenuOption('main_menu', 'Команда', 'ai_menu', {rectHighlightColor = Color.red})
	else
		JobMenu:addInformationOption('main_menu', 'Не доступно (Только хост)', {textColor = Color.yellow})
	end
	JobMenu:addGap('main_menu')
	JobMenu:addInformationOption('main_menu', 'Перед игрой', {textColor = Color.DodgerBlue})
	if isHost() then       
		JobMenu:addOption('main_menu', 'Быстрый старт',  {callback = dontwait, closeMenu = true, help = 'Нет времени ждать , надо стартовать!'})
	else
		JobMenu:addInformationOption('main_menu', 'Не доступно (Только хост)', {textColor = Color.yellow})
	end
	JobMenu:addOption('main_menu', 'Разблокировать все активы',  {callback =  getemall, closeMenu = true})
	JobMenu:addGap('main_menu')
	JobMenu:addGap('main_menu')
	JobMenu:addGap('main_menu')
	JobMenu:addGap('main_menu')
   
	-- Job Menu Column 2
	JobMenu:addGap('main_menu')
	JobMenu:addGap('main_menu')
	JobMenu:addGap('main_menu')
	JobMenu:addInformationOption('main_menu', 'В игре', {textColor = Color.DodgerBlue})
	if isHost() then
		if P3DGroup_P3DHack.Auto_Loot then
			JobMenu:addInformationOption('main_menu','Авто лут (Включено)', {textColor = Color.yellow})
		else
			JobMenu:addToggleOption('main_menu','Авто лут', {callback = function() Toggle.auto_loot = not Toggle.auto_loot end, help = 'Создает рандомный лут'})
		end
		if P3DGroup_P3DHack.Auto_Equipment then
			JobMenu:addInformationOption('main_menu','Auto Special Equipment (Включено)', {textColor = Color.yellow})
		else
			JobMenu:addToggleOption('main_menu','Auto Special Equipment', {callback = function() Toggle.auto_equip = not Toggle.auto_equip end, help = 'Spawns Randomized Keycards'})
		end
		if P3DGroup_P3DHack.Secure_BodyBags then
			JobMenu:addInformationOption('main_menu','Secure Body Bags For Cash (Включено)', {textColor = Color.yellow})
		else
			JobMenu:addToggleOption('main_menu','Secure Body Bags For Cash', {callback = function() Toggle.body_bag_secure = not Toggle.body_bag_secure end, help = 'Allows You To Secure Body Bags'})
		end
	else
		JobMenu:addInformationOption('main_menu', 'Не доступно (Только хост)', {textColor = Color.yellow})
		JobMenu:addInformationOption('main_menu', 'Не доступно (Только хост)', {textColor = Color.yellow})
		JobMenu:addInformationOption('main_menu', 'Не доступно (Только хост)', {textColor = Color.yellow})
	end
	if P3DGroup_P3DHack.Toggle_Interact then
		JobMenu:addInformationOption('main_menu','Переключить взаимодействие (Включено)', {textColor = Color.yellow})
	else
		JobMenu:addToggleOption('main_menu','Переключить взаимодействие', {callback = function() Toggle.toggle_interact = not Toggle.toggle_interact end, help = 'Переключить взаимодействие', toggle = false})
	end
	JobMenu:addGap('main_menu')
   
	-- Job Menu Column 3
	local level = managers.job:current_level_id()
	JobMenu:addGap('main_menu')
	JobMenu:addGap('main_menu')
	JobMenu:addGap('main_menu')
	JobMenu:addGap('main_menu')
	JobMenu:addGap('main_menu')
	if isHost() then
		if P3DGroup_P3DHack.Grenade_Restrict then
			JobMenu:addInformationOption('main_menu', 'Ограничение гранат (Включено)',  {textColor = Color.yellow})
		else   
			JobMenu:addToggleOption('main_menu', 'Ограничение гранат',  {callback = restrictgrenade, help = 'Ограничивает гранаты во время стелса'})
		end
		JobMenu:addOption('main_menu', 'Нет таймера эвакуации',  {callback = notimer, closeMenu = true})
		if P3DGroup_P3DHack.Loot_Value_Mod then
			JobMenu:addInformationOption('main_menu', 'Модификатор значения лута (Включено)',  {textColor = Color.yellow})
		else
			JobMenu:addToggleOption('main_menu', 'Модификатор значения лута',  {callback = function() Toggle.loot_modifier = not Toggle.loot_modifier end, help = 'Определяемое пользователем значение'})
		end
		if P3DGroup_P3DHack.Pager_Mod then
			if level == 'gallery' or level == 'kosugi' or level == 'firestarter_2' or level == 'big' or level == 'welcome_to_the_jungle_2' or level == 'election_day_1' or level == 'election_day_2' or level == 'election_day_3_skip1' or level == 'framing_frame_1' or level == 'framing_frame_3' or level == 'mallcrasher' then
				JobMenu:addInformationOption('main_menu', 'Добавить пейджеров (Включено)',  {textColor = Color.yellow})
			end
		else
			if level == 'gallery' or level == 'kosugi' or level == 'firestarter_2' or level == 'big' or level == 'welcome_to_the_jungle_2' or level == 'election_day_1' or level == 'election_day_2' or level == 'election_day_3_skip1' or level == 'framing_frame_1' or level == 'framing_frame_3' or level == 'mallcrasher' then
				JobMenu:addToggleOption('main_menu', 'Добавить пейджеров',  {callback = function() Toggle.pager_mod = not Toggle.pager_mod end, help = 'Увеличивает количество пейджеров'})
			end
		end
		if P3DGroup_P3DHack.Upgrade_Tweaks then
			JobMenu:addInformationOption('main_menu', 'Обновление щипков (Включено)',  {textColor = Color.yellow})
		else   
			JobMenu:addToggleOption('main_menu', 'Обновление щипков',  {callback = function() Toggle.upgrade_tweak = not Toggle.upgrade_tweak end, help = 'Пользовательское значение'})
		end
	else
		JobMenu:addInformationOption('main_menu', 'Не доступно (Только хост)', {textColor = Color.yellow})
		JobMenu:addInformationOption('main_menu', 'Не доступно (Только хост)', {textColor = Color.yellow})
		if not level == 'gallery' or level == 'kosugi' or level == 'firestarter_2' or level == 'big' or level == 'welcome_to_the_jungle_2' or level == 'election_day_1' or level == 'election_day_2' or level == 'election_day_3_skip1' or level == 'framing_frame_1' or level == 'framing_frame_3' or level == 'mallcrasher' then
			JobMenu:addInformationOption('main_menu', 'Не доступно (Только хост)', {textColor = Color.yellow})
		end
		JobMenu:addInformationOption('main_menu', 'Не доступно (Только хост)', {textColor = Color.yellow})
		JobMenu:addInformationOption('main_menu', 'Не доступно (Только хост)', {textColor = Color.yellow})
	end
	if P3DGroup_P3DHack.XP_Multiplier then
		JobMenu:addInformationOption('main_menu', 'XP множитель (Включено)', {textColor = Color.yellow})
	else   
		JobMenu:addToggleOption('main_menu', 'XP множитель',  {callback = xpmultiplier, help = 'Умножьте XP 2x'})
	end
   
	-- AI Menu
	JobMenu:addInformationOption('ai_menu', 'Остальное', {textColor = Color.red})
	-- Chains Menu
	JobMenu:addMenuOption('ai_menu', 'Chains', 'chains_menu', {rectHighlightColor = Color.red})
	JobMenu:addInformationOption('chains_menu', 'CHAINS', {textColor = Color.DodgerBlue})
	JobMenu:addOption('chains_menu', 'Включить уклонение от пуль', {callback = chainsdodge})
	JobMenu:addOption('chains_menu', 'Лечение игрока первоочередная задача', {callback = chainsguard})
	JobMenu:addOption('chains_menu', 'Нормальная скорость', {callback = chainsnormalspeed})
	JobMenu:addOption('chains_menu', 'Быстрая скорость', {callback = chainsfastspeed})
	JobMenu:addGap('chains_menu')
	JobMenu:addInformationOption('chains_menu', 'CHAINS Оружие', {textColor = Color.DodgerBlue})
	JobMenu:addOption('chains_menu', 'M249 / MAC11', {callback = chainsweaponset1})
	JobMenu:addOption('chains_menu', 'Sawnoff дробовик / .45', {callback = chainsweaponset2})
	JobMenu:addOption('chains_menu', 'G36 / MP5', {callback = chainsweaponset3})
   
	-- Dallas Menu
	JobMenu:addMenuOption('ai_menu', 'Dallas', 'dallas_menu', {rectHighlightColor = Color.red})
	JobMenu:addInformationOption('dallas_menu', 'DALLAS', {textColor = Color.DodgerBlue})
	JobMenu:addOption('dallas_menu', 'Включить уклонение от пуль', {callback = dallasdodge})
	JobMenu:addOption('dallas_menu', 'Лечение игрока первоочередная задача', {callback = dallasguard})
	JobMenu:addOption('dallas_menu', 'Нормальная скорость', {callback = dallasnormalspeed})
	JobMenu:addOption('dallas_menu', 'Быстрая скорость', {callback = dallasfastspeed})
	JobMenu:addGap('dallas_menu')
	JobMenu:addInformationOption('dallas_menu', 'DALLAS Оружие', {textColor = Color.DodgerBlue})
	JobMenu:addOption('dallas_menu', 'M249 / MAC11', {callback = dallasweaponset1})
	JobMenu:addOption('dallas_menu', 'Sawnoff дробовик / .45', {callback = dallasweaponset2})
	JobMenu:addOption('dallas_menu', 'G36 / MP5', {callback = dallasweaponset3})
   
	-- Hoxton Menu
	JobMenu:addMenuOption('ai_menu', 'Hoxton', 'hoxton_menu', {rectHighlightColor = Color.red})
	JobMenu:addInformationOption('hoxton_menu', 'HOXTON', {textColor = Color.DodgerBlue})
	JobMenu:addOption('hoxton_menu', 'Включить уклонение от пуль', {callback = hoxtondodge})
	JobMenu:addOption('hoxton_menu', 'Лечение игрока первоочередная задача', {callback = hoxtonguard})
	JobMenu:addOption('hoxton_menu', 'Нормальная скорость', {callback = hoxtonnormalspeed})
	JobMenu:addOption('hoxton_menu', 'Быстрая скорость', {callback = hoxtonfastspeed})
	JobMenu:addGap('hoxton_menu')
	JobMenu:addInformationOption('hoxton_menu', 'HOXTON оружие', {textColor = Color.DodgerBlue})
	JobMenu:addOption('hoxton_menu', 'M249 / MAC11', {callback = hoxtonweaponset1})
	JobMenu:addOption('hoxton_menu', 'Sawnoff дробовик / .45', {callback = hoxtonweaponset2})
	JobMenu:addOption('hoxton_menu', 'G36 / MP5', {callback = hoxtonweaponset3})
   
	-- Wolf Menu
	JobMenu:addMenuOption('ai_menu', 'Wolf', 'wolf_menu', {rectHighlightColor = Color.red})
	JobMenu:addInformationOption('wolf_menu', 'WOLF', {textColor = Color.DodgerBlue})
	JobMenu:addOption('wolf_menu', 'Включить уклонение от пуль', {callback = wolfdodge})
	JobMenu:addOption('wolf_menu', 'Лечение игрока первоочередная задача', {callback = wolfguard})
	JobMenu:addOption('wolf_menu', 'Нормальная скорость', {callback = wolfnormalspeed})
	JobMenu:addOption('wolf_menu', 'Быстрая скорость', {callback = wolffastspeed})
	JobMenu:addGap('wolf_menu')
	JobMenu:addInformationOption('wolf_menu', 'WOLF оружие', {textColor = Color.DodgerBlue})
	JobMenu:addOption('wolf_menu', 'M249 / MAC11', {callback = wolfweaponset1})
	JobMenu:addOption('wolf_menu', 'Sawnoff дробовик / .45', {callback = wolfweaponset2})
	JobMenu:addOption('wolf_menu', 'G36 / MP5', {callback = wolfweaponset3})
   
	-- John Wick Menu
	JobMenu:addMenuOption('ai_menu', 'John Wick', 'wick_menu', {rectHighlightColor = Color.red})
	JobMenu:addInformationOption('wick_menu', 'JOHN WICK OPTIONS', {textColor = Color.DodgerBlue})
	JobMenu:addOption('wick_menu', 'Включить уклонение от пуль', {callback = wickdodge})
	JobMenu:addOption('wick_menu', 'Лечение игрока первоочередная задача', {callback = wickguard})
	JobMenu:addOption('wick_menu', 'Нормальная скорость', {callback = wicknormalspeed})
	JobMenu:addOption('wick_menu', 'Быстрая скорость', {callback = wickfastspeed})
	JobMenu:addGap('wick_menu')
	JobMenu:addInformationOption('wick_menu', 'JOHN WICK оружие', {textColor = Color.DodgerBlue})
	JobMenu:addOption('wick_menu', 'M249 / MAC11', {callback = wickweaponset1})
	JobMenu:addOption('wick_menu', 'Sawnoff дробовик / .45', {callback = wickweaponset2})
	JobMenu:addOption('wick_menu', 'G36 / MP5', {callback = wickweaponset3})
   
	-- Old Hoxton Menu
	JobMenu:addMenuOption('ai_menu', 'Old Hoxton', 'oldhox_menu', {rectHighlightColor = Color.red})
	JobMenu:addInformationOption('oldhox_menu', 'OLD HOXTON', {textColor = Color.DodgerBlue})
	JobMenu:addOption('oldhox_menu', 'Включить уклонение от пуль', {callback = oldhoxdodge})
	JobMenu:addOption('oldhox_menu', 'Лечение игрока первоочередная задача', {callback = oldhoxguard})
	JobMenu:addOption('oldhox_menu', 'Нормальная скорость', {callback = oldhoxnormalspeed})
	JobMenu:addOption('oldhox_menu', 'Быстрая скорость', {callback = oldhoxfastspeed})
	JobMenu:addGap('oldhox_menu')
	JobMenu:addInformationOption('oldhox_menu', 'OLD HOXTON оружие', {textColor = Color.DodgerBlue})
	JobMenu:addOption('oldhox_menu', 'M249 / MAC11', {callback = oldhoxweaponset1})
	JobMenu:addOption('oldhox_menu', 'Sawnoff дробовик / .45', {callback = oldhoxweaponset2})
	JobMenu:addOption('oldhox_menu', 'G36 / MP5', {callback = oldhoxweaponset3})
   
	-- Clover Menu
	JobMenu:addMenuOption('ai_menu', 'Clover', 'clover_menu', {rectHighlightColor = Color.red})
	JobMenu:addInformationOption('clover_menu', 'CLOVER', {textColor = Color.DodgerBlue})
	JobMenu:addOption('clover_menu', 'Включить уклонение от пуль', {callback = cloverdodge})
	JobMenu:addOption('clover_menu', 'Лечение игрока первоочередная задача', {callback = cloverguard})
	JobMenu:addOption('clover_menu', 'Нормальная скорость', {callback = clovernormalspeed})
	JobMenu:addOption('clover_menu', 'Быстрая скорость', {callback = cloverfastspeed})
	JobMenu:addGap('clover_menu')
	JobMenu:addInformationOption('clover_menu', 'CLOVER оружие', {textColor = Color.DodgerBlue})
	JobMenu:addOption('clover_menu', 'M249 / MAC11', {callback = cloverweaponset1})
	JobMenu:addOption('clover_menu', 'Sawnoff дробовик / .45', {callback = cloverweaponset2})
	JobMenu:addOption('clover_menu', 'G36 / MP5', {callback = cloverweaponset3})   
   
	-- Dragan Menu
	JobMenu:addMenuOption('ai_menu', 'Dragan', 'dragan_menu', {rectHighlightColor = Color.red})
	JobMenu:addInformationOption('dragan_menu', 'DRAGAN ', {textColor = Color.DodgerBlue})
	JobMenu:addOption('dragan_menu', 'Включить уклонение от пуль', {callback = dragandodge})
	JobMenu:addOption('dragan_menu', 'Лечение игрока первоочередная задача', {callback = draganguard})
	JobMenu:addOption('dragan_menu', 'Нормальная скорость', {callback = dragannormalspeed})
	JobMenu:addOption('dragan_menu', 'Быстрая скорость', {callback = draganfastspeed})
	JobMenu:addGap('dragan_menu')
	JobMenu:addInformationOption('dragan_menu', 'DRAGAN оружие', {textColor = Color.DodgerBlue})
	JobMenu:addOption('dragan_menu', 'M249 / MAC11', {callback = draganweaponset1})
	JobMenu:addOption('dragan_menu', 'Sawnoff дробовик / .45', {callback = draganweaponset2})
	JobMenu:addOption('dragan_menu', 'G36 / MP5', {callback = draganweaponset3})	
	
	-- Jacket Menu
	JobMenu:addMenuOption('ai_menu', 'Jacket', 'jacket_menu', {rectHighlightColor = Color.red})
	JobMenu:addInformationOption('jacket_menu', 'JACKET OPTIONS', {textColor = Color.DodgerBlue})
	JobMenu:addOption('jacket_menu', 'Включить уклонение от пуль', {callback = jacketdodge})
	JobMenu:addOption('jacket_menu', 'Лечение игрока первоочередная задача', {callback = jacketguard})
	JobMenu:addOption('jacket_menu', 'Нормальная скорость', {callback = jacketnormalspeed})
	JobMenu:addOption('jacket_menu', 'Быстрая скорость', {callback = jacketfastspeed})
	JobMenu:addGap('jacket_menu')
	JobMenu:addInformationOption('jacket_menu', 'JACKET оружие', {textColor = Color.DodgerBlue})
	JobMenu:addOption('jacket_menu', 'M249 / MAC11', {callback = jacketweaponset1})
	JobMenu:addOption('jacket_menu', 'Sawnoff дробовик / .45', {callback = jacketweaponset2})
	JobMenu:addOption('jacket_menu', 'G36 / MP5', {callback = jacketweaponset3})	
	
	-- Bonnie Menu
	JobMenu:addMenuOption('ai_menu', 'Bonnie', 'bonnie_menu', {rectHighlightColor = Color.red})
	JobMenu:addInformationOption('bonnie_menu', 'BONNIE', {textColor = Color.DodgerBlue})
	JobMenu:addOption('bonnie_menu', 'Включить уклонение от пуль', {callback = bonniedodge})
	JobMenu:addOption('bonnie_menu', 'Лечение игрока первоочередная задача', {callback = bonnieguard})
	JobMenu:addOption('bonnie_menu', 'Нормальная скорость', {callback = bonnienormalspeed})
	JobMenu:addOption('bonnie_menu', 'Быстрая скорость', {callback = bonniefastspeed})
	JobMenu:addGap('bonnie_menu')
	JobMenu:addInformationOption('bonnie_menu', 'BONNIE оружие', {textColor = Color.DodgerBlue})
	JobMenu:addOption('bonnie_menu', 'M249 / MAC11', {callback = bonnieweaponset1})
	JobMenu:addOption('bonnie_menu', 'Sawnoff дробовик / .45', {callback = bonnieweaponset2})
	JobMenu:addOption('bonnie_menu', 'G36 / MP5', {callback = bonnieweaponset3})	
	
	-- Sokol Menu
	JobMenu:addMenuOption('ai_menu', 'Sokol', 'sokol_menu', {rectHighlightColor = Color.red})
	JobMenu:addInformationOption('sokol_menu', 'SOKOL ', {textColor = Color.DodgerBlue})
	JobMenu:addOption('sokol_menu', 'Включить уклонение от пуль', {callback = sokoldodge})
	JobMenu:addOption('sokol_menu', 'Лечение игрока первоочередная задача', {callback = sokolguard})
	JobMenu:addOption('sokol_menu', 'Нормальная скорость', {callback = sokolnormalspeed})
	JobMenu:addOption('sokol_menu', 'Быстрая скорость', {callback = sokolfastspeed})
	JobMenu:addGap('sokol_menu')
	JobMenu:addInformationOption('sokol_menu', 'SOKOL оружие', {textColor = Color.DodgerBlue})
	JobMenu:addOption('sokol_menu', 'M249 / MAC11', {callback = sokolweaponset1})
	JobMenu:addOption('sokol_menu', 'Sawnoff дробовик / .45', {callback = sokolweaponset2})
	JobMenu:addOption('sokol_menu', 'G36 / MP5', {callback = sokolweaponset3})
   
	-- AI MENU
	JobMenu:addInformationOption('ai_menu', 'Другое', {textColor = Color.DodgerBlue})
	JobMenu:addOption('ai_menu', 'Все бафы включены', {callback = buffemall})
	JobMenu:addOption('ai_menu', 'Клокер бьет только ботов', {callback = spooccuffer})
end
 
if inGame() and not isPlaying() then   
	if JobMenu:isOpen() then
		JobMenu:close()
	else
		JobMenu:open()
	end    
end
------------------------------------------------------------------------------------------------------------------------
-- INGAME
-- HIDE HUD TOGGLE
if P3DGroup_P3DHack.Hud_Toggle then
	if isPlaying() then
		Toggle.hudvisible = not Toggle.hudvisible
		if not Toggle.hudvisible then
			managers.hud:set_enabled()
			showHint('HUD ВКЛЮЧЕН', 2)
			return
		end		   
		managers.hud:set_disabled()
	end
end

