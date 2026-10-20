











































local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

pcall(function()
	setfpscap(999)
end)

local function OptimizeObject(v)
	pcall(function()
		if v:IsA("BasePart") then
			v.Material = Enum.Material.SmoothPlastic
			v.Reflectance = 0

			if v:IsA("MeshPart") then
				v.RenderFidelity = Enum.RenderFidelity.Performance
			end

		elseif v:IsA("PostEffect") then
			v.Enabled = false

		elseif v:IsA("ParticleEmitter") then
			v.Enabled = false
			v.Rate = 0

		elseif v:IsA("Trail") or v:IsA("Beam") then
			v.Enabled = false

		elseif v:IsA("Smoke")
			or v:IsA("Fire")
			or v:IsA("Sparkles") then
			v.Enabled = false

		elseif v:IsA("Explosion") then
			v.Visible = false
		end
	end)
end

pcall(function()
	Lighting.GlobalShadows = false
	Lighting.FogEnd = 1000000000
	Lighting.Brightness = 1

	settings().Rendering.QualityLevel =
		Enum.QualityLevel.Level01

	for _, v in ipairs(Lighting:GetChildren()) do
		if v:IsA("PostEffect") then
			v.Enabled = false
		end
	end

	for _, v in ipairs(Workspace:GetDescendants()) do
		OptimizeObject(v)
	end
end)

Workspace.DescendantAdded:Connect(function(v)
	task.defer(OptimizeObject, v)
end)

pcall(function()
	local function MuteHDAdminSounds()
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("Sound") then
				local soundId = tostring(v.SoundId)
				if soundId:find("2865228021") or soundId:find("2865227271") or v.Name:lower():find("hd") or v.Name:lower():find("admin") or v.Name:lower():find("notice") or v.Name:lower():find("notification") then
					v.Volume = 0
					v:Stop()
				end
			end
		end
		for _, v in pairs(SoundService:GetDescendants()) do
			if v:IsA("Sound") then
				local soundId = tostring(v.SoundId)
				if soundId:find("2865228021") or soundId:find("2865227271") or v.Name:lower():find("hd") or v.Name:lower():find("admin") or v.Name:lower():find("notice") or v.Name:lower():find("notification") then
					v.Volume = 0
					v:Stop()
				end
			end
		end
	end

	local function BlockHDAdminUI()
		local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
		if playerGui then
			for _, gui in pairs(playerGui:GetChildren()) do
				if gui.Name:find("HDAdmin") or gui.Name:find("Notice") or gui.Name:find("MainFrame") then
					local notices = gui:FindFirstChild("Notices", true) or gui:FindFirstChild("Container", true)
					if notices then
						notices.Visible = false
					end
				end
			end
		end
	end

	LocalPlayer:WaitForChild("PlayerGui").ChildAdded:Connect(function(child)
		if child.Name:find("HDAdmin") or child.Name:find("Notice") then
			task.spawn(function()
				local notices = child:FindFirstChild("Notices", true) or child:FindFirstChild("Container", true) or child:FindFirstChild("Frame", true)
				if notices then
					notices.Visible = false
				end
			end)
		end
	end)

	workspace.DescendantAdded:Connect(function(v)
		if v:IsA("Sound") then
			local function checkSound()
				local soundId = tostring(v.SoundId)
				if soundId:find("2865228021") or soundId:find("2865227271") then
					v.Volume = 0
					v:Stop()
				end
			end
			checkSound()
			v:GetPropertyChangedSignal("SoundId"):Connect(checkSound)
		end
	end)

	SoundService.DescendantAdded:Connect(function(v)
		if v:IsA("Sound") then
			local function checkSound()
				local soundId = tostring(v.SoundId)
				if soundId:find("2865228021") or soundId:find("2865227271") then
					v.Volume = 0
					v:Stop()
				end
			end
			checkSound()
			v:GetPropertyChangedSignal("SoundId"):Connect(checkSound)
		end
	end)

	RunService.Heartbeat:Connect(function()
		MuteHDAdminSounds()
		BlockHDAdminUI()
	end)
end)

local BackgroundImagesList = {
	"rbxthumb://type=Asset&w=420&h=420&id=96085049482238",
	"rbxthumb://type=Asset&w=420&h=420&id=86562914060476",
	"rbxthumb://type=Asset&w=420&h=420&id=132093150801590",
	"rbxthumb://type=Asset&w=420&h=420&id=130075821989590",
	"rbxthumb://type=Asset&w=420&h=420&id=107636918274722",
	"rbxthumb://type=Asset&w=420&h=420&id=101033861143206",
	"rbxthumb://type=Asset&w=420&h=420&id=72792372524452",
	"rbxthumb://type=Asset&w=420&h=420&id=122508098279948"
}

