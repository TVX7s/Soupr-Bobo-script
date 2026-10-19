local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SuperBoboHubWeb"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
	if gethui then
		ScreenGui.Parent = gethui()
	elseif syn and syn.protect_gui then
		syn.protect_gui(ScreenGui)
		ScreenGui.Parent = game:GetService("CoreGui")
	else
		ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	end
end)

local WebContainer = Instance.new("Frame")
WebContainer.Name = "WebContainer"
WebContainer.Size = UDim2.new(0, 360, 0, 280)
WebContainer.Position = UDim2.new(0.5, -180, 0.5, -140)
WebContainer.BackgroundColor3 = Color3.fromRGB(13, 15, 20)
WebContainer.BorderSizePixel = 0
WebContainer.Active = true
WebContainer.Draggable = true
WebContainer.Parent = ScreenGui

local WebCorner = Instance.new("UICorner")
WebCorner.CornerRadius = UDim.new(0, 8)
WebCorner.Parent = WebContainer

local WebStroke = Instance.new("UIStroke")
WebStroke.Thickness = 1.5
WebStroke.Color = Color3.fromRGB(0, 210, 255)
WebStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
WebStroke.Parent = WebContainer

local BrowserHeader = Instance.new("Frame")
BrowserHeader.Name = "BrowserHeader"
BrowserHeader.Size = UDim2.new(1, 0, 0, 28)
BrowserHeader.BackgroundColor3 = Color3.fromRGB(20, 23, 31)
BrowserHeader.BorderSizePixel = 0
BrowserHeader.Parent = WebContainer

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = BrowserHeader

local FixBottomCorner = Instance.new("Frame")
FixBottomCorner.Size = UDim2.new(1, 0, 0, 8)
FixBottomCorner.Position = UDim2.new(0, 0, 1, -8)
FixBottomCorner.BackgroundColor3 = Color3.fromRGB(20, 23, 31)
FixBottomCorner.BorderSizePixel = 0
FixBottomCorner.Parent = BrowserHeader

local DotsHolder = Instance.new("Frame")
DotsHolder.Size = UDim2.new(0, 50, 1, 0)
DotsHolder.Position = UDim2.new(0, 8, 0, 0)
DotsHolder.BackgroundTransparency = 1
DotsHolder.Parent = BrowserHeader

local DotLayout = Instance.new("UIListLayout")
DotLayout.FillDirection = Enum.FillDirection.Horizontal
DotLayout.VerticalAlignment = Enum.VerticalAlignment.Center
DotLayout.Padding = UDim.new(0, 5)
DotLayout.Parent = DotsHolder

local function CreateDot(color)
	local d = Instance.new("Frame")
	d.Size = UDim2.new(0, 10, 0, 10)
	d.BackgroundColor3 = color
	d.BorderSizePixel = 0
	d.Parent = DotsHolder
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(1, 0)
	c.Parent = d
	return d
end

local CloseDot = CreateDot(Color3.fromRGB(255, 95, 87))
CreateDot(Color3.fromRGB(255, 189, 46))
CreateDot(Color3.fromRGB(39, 201, 63))

local CloseClicker = Instance.new("TextButton")
CloseClicker.Size = UDim2.new(1, 0, 1, 0)
CloseClicker.BackgroundTransparency = 1
CloseClicker.Text = ""
CloseClicker.Parent = CloseDot
CloseClicker.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

local UrlBar = Instance.new("Frame")
UrlBar.Size = UDim2.new(1, -110, 0, 18)
UrlBar.Position = UDim2.new(0, 65, 0.5, -9)
UrlBar.BackgroundColor3 = Color3.fromRGB(10, 11, 16)
UrlBar.BorderSizePixel = 0
UrlBar.Parent = BrowserHeader

local UrlCorner = Instance.new("UICorner")
UrlCorner.CornerRadius = UDim.new(0, 4)
UrlCorner.Parent = UrlBar

local UrlText = Instance.new("TextLabel")
UrlText.Size = UDim2.new(1, -10, 1, 0)
UrlText.Position = UDim2.new(0, 5, 0, 0)
UrlText.BackgroundTransparency = 1
UrlText.Text = "https://سوبر-بوبو.com"
UrlText.Font = Enum.Font.Code
UrlText.TextSize = 10
UrlText.TextColor3 = Color3.fromRGB(0, 210, 255)
UrlText.TextXAlignment = Enum.TextXAlignment.Left
UrlText.Parent = UrlBar

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -16, 0, 28)
SearchBox.Position = UDim2.new(0, 8, 0, 34)
SearchBox.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
SearchBox.PlaceholderText = "🔍 اسم اللاعب..."
SearchBox.PlaceholderColor3 = Color3.fromRGB(110, 120, 140)
SearchBox.Text = ""
SearchBox.Font = Enum.Font.GothamMedium
SearchBox.TextSize = 11
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.ClearTextOnFocus = false
SearchBox.Parent = WebContainer

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 6)
SearchCorner.Parent = SearchBox

