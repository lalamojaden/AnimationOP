--// LALAMOJADEN ANIMATION LOADER
--// Roblox Studio - LocalScript
--// Respawn/Reset = animations automatically apply again

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--------------------------------------------------
-- ANIMATION IDS
--------------------------------------------------

local ANIMATIONS = {
	Idle = "616158929",          -- Zombie Idle
	Run = "616163682",           -- Zombie Run
	Jump = "656117878",          -- Ninja Jump
	Fall = "18537367238",        -- adidas Sports Fall
	Walk = "18537392113"         -- adidas Sports Walk
}

--------------------------------------------------
-- CHANGE ANIMATION
--------------------------------------------------

local function setAnimation(animate, folderName, animationId)
	if not animate then
		return
	end

	local folder = animate:FindFirstChild(folderName)

	if not folder then
		return
	end

	for _, object in ipairs(folder:GetChildren()) do
		if object:IsA("Animation") then
			object.AnimationId = "rbxassetid://" .. animationId
		end
	end
end

--------------------------------------------------
-- APPLY ALL ANIMATIONS
--------------------------------------------------

local function applyAnimations(character)
	local animate = character:WaitForChild("Animate", 10)

	if not animate then
		warn("Animate script not found.")
		return
	end

	setAnimation(animate, "idle", ANIMATIONS.Idle)
	setAnimation(animate, "run", ANIMATIONS.Run)
	setAnimation(animate, "jump", ANIMATIONS.Jump)
	setAnimation(animate, "fall", ANIMATIONS.Fall)
	setAnimation(animate, "walk", ANIMATIONS.Walk)

	-- Refresh Animate
	animate.Enabled = false
	task.wait()
	animate.Enabled = true
end

--------------------------------------------------
-- RESPAWN / RESET
--------------------------------------------------

player.CharacterAdded:Connect(function(character)
	-- Wait for the new character to fully load
	character:WaitForChild("Humanoid")
	
	task.wait(0.25)

	-- Apply animations again
	applyAnimations(character)
end)

--------------------------------------------------
-- INITIAL CHARACTER
--------------------------------------------------

if player.Character then
	applyAnimations(player.Character)
end

--------------------------------------------------
-- LOADING SCREEN
--------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "LALAMOJADENLoading"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 999
gui.Parent = playerGui

local background = Instance.new("Frame")
background.Size = UDim2.fromScale(1, 1)
background.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
background.BorderSizePixel = 0
background.Parent = gui

local title = Instance.new("TextLabel")
title.AnchorPoint = Vector2.new(.5, .5)
title.Position = UDim2.fromScale(.5, .40)
title.Size = UDim2.fromOffset(500, 60)
title.BackgroundTransparency = 1
title.Text = "TikTok"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = background

local username = Instance.new("TextLabel")
username.AnchorPoint = Vector2.new(.5, .5)
username.Position = UDim2.fromScale(.5, .48)
username.Size = UDim2.fromOffset(500, 45)
username.BackgroundTransparency = 1
username.Text = "lalamojaden"
username.TextColor3 = Color3.fromRGB(220, 220, 220)
username.TextScaled = true
username.Font = Enum.Font.GothamMedium
username.Parent = background

local percent = Instance.new("TextLabel")
percent.AnchorPoint = Vector2.new(.5, .5)
percent.Position = UDim2.fromScale(.5, .58)
percent.Size = UDim2.fromOffset(300, 45)
percent.BackgroundTransparency = 1
percent.Text = "1%"
percent.TextColor3 = Color3.new(1, 1, 1)
percent.TextScaled = true
percent.Font = Enum.Font.GothamBold
percent.Parent = background

local barBack = Instance.new("Frame")
barBack.AnchorPoint = Vector2.new(.5, .5)
barBack.Position = UDim2.fromScale(.5, .65)
barBack.Size = UDim2.fromOffset(350, 12)
barBack.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
barBack.BorderSizePixel = 0
barBack.Parent = background

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = barBack

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
bar.BorderSizePixel = 0
bar.Parent = barBack

local barCorner2 = Instance.new("UICorner")
barCorner2.CornerRadius = UDim.new(1, 0)
barCorner2.Parent = bar

--------------------------------------------------
-- LOADING 1-100
--------------------------------------------------

for i = 1, 100 do
	percent.Text = i .. "%"
	bar.Size = UDim2.new(i / 100, 0, 1, 0)

	task.wait(0.01)
end

--------------------------------------------------
-- NOTIFICATION
--------------------------------------------------

local notification = Instance.new("TextLabel")
notification.AnchorPoint = Vector2.new(1, 1)
notification.Position = UDim2.new(1, -20, 1, -20)
notification.Size = UDim2.fromOffset(350, 70)
notification.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
notification.Text =
	"✓ Animation loaded!\nDon't forget to follow lalamojaden."
notification.TextColor3 = Color3.new(1, 1, 1)
notification.TextSize = 15
notification.Font = Enum.Font.GothamBold
notification.TextWrapped = true
notification.Parent = playerGui

local notificationCorner = Instance.new("UICorner")
notificationCorner.CornerRadius = UDim.new(0, 12)
notificationCorner.Parent = notification

--------------------------------------------------
-- REMOVE LOADING SCREEN
--------------------------------------------------

task.wait(2)

local fade = TweenService:Create(
	background,
	TweenInfo.new(.35),
	{BackgroundTransparency = 1}
)

fade:Play()

for _, object in ipairs(background:GetDescendants()) do
	if object:IsA("TextLabel") then
		TweenService:Create(
			object,
			TweenInfo.new(.35),
			{TextTransparency = 1}
		):Play()
	end
end

fade.Completed:Wait()
gui:Destroy()