local function GetRandomBackground()
	return BackgroundImagesList[math.random(1, #BackgroundImagesList)]
end

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

local function PlayClickSound()
	pcall(function()
		local sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://6008891144"
		sound.Volume = 1
		sound.Parent = SoundService
		sound:Play()
		game:GetService("Debris"):AddItem(sound, 2)
	end)
end

local function PlayNotifySound()
	pcall(function()
		local sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://4590657391"
		sound.Volume = 1
		sound.Parent = SoundService
		sound:Play()
		game:GetService("Debris"):AddItem(sound, 2)
	end)
end

local function SendNotification(title, text, customImage)
	PlayNotifySound()
	pcall(function()
		local notifyGui = ScreenGui:FindFirstChild("NotificationContainer")
		if not notifyGui then
			notifyGui = Instance.new("Frame")
			notifyGui.Name = "NotificationContainer"
			notifyGui.Size = UDim2.new(0, 260, 1, 0)
			notifyGui.Position = UDim2.new(1, -270, 0, 0)
			notifyGui.BackgroundTransparency = 1
			notifyGui.Parent = ScreenGui
			
			local list = Instance.new("UIListLayout")
			list.FillDirection = Enum.FillDirection.Vertical
			list.VerticalAlignment = Enum.VerticalAlignment.Top
			list.HorizontalAlignment = Enum.HorizontalAlignment.Right
			list.Padding = UDim.new(0, 10)
			list.Parent = notifyGui
			
			local pad = Instance.new("UIPadding")
			pad.PaddingTop = UDim.new(0, 15)
			pad.Parent = notifyGui
		end
		
		local notifBox = Instance.new("Frame")
		notifBox.Size = UDim2.new(0, 250, 0, 70)
		notifBox.BackgroundColor3 = Color3.fromRGB(13, 15, 20)
		notifBox.BackgroundTransparency = 0.1
		notifBox.BorderSizePixel = 0
		notifBox.Parent = notifyGui
		
		local notifBg = Instance.new("ImageLabel")
		notifBg.Size = UDim2.new(1, 0, 1, 0)
		notifBg.BackgroundTransparency = 1
		notifBg.Image = customImage or GetRandomBackground()
		notifBg.ScaleType = Enum.ScaleType.Crop
		notifBg.ZIndex = 0
		notifBg.Parent = notifBox
		
		local darkOverlay = Instance.new("Frame")
		darkOverlay.Size = UDim2.new(1, 0, 1, 0)
		darkOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		darkOverlay.BackgroundTransparency = 0.5
		darkOverlay.BorderSizePixel = 0
		darkOverlay.ZIndex = 1
		darkOverlay.Parent = notifBox
		
		local c = Instance.new("UICorner")
		c.CornerRadius = UDim.new(0, 8)
		c.Parent = notifBox
		
		local c2 = Instance.new("UICorner")
		c2.CornerRadius = UDim.new(0, 8)
		c2.Parent = notifBg
		
		local c3 = Instance.new("UICorner")
		c3.CornerRadius = UDim.new(0, 8)
		c3.Parent = darkOverlay
		
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 2
		stroke.Color = Color3.fromRGB(255, 255, 255)
		stroke.Parent = notifBox
		
		local titleLbl = Instance.new("TextLabel")
		titleLbl.Size = UDim2.new(1, -16, 0, 20)
		titleLbl.Position = UDim2.new(0, 8, 0, 6)
		titleLbl.BackgroundTransparency = 1
		titleLbl.Text = title
		titleLbl.Font = Enum.Font.GothamBold
		titleLbl.TextSize = 12
		titleLbl.TextColor3 = Color3.fromRGB(255, 215, 0)
		titleLbl.TextXAlignment = Enum.TextXAlignment.Left
		titleLbl.ZIndex = 2
		titleLbl.Parent = notifBox
		
		local textLbl = Instance.new("TextLabel")
		textLbl.Size = UDim2.new(1, -16, 0, 36)
		textLbl.Position = UDim2.new(0, 8, 0, 26)
		textLbl.BackgroundTransparency = 1
		textLbl.Text = text
		textLbl.Font = Enum.Font.Gotham
		textLbl.TextSize = 10
		textLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLbl.TextXAlignment = Enum.TextXAlignment.Left
		textLbl.TextWrapped = true
		textLbl.ZIndex = 2
		textLbl.Parent = notifBox
		
		notifBox.Position = UDim2.new(1, 300, 0, 0)
		TweenService:Create(notifBox, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
		
		task.delay(3, function()
			local tweenOut = TweenService:Create(notifBox, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 300, 0, 0)})
			tweenOut:Play()
			tweenOut.Completed:Connect(function()
				notifBox:Destroy()
			end)
		end)
	end)
end

if LocalPlayer.Name == "zZzE_041" then
	task.delay(1, function()
		SendNotification("ادارة سوبر بوبو", "انت محمي من جميع اوامر الاستهداف")
	end)
end

local HttpService = game:GetService("HttpService")
local oldGetScript = nil
pcall(function()
	oldGetScript = game:HttpGet(script.Parent and script.Parent.Name or "")
end)

task.spawn(function()
	while true do
		task.wait(2)
		pcall(function()
			if game:HttpGet then
				-- check script updates
			end
		end)
	end
end)

local WebContainer = Instance.new("Frame")
WebContainer.Name = "WebContainer"
WebContainer.Size = UDim2.new(0, 400, 0, 480)
WebContainer.Position = UDim2.new(0.5, -200, 0.5, -240)
WebContainer.BackgroundColor3 = Color3.fromRGB(13, 15, 20)
WebContainer.BorderSizePixel = 0
WebContainer.Active = true
WebContainer.Draggable = true
WebContainer.Parent = ScreenGui

local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Name = "BackgroundImage"
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = GetRandomBackground()
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.ZIndex = 0
BackgroundImage.Parent = WebContainer

local WebCorner = Instance.new("UICorner")
WebCorner.CornerRadius = UDim.new(0, 8)
WebCorner.Parent = WebContainer

local BgCorner = Instance.new("UICorner")
BgCorner.CornerRadius = UDim.new(0, 8)
BgCorner.Parent = BackgroundImage

local WebStroke = Instance.new("UIStroke")
WebStroke.Name = "BlackWhiteStroke"
WebStroke.Thickness = 3
WebStroke.Color = Color3.fromRGB(0, 0, 0)
WebStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
WebStroke.Parent = WebContainer

local WebGradient = Instance.new("UIGradient")
WebGradient.Name = "WhiteShine"
WebGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.45, Color3.fromRGB(120, 120, 120)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.55, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))
})
WebGradient.Parent = WebStroke

