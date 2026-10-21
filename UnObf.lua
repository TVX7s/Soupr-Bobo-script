local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local TeleportService = game:GetService("TeleportService")
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

local PremiumList = {
	["zZzE_041"] = true
}

local ChosenBgImage = BackgroundImagesList[math.random(1, #BackgroundImagesList)]

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
		sound.SoundId = "rbxassetid://4590657391"
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

local function SendCustomNotification(titleText, bodyText, imageId)
	PlayNotifySound()
	local NotifFrame = Instance.new("Frame")
	NotifFrame.Name = "CustomNotif"
	NotifFrame.Size = UDim2.new(0, 280, 0, 65)
	NotifFrame.Position = UDim2.new(1, 10, 0, 20)
	NotifFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	NotifFrame.BorderSizePixel = 0
	NotifFrame.ZIndex = 100
	NotifFrame.Parent = ScreenGui

	local NotifBg = Instance.new("ImageLabel")
	NotifBg.Size = UDim2.new(1, 0, 1, 0)
	NotifBg.BackgroundTransparency = 1
	NotifBg.Image = ChosenBgImage
	NotifBg.ScaleType = Enum.ScaleType.Crop
	NotifBg.ImageTransparency = 0.5
	NotifBg.ZIndex = 100
	NotifBg.Parent = NotifFrame

	local NotifCorner = Instance.new("UICorner")
	NotifCorner.CornerRadius = UDim.new(0, 8)
	NotifCorner.Parent = NotifFrame
	
	local NotifBgCorner = Instance.new("UICorner")
	NotifBgCorner.CornerRadius = UDim.new(0, 8)
	NotifBgCorner.Parent = NotifBg

	local NotifStroke = Instance.new("UIStroke")
	NotifStroke.Thickness = 2
	NotifStroke.Color = Color3.fromRGB(0, 0, 0)
	NotifStroke.Parent = NotifFrame

	if imageId then
		local NotifImg = Instance.new("ImageLabel")
		NotifImg.Size = UDim2.new(0, 45, 0, 45)
		NotifImg.Position = UDim2.new(0, 10, 0.5, -22)
		NotifImg.BackgroundTransparency = 1
		NotifImg.Image = imageId
		NotifImg.ZIndex = 101
		NotifImg.Parent = NotifFrame
		
		local ImgCorner = Instance.new("UICorner")
		ImgCorner.CornerRadius = UDim.new(0, 6)
		ImgCorner.Parent = NotifImg
	end

	local TextOffsetX = imageId and 65 or 10
	local TitleLbl = Instance.new("TextLabel")
	TitleLbl.Size = UDim2.new(1, -TextOffsetX - 10, 0, 20)
	TitleLbl.Position = UDim2.new(0, TextOffsetX, 0, 8)
	TitleLbl.BackgroundTransparency = 1
	TitleLbl.Text = titleText
	TitleLbl.Font = Enum.Font.GothamBold
	TitleLbl.TextSize = 12
	TitleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
	TitleLbl.ZIndex = 101
	TitleLbl.Parent = NotifFrame

	local BodyLbl = Instance.new("TextLabel")
	BodyLbl.Size = UDim2.new(1, -TextOffsetX - 10, 0, 30)
	BodyLbl.Position = UDim2.new(0, TextOffsetX, 0, 28)
	BodyLbl.BackgroundTransparency = 1
	BodyLbl.Text = bodyText
	BodyLbl.Font = Enum.Font.Gotham
	BodyLbl.TextSize = 10
	BodyLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
	BodyLbl.TextWrapped = true
	BodyLbl.TextXAlignment = Enum.TextXAlignment.Left
	BodyLbl.ZIndex = 101
	BodyLbl.Parent = NotifFrame

	TweenService:Create(NotifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Position = UDim2.new(1, -290, 0, 20)
	}):Play()

	task.delay(3.5, function()
		local tw = TweenService:Create(NotifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			Position = UDim2.new(1, 10, 0, 20)
		})
		tw:Play()
		tw.Completed:Connect(function()
			NotifFrame:Destroy()
		end)
	end)
