local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer

pcall(function()
	setfpscap(999)
end)

pcall(function()
	Lighting.GlobalShadows = false
	Lighting.FogEnd = 9e9
	settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
	for _, v in pairs(game:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Material = Enum.Material.SmoothPlastic
		elseif v:IsA("PostEffect") or v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
			v.Enabled = false
		end
	end
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

local bgImages = {
	"rbxassetid://96085049482238",
	"rbxassetid://86562914060476",
	"rbxassetid://132093150801590",
	"rbxassetid://130075821989590",
	"rbxassetid://107636918274722",
	"rbxassetid://101033861143206",
	"rbxassetid://72792372524452",
	"rbxassetid://122508098279948"
}
local chosenBg = bgImages[math.random(1, #bgImages)]

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

local NotificationContainer = Instance.new("Frame")
NotificationContainer.Name = "NotificationContainer"
NotificationContainer.Size = UDim2.new(0, 260, 1, 0)
NotificationContainer.Position = UDim2.new(1, -270, 0, 10)
NotificationContainer.BackgroundTransparency = 1
NotificationContainer.Parent = ScreenGui

local NotifList = Instance.new("UIListLayout")
NotifList.SortOrder = Enum.SortOrder.LayoutOrder
NotifList.Padding = UDim.new(0, 8)
NotifList.HorizontalAlignment = Enum.HorizontalAlignment.Right
NotifList.Parent = NotificationContainer

local function PlayClickSound()
	pcall(function()
		local sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://4590657391"
		sound.Volume = 1
		sound.Parent = SoundService
		sound:Play()
		game:GetService("Debris"):AddItem(sound, 2)
	end)
end

local function SendNotification(title, text, imageId)
	PlayClickSound()
	local notifFrame = Instance.new("Frame")
	notifFrame.Size = UDim2.new(1, 0, 0, 60)
	notifFrame.BackgroundColor3 = Color3.fromRGB(13, 15, 20)
	notifFrame.BorderSizePixel = 0
	notifFrame.Parent = NotificationContainer

	local notifBg = Instance.new("ImageLabel")
	notifBg.Size = UDim2.new(1, 0, 1, 0)
	notifBg.BackgroundTransparency = 1
	notifBg.Image = chosenBg
	notifBg.ScaleType = Enum.ScaleType.Crop
	notifBg.ZIndex = 0
	notifBg.Parent = notifFrame

	local notifCorner = Instance.new("UICorner")
	notifCorner.CornerRadius = UDim.new(0, 8)
	notifCorner.Parent = notifFrame

	local notifBgCorner = Instance.new("UICorner")
	notifBgCorner.CornerRadius = UDim.new(0, 8)
	notifBgCorner.Parent = notifBg

	local notifStroke = Instance.new("UIStroke")
	notifStroke.Thickness = 2
	notifStroke.Color = Color3.fromRGB(0, 0, 0)
	notifStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	notifStroke.Parent = notifFrame

	local notifGradient = Instance.new("UIGradient")
	notifGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
	})
	notifGradient.Parent = notifStroke

	TweenService:Create(notifGradient, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), { Rotation = 360 }):Play()

	local textOffset = 10
	if imageId then
		local img = Instance.new("ImageLabel")
		img.Size = UDim2.new(0, 44, 0, 44)
		img.Position = UDim2.new(0, 8, 0, 8)
		img.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
		img.BackgroundTransparency = 0.3
		img.Image = imageId
		img.Parent = notifFrame

		local imgCorner = Instance.new("UICorner")
		imgCorner.CornerRadius = UDim.new(0, 6)
		imgCorner.Parent = img

		textOffset = 60
	end

	local titleLbl = Instance.new("TextLabel")
	titleLbl.Size = UDim2.new(1, -textOffset - 8, 0, 20)
	titleLbl.Position = UDim2.new(0, textOffset, 0, 6)
	titleLbl.BackgroundTransparency = 1
	titleLbl.Font = Enum.Font.GothamBold
	titleLbl.TextSize = 12
	titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left
	titleLbl.Text = title
	titleLbl.Parent = notifFrame

	local textLbl = Instance.new("TextLabel")
	textLbl.Size = UDim2.new(1, -textOffset - 8, 0, 30)
	textLbl.Position = UDim2.new(0, textOffset, 0, 24)
	textLbl.BackgroundTransparency = 1
	textLbl.Font = Enum.Font.Gotham
	textLbl.TextSize = 10
	textLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
	textLbl.TextXAlignment = Enum.TextXAlignment.Left
	textLbl.TextWrapped = true
	textLbl.Text = text
	textLbl.Parent = notifFrame

	task.delay(4, function()
		if notifFrame and notifFrame.Parent then
			notifFrame:Destroy()
		end
	end)
end

local WebContainer = Instance.new("Frame")
WebContainer.Name = "WebContainer"
WebContainer.Size = UDim2.new(0, 400, 0, 440)
WebContainer.Position = UDim2.new(0.5, -200, 0.5, -220)
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
BackgroundImage.Image = chosenBg
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
	SendNotification("ملاحظة \"?\"", "فايدة خانة الاوامر لما تكتب اي امر محد يقدر تشوفك")
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

local function SetupButtonEffects(btn)
	local originalPos = btn.Position
	btn.MouseButton1Down:Connect(function()
		PlayClickSound()
		TweenService:Create(btn, TweenInfo.new(0.08), { Position = originalPos + UDim2.new(0, 0, 0, 2) }):Play()
	end)
	btn.MouseButton1Up:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.08), { Position = originalPos }):Play()
	end)