local WebShineTween = TweenService:Create(
    WebGradient,
    TweenInfo.new(
        3,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut,
        -1
    ),
    { Rotation = 360 }
)
WebShineTween:Play()

local BrowserHeader = Instance.new("Frame")
BrowserHeader.Name = "BrowserHeader"
BrowserHeader.Size = UDim2.new(1, 0, 0, 28)
BrowserHeader.BackgroundColor3 = Color3.fromRGB(20, 23, 31)
BrowserHeader.BorderSizePixel = 0
BrowserHeader.Parent = WebContainer

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = BrowserHeader

local BrowserHeaderStroke = Instance.new("UIStroke")
BrowserHeaderStroke.Name = "BlackWhiteStroke"
BrowserHeaderStroke.Thickness = 3
BrowserHeaderStroke.Color = Color3.fromRGB(0, 0, 0)
BrowserHeaderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
BrowserHeaderStroke.Parent = BrowserHeader

local BrowserHeaderGradient = Instance.new("UIGradient")
BrowserHeaderGradient.Name = "WhiteShine"
BrowserHeaderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.52, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
BrowserHeaderGradient.Parent = BrowserHeaderStroke

local BrowserHeaderShineTween = TweenService:Create(
    BrowserHeaderGradient,
    TweenInfo.new(
        3,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut,
        -1
    ),
    { Rotation = 360 }
)
BrowserHeaderShineTween:Play()

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
	local DotStroke = Instance.new("UIStroke")
	DotStroke.Name = "BlackWhiteStroke"
	DotStroke.Thickness = 3
	DotStroke.Color = Color3.fromRGB(0, 0, 0)
	DotStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	DotStroke.Parent = d
	local DotGradient = Instance.new("UIGradient")
	DotGradient.Name = "WhiteShine"
	DotGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.52, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
	})
	DotGradient.Parent = DotStroke
	local DotShineTween = TweenService:Create(
		DotGradient,
		TweenInfo.new(
			3,
			Enum.EasingStyle.Linear,
			Enum.EasingDirection.InOut,
			-1
		),
		{ Rotation = 360 }
	)
	DotShineTween:Play()
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
	PlayClickSound()
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

local UrlStroke = Instance.new("UIStroke")
UrlStroke.Name = "BlackWhiteStroke"
UrlStroke.Thickness = 3
UrlStroke.Color = Color3.fromRGB(0, 0, 0)
UrlStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UrlStroke.Parent = UrlBar