end

if LocalPlayer.Name == "zZzE_041" then
	SendCustomNotification("ادارة سوبر بوبو", "انت محمي من جميع اوامر الاستهداف", nil)
end

local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(1, -55, 0.5, -22)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.Image = ChosenBgImage
ToggleBtn.ScaleType = Enum.ScaleType.Crop
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Thickness = 2
ToggleStroke.Color = Color3.fromRGB(255, 255, 255)
ToggleStroke.Parent = ToggleBtn

local WebContainer = Instance.new("Frame")
WebContainer.Name = "WebContainer"
WebContainer.Size = UDim2.new(0, 400, 0, 520)
WebContainer.Position = UDim2.new(0.5, -200, 0.5, -260)
WebContainer.BackgroundColor3 = Color3.fromRGB(13, 15, 20)
WebContainer.BorderSizePixel = 0
WebContainer.Active = true
WebContainer.Draggable = true
WebContainer.Parent = ScreenGui

ToggleBtn.MouseButton1Click:Connect(function()
	PlayClickSound()
	TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {Rotation = ToggleBtn.Rotation + 90}):Play()
	WebContainer.Visible = not WebContainer.Visible
end)

local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Name = "BackgroundImage"
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = ChosenBgImage
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

local MainContentFrame = Instance.new("Frame")
MainContentFrame.Name = "MainContentFrame"
MainContentFrame.Size = UDim2.new(1, 0, 1, 0)
MainContentFrame.BackgroundTransparency = 1
MainContentFrame.Parent = WebContainer

local ChangeBgFrame = Instance.new("Frame")
ChangeBgFrame.Name = "ChangeBgFrame"
ChangeBgFrame.Size = UDim2.new(1, 0, 1, 0)
ChangeBgFrame.BackgroundTransparency = 1
ChangeBgFrame.Visible = false
ChangeBgFrame.Parent = WebContainer

local BrowserHeader = Instance.new("Frame")
BrowserHeader.Name = "BrowserHeader"
BrowserHeader.Size = UDim2.new(1, 0, 0, 28)
BrowserHeader.BackgroundColor3 = Color3.fromRGB(20, 23, 31)
BrowserHeader.BorderSizePixel = 0
BrowserHeader.Parent = MainContentFrame

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
SearchBox.PlaceholderText = "اسم اللاعب..."
SearchBox.PlaceholderColor3 = Color3.fromRGB(110, 120, 140)
SearchBox.Text = ""
SearchBox.Font = Enum.Font.GothamMedium
SearchBox.TextSize = 11
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.ClearTextOnFocus = false
SearchBox.Parent = MainContentFrame

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
CmdBarBox.Parent = MainContentFrame

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
HelpBtn.Parent = MainContentFrame

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
	SendCustomNotification("ملاحظة \"?\"", "فايدة خانة الاوامر لما تكتب اي امر محد يقدر تشوفك", nil)
end)

local Card = Instance.new("Frame")
Card.Size = UDim2.new(1, -16, 0, 122)
Card.Position = UDim2.new(0, 8, 0, 100)
Card.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
Card.BackgroundTransparency = 0.4
Card.BorderSizePixel = 0
Card.Parent = MainContentFrame

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

local ButtonsContainer = Instance.new("Frame")
ButtonsContainer.Size = UDim2.new(1, -16, 0, 280)
ButtonsContainer.Position = UDim2.new(0, 8, 0, 230)
ButtonsContainer.BackgroundTransparency = 1
ButtonsContainer.Parent = MainContentFrame

local ButtonsList = Instance.new("UIListLayout")
ButtonsList.SortOrder = Enum.SortOrder.LayoutOrder
ButtonsList.Padding = UDim.new(0, 6)
ButtonsList.Parent = ButtonsContainer