local SearchStroke = Instance.new("UIStroke")
SearchStroke.Thickness = 1
SearchStroke.Color = Color3.fromRGB(35, 45, 60)
SearchStroke.Parent = SearchBox

local Card = Instance.new("Frame")
Card.Size = UDim2.new(1, -16, 0, 122)
Card.Position = UDim2.new(0, 8, 0, 68)
Card.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
Card.BorderSizePixel = 0
Card.Parent = WebContainer

local CardCorner = Instance.new("UICorner")
CardCorner.CornerRadius = UDim.new(0, 6)
CardCorner.Parent = Card

local AvatarImg = Instance.new("ImageLabel")
AvatarImg.Size = UDim2.new(0, 55, 0, 55)
AvatarImg.Position = UDim2.new(0, 8, 0.5, -27)
AvatarImg.BackgroundColor3 = Color3.fromRGB(10, 12, 16)
AvatarImg.Image = "rbxassetid://0"
AvatarImg.Parent = Card

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(0, 6)
AvatarCorner.Parent = AvatarImg

local AvatarStroke = Instance.new("UIStroke")
AvatarStroke.Thickness = 1.5
AvatarStroke.Color = Color3.fromRGB(0, 210, 255)
AvatarStroke.Parent = AvatarImg

local InfoContainer = Instance.new("Frame")
InfoContainer.Size = UDim2.new(1, -75, 1, -12)
InfoContainer.Position = UDim2.new(0, 70, 0, 6)
InfoContainer.BackgroundTransparency = 1
InfoContainer.Parent = Card

local UIList = Instance.new("UIListLayout")
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 3)
UIList.Parent = InfoContainer

local function CreateInfoLabel(order)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, 0, 0, 24)
	lbl.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
	lbl.Font = Enum.Font.Gotham
	lbl.TextSize = 10
	lbl.TextColor3 = Color3.fromRGB(200, 210, 225)
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.LayoutOrder = order
	lbl.Parent = InfoContainer
	
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 4)
	c.Parent = lbl
	
	local p = Instance.new("UIPadding")
	p.PaddingLeft = UDim.new(0, 6)
	p.Parent = lbl
	return lbl
end

local NameLbl = CreateInfoLabel(1)
local DisplayNameLbl = CreateInfoLabel(2)
local IdLbl = CreateInfoLabel(3)
local JoinedLbl = CreateInfoLabel(4)

NameLbl.Text = "User: -"
DisplayNameLbl.Text = "Username: -"
IdLbl.Text = "ID: -"
JoinedLbl.Text = "Joined: -"

local ActionBtn = Instance.new("TextButton")
ActionBtn.Size = UDim2.new(1, -16, 0, 32)
ActionBtn.Position = UDim2.new(0, 8, 0, 198)
ActionBtn.BackgroundColor3 = Color3.fromRGB(235, 35, 75)
ActionBtn.Text = "تخريب اللاعب 😂"
ActionBtn.Font = Enum.Font.GothamBold
ActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ActionBtn.TextSize = 12
ActionBtn.AutoButtonColor = false
ActionBtn.Parent = WebContainer

local BtnCorner1 = Instance.new("UICorner")
BtnCorner1.CornerRadius = UDim.new(0, 6)
BtnCorner1.Parent = ActionBtn

local FreezeBtn = Instance.new("TextButton")
FreezeBtn.Size = UDim2.new(1, -16, 0, 32)
FreezeBtn.Position = UDim2.new(0, 8, 0, 236)
FreezeBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
FreezeBtn.Text = "🚫 ما يمديه يتحرك"
FreezeBtn.Font = Enum.Font.GothamBold
FreezeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FreezeBtn.TextSize = 12
FreezeBtn.AutoButtonColor = false
FreezeBtn.Parent = WebContainer

local BtnCorner2 = Instance.new("UICorner")
BtnCorner2.CornerRadius = UDim.new(0, 6)
BtnCorner2.Parent = FreezeBtn

local SelectedPlayer = nil
local TrollingActive = false
local FreezingActive = false