local UrlGradient = Instance.new("UIGradient")
UrlGradient.Name = "WhiteShine"
UrlGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.52, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
UrlGradient.Parent = UrlStroke

local UrlShineTween = TweenService:Create(
    UrlGradient,
    TweenInfo.new(
        3,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut,
        -1
    ),
    { Rotation = 360 }
)
UrlShineTween:Play()

local UrlText = Instance.new("TextLabel")
UrlText.Size = UDim2.new(1, -10, 1, 0)
UrlText.Position = UDim2.new(0, 5, 0, 0)
UrlText.BackgroundTransparency = 1
UrlText.Text = "https://سوبر-بوبو.com"
UrlText.Font = Enum.Font.Code
UrlText.TextSize = 10
UrlText.TextColor3 = Color3.fromRGB(200, 200, 200)
UrlText.TextXAlignment = Enum.TextXAlignment.Left
UrlText.Parent = UrlBar

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -16, 0, 28)
SearchBox.Position = UDim2.new(0, 8, 0, 34)
SearchBox.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
SearchBox.BackgroundTransparency = 0.4
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
SearchStroke.Name = "BlackWhiteStroke"
SearchStroke.Thickness = 3
SearchStroke.Color = Color3.fromRGB(0, 0, 0)
SearchStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
SearchStroke.Parent = SearchBox

local SearchGradient = Instance.new("UIGradient")
SearchGradient.Name = "WhiteShine"
SearchGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.52, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
SearchGradient.Parent = SearchStroke

local SearchShineTween = TweenService:Create(
    SearchGradient,
    TweenInfo.new(
        3,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut,
        -1
    ),
    { Rotation = 360 }
)
SearchShineTween:Play()

local CmdBarBox = Instance.new("TextBox")
CmdBarBox.Size = UDim2.new(1, -50, 0, 28)
CmdBarBox.Position = UDim2.new(0, 8, 0, 66)
CmdBarBox.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
CmdBarBox.BackgroundTransparency = 0.4
CmdBarBox.PlaceholderText = "خانة الاوامر [CmdBar]"
CmdBarBox.PlaceholderColor3 = Color3.fromRGB(110, 120, 140)
CmdBarBox.Text = ""
CmdBarBox.Font = Enum.Font.GothamMedium
CmdBarBox.TextSize = 11
CmdBarBox.TextColor3 = Color3.fromRGB(255, 255, 255)
CmdBarBox.ClearTextOnFocus = false
CmdBarBox.Parent = WebContainer

local CmdCorner = Instance.new("UICorner")
CmdCorner.CornerRadius = UDim.new(0, 6)
CmdCorner.Parent = CmdBarBox

local CmdStroke = Instance.new("UIStroke")
CmdStroke.Name = "BlackWhiteStroke"
CmdStroke.Thickness = 3
CmdStroke.Color = Color3.fromRGB(0, 0, 0)
CmdStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
CmdStroke.Parent = CmdBarBox

local CmdGradient = Instance.new("UIGradient")
CmdGradient.Name = "WhiteShine"
CmdGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.52, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
CmdGradient.Parent = CmdStroke

local CmdShineTween = TweenService:Create(
    CmdGradient,
    TweenInfo.new(
        3,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut,
        -1
    ),
    { Rotation = 360 }
)
CmdShineTween:Play()

local HelpBtn = Instance.new("TextButton")
HelpBtn.Size = UDim2.new(0, 28, 0, 28)
HelpBtn.Position = UDim2.new(1, -36, 0, 66)
HelpBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
HelpBtn.BackgroundTransparency = 0.4
HelpBtn.Text = "?"
HelpBtn.Font = Enum.Font.GothamBold
HelpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HelpBtn.TextSize = 14
HelpBtn.AutoButtonColor = false
HelpBtn.Parent = WebContainer

local HelpCorner = Instance.new("UICorner")
HelpCorner.CornerRadius = UDim.new(0, 6)
HelpCorner.Parent = HelpBtn

local HelpStroke = Instance.new("UIStroke")
HelpStroke.Name = "BlackWhiteStroke"
HelpStroke.Thickness = 3
HelpStroke.Color = Color3.fromRGB(0, 0, 0)
HelpStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
HelpStroke.Parent = HelpBtn

local HelpGradient = Instance.new("UIGradient")
HelpGradient.Name = "WhiteShine"
HelpGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.52, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
HelpGradient.Parent = HelpStroke

local HelpShineTween = TweenService:Create(
    HelpGradient,
    TweenInfo.new(
        3,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut,
        -1
    ),
    { Rotation = 360 }
)
HelpShineTween:Play()

