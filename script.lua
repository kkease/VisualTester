local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "GrowSpawnGUI"

local replicatedStorage = game:GetService("ReplicatedStorage")
local remote = replicatedStorage:FindFirstChildWhichIsA("RemoteEvent", true)

-- Full Pet and Seed List
local Pets = { "Bunny","Dog","Golden Lab","Bee","Hedgehog","Kiwi","Monkey","Orange Tabby","Pig","Rooster","Spotted Deer","Honey Bee",
"Blood Hedgehog","Blood Kiwi","Cow","Snail","Queen Bee","Bear Bee","Frog","Giant Ant","Grey Mouse","Mole","Night Owl",
"Owl","Pack Bee","Panda","Polar Bear","Praying Mantis","Purple Dragonfly","Brown Mouse","Squirrel","Red Giant Ant",
"Red Fox","Kiki","Dragonfly","Raccoon","Zombie Chicken","Cooked Owl","Moon Cat","Sea Otter","Tarantula Hawk","Wasp" }

local Seeds = { "Apple","Avocado","Bamboo","Banana","Beanstalk","Blood Banana","Blue Lollipop","Blueberry","Cacao","Cactus",
"Candy Blossom","Candy Sunflower","Celestberry","Cherry Blossom","Chocolate Carrot","Coconut","Cranberry",
"Cursed Fruit","Dragon Fruit","Durian","Easter Egg","Eggplant","Ember Lily","Foxglove","Glowshroom","Grape",
"Lemon","Lilac","Lotus","Mint","Moon Blossom","Moon Mango","Moonflower","Moonglow","Mushroom","Nightshade",
"Papaya","Passionfruit","Peach","Pear","Pepper","Pineapple","Pink Lily","Pumpkin","Purple Dahlia","Rainbow Sack",
"Raspberry","Rose","Soul Fruit","Starfruit","Strawberry","Sugar Apple","Super Seed","Tomato","Venus Flytrap",
"Watermelon" }

-- GUI
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 360, 0, 280)
frame.Position = UDim2.new(0.5, -180, 0.5, -140)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🌱 Grow A Garden (Xeno GUI) 🌱"
title.Font = Enum.Font.SourceSansBold
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.TextSize = 20

-- Dropdown TextBoxes
local petBox = Instance.new("TextBox", frame)
petBox.PlaceholderText = "Select Pet..."
petBox.Position = UDim2.new(0, 10, 0, 40)
petBox.Size = UDim2.new(1, -20, 0, 30)
petBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
petBox.TextColor3 = Color3.new(1, 1, 1)
petBox.Font = Enum.Font.SourceSans
petBox.TextSize = 14

local seedBox = Instance.new("TextBox", frame)
seedBox.PlaceholderText = "Select Seed..."
seedBox.Position = UDim2.new(0, 10, 0, 80)
seedBox.Size = UDim2.new(1, -20, 0, 30)
seedBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
seedBox.TextColor3 = Color3.new(1, 1, 1)
seedBox.Font = Enum.Font.SourceSans
seedBox.TextSize = 14

-- Spawn Buttons
local spawnPetBtn = Instance.new("TextButton", frame)
spawnPetBtn.Position = UDim2.new(0, 10, 0, 130)
spawnPetBtn.Size = UDim2.new(1, -20, 0, 40)
spawnPetBtn.Text = "Spawn Pet"
spawnPetBtn.Font = Enum.Font.SourceSansBold
spawnPetBtn.TextSize = 16
spawnPetBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
spawnPetBtn.TextColor3 = Color3.new(1, 1, 1)

local spawnSeedBtn = Instance.new("TextButton", frame)
spawnSeedBtn.Position = UDim2.new(0, 10, 0, 180)
spawnSeedBtn.Size = UDim2.new(1, -20, 0, 40)
spawnSeedBtn.Text = "Spawn Seed"
spawnSeedBtn.Font = Enum.Font.SourceSansBold
spawnSeedBtn.TextSize = 16
spawnSeedBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
spawnSeedBtn.TextColor3 = Color3.new(1, 1, 1)

-- Functions
local function notify(msg)
	pcall(function()
		game.StarterGui:SetCore("SendNotification", {
			Title = "Grow GUI",
			Text = msg,
			Duration = 3
		})
	end)
end

spawnPetBtn.MouseButton1Click:Connect(function()
	local name = petBox.Text
	if table.find(Pets, name) then
		remote:FireServer("Pet", name, 1, 1) -- Placeable size + age
		notify("✅ Pet placed: " .. name)
	else
		notify("❌ Invalid pet")
	end
end)

spawnSeedBtn.MouseButton1Click:Connect(function()
	local name = seedBox.Text
	if table.find(Seeds, name) then
		remote:FireServer("Seed", name)
		notify("✅ Seed placed: " .. name)
	else
		notify("❌ Invalid seed")
	end
end)