local function CreateStyledButton(text, order)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 32)
	btn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
	btn.BackgroundTransparency = 0.4
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextColor3 = Color3.fromRGB(255, 0, 0)
	btn.TextSize = 12
	btn.AutoButtonColor = false
	btn.LayoutOrder = order
	btn.Parent = ButtonsContainer

	local btnImg = Instance.new("ImageLabel")
	btnImg.Size = UDim2.new(1, 0, 1, 0)
	btnImg.BackgroundTransparency = 1
	btnImg.Image = ChosenBgImage
	btnImg.ScaleType = Enum.ScaleType.Crop
	btnImg.ImageTransparency = 0.75
	btnImg.Parent = btn

	local BtnCorner = Instance.new("UICorner")
	BtnCorner.CornerRadius = UDim.new(0, 6)
	BtnCorner.Parent = btn

	local BtnImgCorner = Instance.new("UICorner")
	BtnImgCorner.CornerRadius = UDim.new(0, 6)
	BtnImgCorner.Parent = btnImg

	local BtnStroke = Instance.new("UIStroke")
	BtnStroke.Thickness = 3
	BtnStroke.Color = Color3.fromRGB(0, 0, 0)
	BtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	BtnStroke.Parent = btn

	local BtnGradient = Instance.new("UIGradient")
	BtnGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.52, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
	})
	BtnGradient.Parent = BtnStroke

	local ShineTween = TweenService:Create(
		BtnGradient,
		TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
		{ Rotation = 360 }
	)
	ShineTween:Play()

	btn.MouseButton1Down:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0.98, 0, 0, 30)}):Play()
	end)

	btn.MouseButton1Up:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 32)}):Play()
	end)

	return btn
end

local ActionBtn = CreateStyledButton("تخريب اللاعب", 1)
local DogBtn = CreateStyledButton("خلي الناس كلاب", 2)
local FreezeBtn = CreateStyledButton("ما يمديه يتحرك", 3)
local SizeBtn = CreateStyledButton("تكبير الناس", 4)
local ChangeBgBtn = CreateStyledButton("تغيير صورة الخلفية", 5)

local AdminProtectBtn = nil
if PremiumList[LocalPlayer.Name] then
	AdminProtectBtn = CreateStyledButton("حماية الادمن", 6)
end

local SelectedPlayer = nil
local TrollingActive = false
local FreezingActive = false
local AdminProtectActive = false

local function ResetTargetState()
	TrollingActive = false
	FreezingActive = false
	ActionBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
	FreezeBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
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
		ResetTargetState()
	end
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local txt = SearchBox.Text
	if txt:find("zZzE_041") then
		local protectedPlayerInServer = Players:FindFirstChild("zZzE_041")
		if protectedPlayerInServer then
			SearchBox.Text = ""
			SendCustomNotification("System سوبر بوبو", "ما يمديك تستهدف هذا اليوزر لانه محمي من السكربت", nil)
			return
		end
	end
	local found = GetPlayerByShortcut(txt)
	UpdateUI(found)
end)

Players.PlayerRemoving:Connect(function(player)
	if SelectedPlayer and player == SelectedPlayer then
		local victimImg = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
		ResetTargetState()
		SendCustomNotification("B O B O ~ T E A M", "الضحية هجت من السيرفر", victimImg)
	end
end)

CmdBarBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		PlayClickSound()
		local txt = CmdBarBox.Text
		if txt ~= "" then
			local signal, prefix = GetSignalAndPrefix()
			if signal then
				local fullCmd = txt
				if prefix ~= "" and txt:sub(1, #prefix) ~= prefix then
					fullCmd = prefix .. txt
				end
				signal:InvokeServer(fullCmd)
				SendCustomNotification("System بوبو", "Executed .. \"" .. txt .. "\"", nil)
			end
			CmdBarBox.Text = ""
		end
	end
end)