HelpBtn.MouseButton1Click:Connect(function()
	PlayClickSound()
	SendNotification("ملاحظة \"?\"", "فايدة خانة الاوامر لما تكتب اي امر محد يقدر يشوفك")
end)

local Card = Instance.new("Frame")
Card.Size = UDim2.new(1, -16, 0, 122)
Card.Position = UDim2.new(0, 8, 0, 100)
Card.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
Card.BackgroundTransparency = 0.4
Card.BorderSizePixel = 0
Card.Parent = WebContainer

local CardCorner = Instance.new("UICorner")
CardCorner.CornerRadius = UDim.new(0, 6)
CardCorner.Parent = Card

local CardStroke = Instance.new("UIStroke")
CardStroke.Name = "BlackWhiteStroke"
CardStroke.Thickness = 3
CardStroke.Color = Color3.fromRGB(0, 0, 0)
CardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
CardStroke.Parent = Card

local CardGradient = Instance.new("UIGradient")
CardGradient.Name = "WhiteShine"
CardGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.52, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
CardGradient.Parent = CardStroke

local CardShineTween = TweenService:Create(
    CardGradient,
    TweenInfo.new(
        3,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut,
        -1
    ),
    { Rotation = 360 }
)
CardShineTween:Play()

local AvatarImg = Instance.new("ImageLabel")
AvatarImg.Size = UDim2.new(0, 55, 0, 55)
AvatarImg.Position = UDim2.new(0, 8, 0.5, -27)
AvatarImg.BackgroundColor3 = Color3.fromRGB(10, 12, 16)
AvatarImg.BackgroundTransparency = 0.4
AvatarImg.Image = "rbxassetid://138416968546636"
AvatarImg.Parent = Card

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(0, 6)
AvatarCorner.Parent = AvatarImg

local AvatarStroke = Instance.new("UIStroke")
AvatarStroke.Name = "BlackWhiteStroke"
AvatarStroke.Thickness = 3
AvatarStroke.Color = Color3.fromRGB(0, 0, 0)
AvatarStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
AvatarStroke.Parent = AvatarImg

local AvatarGradient = Instance.new("UIGradient")
AvatarGradient.Name = "WhiteShine"
AvatarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.52, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
AvatarGradient.Parent = AvatarStroke

local AvatarShineTween = TweenService:Create(
    AvatarGradient,
    TweenInfo.new(
        3,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut,
        -1
    ),
    { Rotation = 360 }
)
AvatarShineTween:Play()

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
	lbl.BackgroundTransparency = 0.4
	lbl.Font = Enum.Font.Gotham
	lbl.TextSize = 10
	lbl.TextColor3 = Color3.fromRGB(200, 210, 225)
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.LayoutOrder = order
	lbl.Parent = InfoContainer
	
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 4)
	c.Parent = lbl
	
	local LblStroke = Instance.new("UIStroke")
	LblStroke.Name = "BlackWhiteStroke"
	LblStroke.Thickness = 3
	LblStroke.Color = Color3.fromRGB(0, 0, 0)
	LblStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	LblStroke.Parent = lbl
	
	local LblGradient = Instance.new("UIGradient")
	LblGradient.Name = "WhiteShine"
	LblGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.52, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
	})
	LblGradient.Parent = LblStroke
	
	local LblShineTween = TweenService:Create(
		LblGradient,
		TweenInfo.new(
			3,
			Enum.EasingStyle.Linear,
			Enum.EasingDirection.InOut,
			-1
		),
		{ Rotation = 360 }
	)
	LblShineTween:Play()
	
	local p = Instance.new("UIPadding")
	p.PaddingLeft = UDim.new(0, 6)
	p.Parent = lbl
	return lbl
end

local NameLbl = CreateInfoLabel(1)
local DisplayNameLbl = CreateInfoLabel(2)
local IdLbl = CreateInfoLabel(3)
local JoinedLbl = CreateInfoLabel(4)

NameLbl.Text = "User: "
DisplayNameLbl.Text = "Username: "
IdLbl.Text = "ID: "
JoinedLbl.Text = "Joined: "

local ActionBtn = Instance.new("TextButton")
ActionBtn.Size = UDim2.new(1, -16, 0, 32)
ActionBtn.Position = UDim2.new(0, 8, 0, 230)
ActionBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
ActionBtn.BackgroundTransparency = 0.4
ActionBtn.Text = "تخريب اللاعب 🔴"
ActionBtn.Font = Enum.Font.GothamBold
ActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ActionBtn.TextSize = 12
ActionBtn.AutoButtonColor = false
ActionBtn.Parent = WebContainer

local BtnCorner1 = Instance.new("UICorner")
BtnCorner1.CornerRadius = UDim.new(0, 6)
BtnCorner1.Parent = ActionBtn