end

local ActionBtn = Instance.new("TextButton")
ActionBtn.Size = UDim2.new(1, -16, 0, 30)
ActionBtn.Position = UDim2.new(0, 8, 0, 230)
ActionBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
ActionBtn.BackgroundTransparency = 0.3
ActionBtn.Text = "تخريب اللاعب"
ActionBtn.Font = Enum.Font.GothamBold
ActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ActionBtn.TextSize = 12
ActionBtn.AutoButtonColor = false
ActionBtn.Parent = WebContainer
SetupButtonEffects(ActionBtn)

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
DogBtn.Size = UDim2.new(1, -16, 0, 30)
DogBtn.Position = UDim2.new(0, 8, 0, 265)
DogBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
DogBtn.BackgroundTransparency = 0.4
DogBtn.Text = "خلي الناس كلاب 🐕"
DogBtn.Font = Enum.Font.GothamBold
DogBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DogBtn.TextSize = 12
DogBtn.AutoButtonColor = false
DogBtn.Parent = WebContainer
SetupButtonEffects(DogBtn)

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
FreezeBtn.Size = UDim2.new(1, -16, 0, 30)
FreezeBtn.Position = UDim2.new(0, 8, 0, 300)
FreezeBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
FreezeBtn.BackgroundTransparency = 0.3
FreezeBtn.Text = "ما يمديه يتحرك"
FreezeBtn.Font = Enum.Font.GothamBold
FreezeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FreezeBtn.TextSize = 12
FreezeBtn.AutoButtonColor = false
FreezeBtn.Parent = WebContainer
SetupButtonEffects(FreezeBtn)

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
SizeBtn.Size = UDim2.new(1, -16, 0, 30)
SizeBtn.Position = UDim2.new(0, 8, 0, 335)
SizeBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
SizeBtn.BackgroundTransparency = 0.4
SizeBtn.Text = "تكبير الناس 🗿"
SizeBtn.Font = Enum.Font.GothamBold
SizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SizeBtn.TextSize = 12
SizeBtn.AutoButtonColor = false
SizeBtn.Parent = WebContainer
SetupButtonEffects(SizeBtn)

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

local PremiumList = {
	["zZzE_041"] = true
}

local AdminProtectionActive = false
local AdminProtectBtn = nil

if PremiumList[LocalPlayer.Name] then
	AdminProtectBtn = Instance.new("TextButton")
	AdminProtectBtn.Size = UDim2.new(1, -16, 0, 30)
	AdminProtectBtn.Position = UDim2.new(0, 8, 0, 370)
	AdminProtectBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
	AdminProtectBtn.BackgroundTransparency = 0.3
	AdminProtectBtn.Text = "حماية الادمن 🛡️"
	AdminProtectBtn.Font = Enum.Font.GothamBold
	AdminProtectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	AdminProtectBtn.TextSize = 12
	AdminProtectBtn.AutoButtonColor = false
	AdminProtectBtn.Parent = WebContainer
	SetupButtonEffects(AdminProtectBtn)

	local BtnCornerProt = Instance.new("UICorner")
	BtnCornerProt.CornerRadius = UDim.new(0, 6)
	BtnCornerProt.Parent = AdminProtectBtn

	local ProtStroke = Instance.new("UIStroke")
	ProtStroke.Name = "BlackWhiteStroke"
	ProtStroke.Thickness = 3
	ProtStroke.Color = Color3.fromRGB(0, 0, 0)
	ProtStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	ProtStroke.Parent = AdminProtectBtn

	local ProtGradient = Instance.new("UIGradient")
	ProtGradient.Name = "WhiteShine"
	ProtGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.52, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
	})
	ProtGradient.Parent = ProtStroke

	local ProtShineTween = TweenService:Create(
		ProtGradient,
		TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
		{ Rotation = 360 }
	)
	ProtShineTween:Play()

	AdminProtectBtn.MouseButton1Click:Connect(function()
		AdminProtectionActive = not AdminProtectionActive
		if AdminProtectionActive then
			AdminProtectBtn.BackgroundColor3 = Color3.fromRGB(30, 150, 30)
		else
			AdminProtectBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
		end
	end)