local function GetPlayerByShortcut(text)
	text = text:lower()
	if text == "" then return nil end
	for _, p in pairs(Players:GetPlayers()) do
		if p.Name:lower():sub(1, #text) == text or p.DisplayName:lower():sub(1, #text) == text then
			return p
		end
	end
	return nil
end

local function GetJoinDate(userId)
	local success, result = pcall(function()
		local url = "https://users.roblox.com/v1/users/" .. userId
		local data = HttpService:JSONDecode(game:HttpGet(url))
		local created = data.created
		local year, month, day = created:match("^(%d+)-(%d+)-(%d+)")
		return string.format("%s/%s/%s", day, month, year)
	end)
	if success and result then
		return result
	else
		return "غير معروف"
	end
end

local function UpdateUI(target)
	if target then
		SelectedPlayer = target
		NameLbl.Text = "User: " .. target.Name
		DisplayNameLbl.Text = "Username: " .. target.DisplayName
		IdLbl.Text = "ID: " .. tostring(target.UserId)
		AvatarImg.Image = Players:GetUserThumbnailAsync(target.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
		
		task.spawn(function()
			local dateStr = GetJoinDate(target.UserId)
			JoinedLbl.Text = "Joined: " .. dateStr
		end)
	else
		SelectedPlayer = nil
		NameLbl.Text = "User: "
		DisplayNameLbl.Text = "Username: "
		IdLbl.Text = "ID: "
		JoinedLbl.Text = "Joined: "
		AvatarImg.Image = "rbxassetid://0"
	end
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local found = GetPlayerByShortcut(SearchBox.Text)
	UpdateUI(found)
end)

local function GetSignalAndPrefix()
	local prefix = ";"
	pcall(function()
		local custom = LocalPlayer.PlayerGui.HDAdminInterface.MainFrame.Pages.Settings.Custom["AE1 Prefix"].SettingValue.TextBox.Text
		if custom and custom ~= "" then
			prefix = custom
		end
	end)

	local hdClient = ReplicatedStorage:FindFirstChild("HDAdminHDClient") or ReplicatedStorage:WaitForChild("HDAdminHDClient", 1)
	local signals = hdClient and (hdClient:FindFirstChild("Signals") or hdClient:WaitForChild("Signals", 1))
	local signal = signals and (signals:FindFirstChild("RequestCommandSilent") or signals:WaitForChild("RequestCommandSilent", 1))

	return signal, prefix
end

ActionBtn.MouseButton1Click:Connect(function()
	TrollingActive = not TrollingActive
	
	if TrollingActive then
		ActionBtn.Text = "تخريب اللاعب 😂"
		ActionBtn.BackgroundColor3 = Color3.fromRGB(35, 200, 90)
		
		task.spawn(function()
			while TrollingActive do
				if SelectedPlayer then
					local targetName = SelectedPlayer.Name
					local signal, prefix = GetSignalAndPrefix()
					
					if signal then
						local commands = {
							prefix .. "r15 " .. targetName,
							prefix .. "wormify " .. targetName,
							prefix .. "dog " .. targetName,
							prefix .. "aura " .. targetName,
							prefix .. "shine " .. targetName,
							prefix .. "color " .. targetName .. " p",
							prefix .. "fat " .. targetName,
							prefix .. "thin " .. targetName,
							prefix .. "size " .. targetName .. " 5",
							prefix .. "height " .. targetName .. " 5",
							prefix .. "sit " .. targetName
              prefix .. "titlepk " ..targetName .. "آه بشويش ي بوبوووو"
						}
						
						for i = 1, 5 do
							if not TrollingActive or not SelectedPlayer then break end
							for _, cmd in ipairs(commands) do
								task.spawn(function()
									signal:InvokeServer(cmd)
								end)
							end
						end
					end
				end
				task.wait()
			end
		end)
	else
		ActionBtn.Text = "تخريب اللاعب 😂"
		ActionBtn.BackgroundColor3 = Color3.fromRGB(235, 35, 75)
	end
end)

FreezeBtn.MouseButton1Click:Connect(function()
	FreezingActive = not FreezingActive
	
	if FreezingActive then
		FreezeBtn.Text = "re ما يمديه يتحرك"
		FreezeBtn.BackgroundColor3 = Color3.fromRGB(35, 200, 90)
		
		task.spawn(function()
			while FreezingActive do
				if SelectedPlayer then
					local targetName = SelectedPlayer.Name
					local signal, prefix = GetSignalAndPrefix()
					
					if signal then
						local cmd = prefix .. "re " .. targetName
						
						for i = 1, 5 do
							if not FreezingActive or not SelectedPlayer then break end
							task.spawn(function()
								signal:InvokeServer(cmd)
							end)
						end
					end
				end
				task.wait()
			end
		end)
	else
		FreezeBtn.Text = "🚫 ما يمديه يتحرك"
		FreezeBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
	end
end)