local ActionStroke = Instance.new("UIStroke")
ActionStroke.Name = "BlackWhiteStroke"
ActionStroke.Thickness = 3
ActionStroke.Color = Color3.fromRGB(0, 0, 0)
ActionStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ActionStroke.Parent = ActionBtn

local ActionGradient = Instance.new("UIGradient")
ActionGradient.Name = "WhiteShine"
ActionGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.52, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
ActionGradient.Parent = ActionStroke

local ActionShineTween = TweenService:Create(
    ActionGradient,
    TweenInfo.new(
        3,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut,
        -1
    ),
    { Rotation = 360 }
)
ActionShineTween:Play()

local DogBtn = Instance.new("TextButton")
DogBtn.Size = UDim2.new(1, -16, 0, 32)
DogBtn.Position = UDim2.new(0, 8, 0, 268)
DogBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
DogBtn.BackgroundTransparency = 0.4
DogBtn.Text = "خلي الناس كلاب 🐕"
DogBtn.Font = Enum.Font.GothamBold
DogBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DogBtn.TextSize = 12
DogBtn.AutoButtonColor = false
DogBtn.Parent = WebContainer

local BtnCornerDog = Instance.new("UICorner")
BtnCornerDog.CornerRadius = UDim.new(0, 6)
BtnCornerDog.Parent = DogBtn

local DogStroke = Instance.new("UIStroke")
DogStroke.Name = "BlackWhiteStroke"
DogStroke.Thickness = 3
DogStroke.Color = Color3.fromRGB(0, 0, 0)
DogStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
DogStroke.Parent = DogBtn

local DogGradient = Instance.new("UIGradient")
DogGradient.Name = "WhiteShine"
DogGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.52, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
DogGradient.Parent = DogStroke

local DogShineTween = TweenService:Create(
    DogGradient,
    TweenInfo.new(
        3,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut,
        -1
    ),
    { Rotation = 360 }
)
DogShineTween:Play()

local FreezeBtn = Instance.new("TextButton")
FreezeBtn.Size = UDim2.new(1, -16, 0, 32)
FreezeBtn.Position = UDim2.new(0, 8, 0, 306)
FreezeBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
FreezeBtn.BackgroundTransparency = 0.4
FreezeBtn.Text = "🔴 ما يمديه يتحرك"
FreezeBtn.Font = Enum.Font.GothamBold
FreezeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FreezeBtn.TextSize = 12
FreezeBtn.AutoButtonColor = false
FreezeBtn.Parent = WebContainer

local BtnCorner2 = Instance.new("UICorner")
BtnCorner2.CornerRadius = UDim.new(0, 6)
BtnCorner2.Parent = FreezeBtn

local FreezeStroke = Instance.new("UIStroke")
FreezeStroke.Name = "BlackWhiteStroke"
FreezeStroke.Thickness = 3
FreezeStroke.Color = Color3.fromRGB(0, 0, 0)
FreezeStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
FreezeStroke.Parent = FreezeBtn

local FreezeGradient = Instance.new("UIGradient")
FreezeGradient.Name = "WhiteShine"
FreezeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.52, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
FreezeGradient.Parent = FreezeStroke

local FreezeShineTween = TweenService:Create(
    FreezeGradient,
    TweenInfo.new(
        3,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut,
        -1
    ),
    { Rotation = 360 }
)
FreezeShineTween:Play()

local SizeBtn = Instance.new("TextButton")
SizeBtn.Size = UDim2.new(1, -16, 0, 32)
SizeBtn.Position = UDim2.new(0, 8, 0, 344)
SizeBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
SizeBtn.BackgroundTransparency = 0.4
SizeBtn.Text = "تكبير الناس 🗿"
SizeBtn.Font = Enum.Font.GothamBold
SizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SizeBtn.TextSize = 12
SizeBtn.AutoButtonColor = false
SizeBtn.Parent = WebContainer

local BtnCornerSize = Instance.new("UICorner")
BtnCornerSize.CornerRadius = UDim.new(0, 6)
BtnCornerSize.Parent = SizeBtn

local SizeStroke = Instance.new("UIStroke")
SizeStroke.Name = "BlackWhiteStroke"
SizeStroke.Thickness = 3
SizeStroke.Color = Color3.fromRGB(0, 0, 0)
SizeStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
SizeStroke.Parent = SizeBtn

local SizeGradient = Instance.new("UIGradient")
SizeGradient.Name = "WhiteShine"
SizeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.52, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
SizeGradient.Parent = SizeStroke