ActionBtn.MouseButton1Click:Connect(function()
	PlayClickSound()
	TrollingActive = not TrollingActive
	
	if TrollingActive then
		ActionBtn.TextColor3 = Color3.fromRGB(0, 255, 0)
		
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
		ActionBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

DogBtn.MouseButton1Click:Connect(function()
	PlayClickSound()
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
	PlayClickSound()
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
	PlayClickSound()
	FreezingActive = not FreezingActive
	
	if FreezingActive then
		FreezeBtn.TextColor3 = Color3.fromRGB(0, 255, 0)
		
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
		FreezeBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

if AdminProtectBtn then
	AdminProtectBtn.MouseButton1Click:Connect(function()
		PlayClickSound()
		AdminProtectActive = not AdminProtectActive
		if AdminProtectActive then
			AdminProtectBtn.TextColor3 = Color3.fromRGB(0, 255, 0)
		else
			AdminProtectBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
		end
	end)
end

task.spawn(function()
	while task.wait(1) do
		if AdminProtectActive then
			local signal, prefix = GetSignalAndPrefix()
			if signal then
				signal:InvokeServer(prefix .. "re " .. LocalPlayer.Name)
			end
		end
	end
end)

local BgTitle = Instance.new("TextLabel")
BgTitle.Size = UDim2.new(1, 0, 0, 40)
BgTitle.Position = UDim2.new(0, 0, 0, 10)
BgTitle.BackgroundTransparency = 1
BgTitle.Text = "اختر صورة الخلفية"
BgTitle.Font = Enum.Font.GothamBold
BgTitle.TextSize = 14
BgTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
BgTitle.Parent = ChangeBgFrame

local ScrollBg = Instance.new("ScrollingFrame")
ScrollBg.Size = UDim2.new(1, -20, 1, -60)
ScrollBg.Position = UDim2.new(0, 10, 0, 50)
ScrollBg.BackgroundTransparency = 1
ScrollBg.BorderSizePixel = 0
ScrollBg.CanvasSize = UDim2.new(0, 0, 0, 600)
ScrollBg.Parent = ChangeBgFrame

local Grid = Instance.new("UIGridLayout")
Grid.CellSize = UDim2.new(0, 110, 0, 110)
Grid.CellPadding = UDim2.new(0, 10, 0, 10)
Grid.Parent = ScrollBg

local function ApplyNewBg(imgUrl)
	ChosenBgImage = imgUrl
	ScreenGui:Destroy()
	task.wait(0.1)
	loadstring(game:HttpGet("https://raw.githubusercontent.com/"))()
end

for idx, imgUrl in ipairs(BackgroundImagesList) do
	local ImgSquare = Instance.new("ImageButton")
	ImgSquare.Image = imgUrl
	ImgSquare.ScaleType = Enum.ScaleType.Crop
	ImgSquare.Parent = ScrollBg
	
	local SquareCorner = Instance.new("UICorner")
	SquareCorner.CornerRadius = UDim.new(0, 8)
	SquareCorner.Parent = ImgSquare

	local SquareStroke = Instance.new("UIStroke")
	SquareStroke.Thickness = 2
	SquareStroke.Color = Color3.fromRGB(255, 255, 255)
	SquareStroke.Parent = ImgSquare

	ImgSquare.MouseButton1Click:Connect(function()
		PlayClickSound()
		BackgroundImage.Image = imgUrl
		ToggleBtn.Image = imgUrl
		ChangeBgFrame.Visible = false
		MainContentFrame.Visible = true
	end)
end

ChangeBgBtn.MouseButton1Click:Connect(function()
	PlayClickSound()
	MainContentFrame.Visible = false
	ChangeBgFrame.Visible = true
end)

task.spawn(function()
	while task.wait(0.5) do
		if WebContainer and WebContainer.Parent then
			pcall(function()
				WebContainer.Visible = WebContainer.Visible
			end)
		end
	end
end)

pcall(function()
	if getgenv and getgenv().ScriptAlreadyLoaded then
		SendCustomNotification("UPDATE SCRIPT", "تم تحديث السكربت يتم اعادة دخول السيرفر …", nil)
		task.wait(1.5)
		TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
	else
		if getgenv then getgenv().ScriptAlreadyLoaded = true end
	end
end)
