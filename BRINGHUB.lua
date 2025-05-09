-- GUI + Bring All Items Script + Toggle + Draggable
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- Buat GUI utama
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "BringItemsGUI"
ScreenGui.ResetOnSpawn = false

-- Tombol Show/Hide
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 60, 0, 25)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Text = "Show"
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 14
ToggleButton.BorderSizePixel = 0

-- Frame utama
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0.5, -100, 0.1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 2
Frame.Visible = false -- Awal disembunyikan
Frame.Active = true
Frame.Draggable = true -- Bisa dipindah

-- Rainbow outline
spawn(function()
	local h = 0
	while true do
		h = (h + 1) % 360
		local color = Color3.fromHSV(h/360, 1, 1)
		if Frame then
			Frame.BorderColor3 = color
		end
		wait(0.05)
	end
end)

-- Label dan tombol Bring
local TextLabel = Instance.new("TextLabel", Frame)
TextLabel.Size = UDim2.new(1, 0, 0.3, 0)
TextLabel.Text = "Dead Rails Item ESP"
TextLabel.BackgroundTransparency = 1
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.TextSize = 16

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(0.8, 0, 0.4, 0)
Button.Position = UDim2.new(0.1, 0, 0.5, 0)
Button.Text = "Bring All Items"
Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 14
Button.BorderSizePixel = 0

-- Daftar item
local itemNames = {
	"Bandage", "Snake Oil", "Shovel", "Pickaxe", "Tomahawk", "Jade Sword", "Vampire Knife",
	"Cavalry Sword", "Revolver", "Shotgun", "Rifle", "Electrocutioner", "Mauser C96",
	"Sawed-Off Shotgun", "Bolt-Action Rifle", "Navy Revolver", "Molotov", "Holy Water",
	"Dynamite", "Barbed Wire", "Crucifix", "Maxim Turret", "Cannon", "Sheet Metal",
	"Fire Torch", "Coal", "Corpses", "Camera", "Ammunition", "Unicorn", "Gold Ingot",
	"Gold Statue", "Gold Painting", "Silver Ingot", "Gold Cup", "Werewolf Corpse",
	"Gold Plate", "Silver Statue", "Vampire Corpse", "Gold Watch", "Silver Painting",
	"Silver Cup", "Silver Plate", "Silver Watch", "Stone Statue", "Wood Painting",
	"Bond", "Rope", "Barrel", "Box", "Chair", "Pot", "Tea", "Wheel", "Jade Tablet"
}

-- Fungsi Bring
local function bringItems()
	for _, name in ipairs(itemNames) do
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("Tool") or obj:IsA("Model") or obj:IsA("Part") then
				if obj.Name == name then
					pcall(function()
						obj:PivotTo(hrp.CFrame + Vector3.new(math.random(-5,5), 0, math.random(-5,5)))
					end)
				end
			end
		end
	end
end

Button.MouseButton1Click:Connect(bringItems)

-- Fungsi Show/Hide GUI
ToggleButton.MouseButton1Click:Connect(function()
	Frame.Visible = not Frame.Visible
	ToggleButton.Text = Frame.Visible and "Hide" or "Show"
end)