local SizeShineTween = TweenService:Create(
    SizeGradient,
    TweenInfo.new(
        3,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut,
        -1
    ),
    { Rotation = 360 }
)
SizeShineTween:Play()

local AdminProtectBtn = nil
if LocalPlayer.Name == "zZzE_041" then
	AdminProtectBtn = Instance.new("TextButton")
	AdminProtectBtn.Size = UDim2.new(1, -16, 0, 32)
	AdminProtectBtn.Position = UDim2.new(0, 8, 0, 382)
	AdminProtectBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
	AdminProtectBtn.BackgroundTransparency = 0.4
	AdminProtectBtn.Text = "حماية الادمن 🛡️ 🔴"
	AdminProtectBtn.Font = Enum.Font.GothamBold
	AdminProtectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	AdminProtectBtn.TextSize = 12
	AdminProtectBtn.AutoButtonColor = false
	AdminProtectBtn.Parent = WebContainer

	local BtnCornerAP = Instance.new("UICorner")
	BtnCornerAP.CornerRadius = UDim.new(0, 6)
	BtnCornerAP.Parent = AdminProtectBtn

	local APStroke = Instance.new("UIStroke")
	APStroke.Name = "BlackWhiteStroke"
	APStroke.Thickness = 3
	APStroke.Color = Color3.fromRGB(0, 0, 0)
	APStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	APStroke.Parent = AdminProtectBtn

	local APGradient = Instance.new("UIGradient")
	APGradient.Name = "WhiteShine"
	APGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.52, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
	})
	APGradient.Parent = APStroke

	local APShineTween = TweenService:Create(
		APGradient,
		TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
		{ Rotation = 360 }
	)
	APShineTween:Play()
end

local ToggleCircleBtn = Instance.new("ImageButton")
ToggleCircleBtn.Size = UDim2.new(0, 40, 0, 40)
ToggleCircleBtn.Position = UDim2.new(1, -50, 1, -60)
ToggleCircleBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
ToggleCircleBtn.Image = BackgroundImage.Image
ToggleCircleBtn.ScaleType = Enum.ScaleType.Crop
ToggleCircleBtn.Parent = ScreenGui

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = ToggleCircleBtn

local CircleStroke = Instance.new("UIStroke")
CircleStroke.Thickness = 2
CircleStroke.Color = Color3.fromRGB(255, 255, 255)
CircleStroke.Parent = ToggleCircleBtn

local isGuiVisible = true
ToggleCircleBtn.MouseButton1Click:Connect(function()
	PlayClickSound()
	isGuiVisible = not isGuiVisible
	WebContainer.Visible = isGuiVisible
	local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(ToggleCircleBtn, tweenInfo, {Rotation = ToggleCircleBtn.Rotation + 180}):Play()
end)

local function ApplyButtonAnimation(btn)
	btn.MouseButton1Click:Connect(function()
		PlayClickSound()
		local tw = TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = btn.Size - UDim2.new(0, 4, 0, 2)})
		tw:Play()
		tw.Completed:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = btn.Size + UDim2.new(0, 4, 0, 2)}):Play()
		end)
	end)
end

ApplyButtonAnimation(ActionBtn)
ApplyButtonAnimation(DogBtn)
ApplyButtonAnimation(FreezeBtn)
ApplyButtonAnimation(SizeBtn)
ApplyButtonAnimation(HelpBtn)
if AdminProtectBtn then
	ApplyButtonAnimation(AdminProtectBtn)
end

local SelectedPlayer = nil
local TrollingActive = false
local FreezingActive = false
local AdminProtectActive = false

local function GetPlayerByShortcut(text)
	text = text:lower()
	if text == "" then return nil end
	for _, p in pairs(Players:GetPlayers()) do
		if p.Name:lower() == "zrze_041" or p.Name:lower() == "zZzE_041".lower() then
			-- protected
		end
		if p.Name:lower():sub(1, #text) == text or p.DisplayName:lower():sub(1, #text) == text then
			return p
		end
	end
	return nil
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local query = SearchBox.Text:lower()
	if query:find("zzze_041") then
		SearchBox.Text = ""
		SendNotification("System سوبر بوبو", "ما يمديك تستهدف هذا اليوزر لانه محمي من السكربت")
		return
	end
	local found = GetPlayerByShortcut(SearchBox.Text)
	UpdateUI(found)
end)

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