end

local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(1, -55, 0.5, -22)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.Image = chosenBg
ToggleBtn.ScaleType = Enum.ScaleType.Crop
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Thickness = 3
ToggleStroke.Color = Color3.fromRGB(0, 0, 0)
ToggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ToggleStroke.Parent = ToggleBtn

local ToggleGradient = Instance.new("UIGradient")
ToggleGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
ToggleGradient.Parent = ToggleStroke

TweenService:Create(ToggleGradient, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), { Rotation = 360 }):Play()

ToggleBtn.MouseButton1Click:Connect(function()
	PlayClickSound()
	WebContainer.Visible = not WebContainer.Visible
	TweenService:Create(ToggleBtn, TweenInfo.new(0.1), { Rotation = ToggleBtn.Rotation + 45 }):Play()
end)

local SelectedPlayer = nil
local TrollingActive = false
local FreezingActive = false

local function ResetTargetState()
	TrollingActive = false
	FreezingActive = false
	ActionBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
	FreezeBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
	
	SelectedPlayer = nil
	SearchBox.Text = ""
	NameLbl.Text = "User: "
	DisplayNameLbl.Text = "Username: "
	IdLbl.Text = "ID: "
	JoinedLbl.Text = "Joined: "
	AvatarImg.Image = "rbxassetid://0"
end

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
		if target.Name == "zZzE_041" and LocalPlayer.Name ~= "zZzE_041" then
			SearchBox.Text = ""
			SendNotification("System سوبر بوبو", "ما يمديك تستهدف هذا اليوزر لانه محمي من السكربت")
			ResetTargetState()
			return
		end

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
	if SearchBox.Text:lower():find("zzze_041") and LocalPlayer.Name ~= "zZzE_041" then
		SearchBox.Text = ""
		SendNotification("System سوبر بوبو", "ما يمديك تستهدف هذا اليوزر لانه محمي من السكربت")
		ResetTargetState()
		return
	end
	local found = GetPlayerByShortcut(SearchBox.Text)
	UpdateUI(found)
end)

Players.PlayerRemoving:Connect(function(p)
	if SelectedPlayer and p == SelectedPlayer then
		local thumb = Players:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
		ResetTargetState()
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
		ActionBtn.BackgroundColor3 = Color3.fromRGB(30, 150, 30)
		
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
		ActionBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
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
		FreezeBtn.BackgroundColor3 = Color3.fromRGB(30, 150, 30)
		
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
		FreezeBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
	end
end)

if LocalPlayer.Name == "zZzE_041" then
	SendNotification("ادارة سوبر بوبو", "انت محمي من جميع اوامر الاستهداف")
end

pcall(function()
	local hdClient = ReplicatedStorage:FindFirstChild("HDAdminHDClient") or ReplicatedStorage:WaitForChild("HDAdminHDClient", 1)
	local signals = hdClient and (hdClient:FindFirstChild("Signals") or hdClient:WaitForChild("Signals", 1))
	if signals then
		local function SetupAdminProtect(sig)
			if sig:IsA("RemoteEvent") then
				sig.OnClientEvent:Connect(function(...)
					if AdminProtectionActive then
						local args = {...}
						local cmdStr = tostring(args[1] or ""):lower()
						if cmdStr:find("mod") or cmdStr:find("vip") or cmdStr:find("admin") then
							local signal, prefix = GetSignalAndPrefix()
							if signal then
								for i = 1, 9990 do
									task.spawn(function()
										signal:InvokeServer(prefix .. "re " .. LocalPlayer.Name)
									end)
								end
							end
						end
					end
				end)
			end
		end
		for _, s in pairs(signals:GetChildren()) do
			SetupAdminProtect(s)
		end
		signals.ChildAdded:Connect(SetupAdminProtect)
	end
end)

task.spawn(function()
	local lastCheck = tick()
	while task.wait(1) do
		if not ScreenGui or not ScreenGui.Parent then
			SendNotification("UPDATE SCRIPT", "تم تحديث السكربت يتم اعادة دخول السيرفر …")
			task.wait(1)
			game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
			break
		end
	end
end)