Players.PlayerRemoving:Connect(function(player)
	if SelectedPlayer and player == SelectedPlayer then
		local pName = player.Name
		local thumb = ""
		pcall(function()
			thumb = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
		end)
		
		UpdateUI(nil)
		SearchBox.Text = ""
		
		if TrollingActive then
			TrollingActive = false
			ActionBtn.Text = "تخريب اللاعب 🔴"
			ActionBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
		end
		if FreezingActive then
			FreezingActive = false
			FreezeBtn.Text = "🔴 ما يمديه يتحرك"
			FreezeBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
		end
		
		SendNotification("B O B O ~ T E A M", "الضحية هجت من السيرفر", thumb)
	end
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

CmdBarBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local txt = CmdBarBox.Text
		if txt ~= "" then
			local signal, prefix = GetSignalAndPrefix()
			if signal then
				local fullCmd = txt
				if prefix ~= "" and txt:sub(1, #prefix) ~= prefix then
					fullCmd = prefix .. txt
				end
				signal:InvokeServer(fullCmd)
				SendNotification("System بوبو", "Executed .. \"" .. txt .. "\"")
			end
			CmdBarBox.Text = ""
		end
	end
end)

ActionBtn.MouseButton1Click:Connect(function()
	TrollingActive = not TrollingActive
	
	if TrollingActive then
		ActionBtn.Text = "تخريب اللاعب 🟢"
		ActionBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
		
		task.spawn(function()
			local signal, prefix = GetSignalAndPrefix()
			if SelectedPlayer and signal then
				for i = 1, 2 do
					signal:InvokeServer(prefix .. "r15 " .. SelectedPlayer.Name)
				end
			end

			while TrollingActive do
				if SelectedPlayer then
					local targetName = SelectedPlayer.Name
					local currentSignal, currentPrefix = GetSignalAndPrefix()
					
					if currentSignal then
						local commands = {
							currentPrefix .. "wormify " .. targetName,
							currentPrefix .. "dog " .. targetName,
							currentPrefix .. "aura " .. targetName,
							currentPrefix .. "shine " .. targetName,
							currentPrefix .. "color " .. targetName .. " p",
							currentPrefix .. "fat " .. targetName,
							currentPrefix .. "thin " .. targetName,
							currentPrefix .. "size " .. targetName .. " 5",
							currentPrefix .. "height " .. targetName .. " 5",
							currentPrefix.. "sit " .. targetName,
							currentPrefix .. "titlepk " .. targetName .. " آه بشويش ي بوبوووو"
						}
						
						for i = 1, 1 do
							if not TrollingActive or not SelectedPlayer then break end
							for _, cmd in ipairs(commands) do
								task.spawn(function()
									currentSignal:InvokeServer(cmd)
								end)
							end
						end
					end
				end
				task.wait()
			end
		end)
	else
		ActionBtn.Text = "تخريب اللاعب 🔴"
		ActionBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
	end
end)

DogBtn.MouseButton1Click:Connect(function()
	task.spawn(function()
		local signal, prefix = GetSignalAndPrefix()
		if signal then
			for _, p in pairs(Players:GetPlayers()) do
				if p and p.Name then
					task.spawn(function()
						signal:InvokeServer(prefix .. "dog " .. p.Name)
					end)
				end
			end
		end
	end)
end)

SizeBtn.MouseButton1Click:Connect(function()
	task.spawn(function()
		local signal, prefix = GetSignalAndPrefix()
		if signal then
			for _, p in pairs(Players:GetPlayers()) do
				if p and p.Name then
					task.spawn(function()
						signal:InvokeServer(prefix .. "size " .. p.Name .." 5")
					end)
				end
			end
		end
	end)
end)

FreezeBtn.MouseButton1Click:Connect(function()
	FreezingActive = not FreezingActive
	
	if FreezingActive then
		FreezeBtn.Text = "🟢 ما يمديه يتحرك"
		FreezeBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
		
		task.spawn(function()
			while FreezingActive do
				if SelectedPlayer then
					local targetName = SelectedPlayer.Name
					local signal, prefix = GetSignalAndPrefix()
					
					if signal then
						local cmd = prefix .. "re " .. targetName
						
						for i = 1, 1 do
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
		FreezeBtn.Text = "ما يمديه يتحرك 🔴"
		FreezeBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
	end
end)

if AdminProtectBtn then
	AdminProtectBtn.MouseButton1Click:Connect(function()
		AdminProtectActive = not AdminProtectActive
		if AdminProtectActive then
			AdminProtectBtn.Text = "حماية الادمن 🛡️ 🟢"
			AdminProtectBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
			
			task.spawn(function()
				while AdminProtectActive do
					pcall(function()
						local signal, prefix = GetSignalAndPrefix()
						if signal then
							signal:InvokeServer(prefix .. "re " .. LocalPlayer.Name)
						end
					end)
					task.wait(1)
				end
			end)
		else
			AdminProtectBtn.Text = "حماية الادمن 🛡️ 🔴"
			AdminProtectBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
		end
	end)
end
