--[[
    Script: Ultra Modern FishIt Gifting UI
    Author: Bloxhouse Enhanced
    ]]

--// Services //--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

--// Configuration //--
local UI_CONFIG = {
    Title = "Bloxhouse Gifting Menu",
    ToggleKey = Enum.KeyCode.RightControl,
    Draggable = true,

    -- Professional color palette
    PrimaryColor = Color3.fromRGB(56, 130, 245),   -- Professional blue #3882F5
    SecondaryColor = Color3.fromRGB(71, 85, 105),  -- Professional gray #475569
    BackgroundColor = Color3.fromRGB(241, 245, 249), -- Clean light blue-gray #F1F5F9
    CardColor = Color3.fromRGB(255, 255, 255),       -- Pure white for cards
    AccentColor = Color3.fromRGB(14, 165, 233),      -- Professional teal #0EA5E9
    AccentColor2 = Color3.fromRGB(139, 92, 246),     -- Professional purple #8B5CF6

    TextColor = Color3.fromRGB(15, 23, 42),          -- Professional dark text #0F172A
    Font = Enum.Font.GothamBold,
}

--// Item List //--
local ITEMS = {
    {name = "x8 Luck", icon = "✨", color = Color3.fromRGB(251, 191, 36)},
    {name = "x4 Luck", icon = "⭐", color = Color3.fromRGB(251, 191, 36)},
    {name = "x2 Luck", icon = "🌟", color = Color3.fromRGB(251, 191, 36)},
    {name = "Eclipse Katana", icon = "⚔️", color = Color3.fromRGB(139, 92, 246)},
    {name = "Princess Parasol", icon = "☂️", color = Color3.fromRGB(236, 72, 153)},
    {name = "Blossom Pack", icon = "🌸", color = Color3.fromRGB(236, 72, 153)},
    {name = "Future Pack", icon = "🚀", color = Color3.fromRGB(59, 130, 246)},
    {name = "Sharki", icon = "🦈", color = Color3.fromRGB(14, 165, 233)},
    {name = "Burger Boat", icon = "🍔", color = Color3.fromRGB(251, 146, 60)},
    {name = "Pumpkin Crate 1", icon = "🎃", color = Color3.fromRGB(249, 115, 22)}
}

--// Main Function //--
local function executeGift(itemName)
    pcall(function()
        local GiftingController = require(ReplicatedStorage:WaitForChild("Controllers"):WaitForChild("GiftingController"))
        GiftingController:Open(itemName)
    end)
end

--// Utility Functions //--
local function createBlur(parent, intensity)
    local blur = Instance.new("Frame")
    blur.Size = UDim2.new(1, 0, 1, 0)
    blur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blur.BackgroundTransparency = 0.3
    blur.BorderSizePixel = 0
    blur.Parent = parent
    return blur
end

local function createGlow(parent, color)
    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.Size = UDim2.new(1, 40, 1, 40)
    glow.Position = UDim2.new(0.5, -20, 0.5, -20)
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://5028857084"
    glow.ImageColor3 = color
    glow.ImageTransparency = 0.7
    glow.ZIndex = 0
    glow.Parent = parent
    return glow
end

--// Clean up previous UI //--
if Players.LocalPlayer:FindFirstChild("PlayerGui") and Players.LocalPlayer.PlayerGui:FindFirstChild("UltraModernFishItUI") then
    Players.LocalPlayer.PlayerGui.UltraModernFishItUI:Destroy()
end

--// Main ScreenGui //--
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltraModernFishItUI"
screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false

--// Minimized Button //--
local minimizedButton = Instance.new("ImageButton")
minimizedButton.Name = "MinimizedButton"
minimizedButton.Parent = screenGui
minimizedButton.Size = UDim2.new(0, 60, 0, 60)
minimizedButton.Position = UDim2.new(1, -80, 0, 20)
minimizedButton.BackgroundColor3 = UI_CONFIG.BackgroundColor
minimizedButton.BackgroundTransparency = 0.1
minimizedButton.Image = "rbxassetid://6034842695"
minimizedButton.ImageColor3 = UI_CONFIG.PrimaryColor
minimizedButton.Visible = false
minimizedButton.ZIndex = 100

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(1, 0)
minCorner.Parent = minimizedButton

local minStroke = Instance.new("UIStroke")
minStroke.Color = UI_CONFIG.PrimaryColor
minStroke.Thickness = 2
minStroke.Transparency = 0.5
minStroke.Parent = minimizedButton

local minGlow = createGlow(minimizedButton, UI_CONFIG.PrimaryColor)

--// Main Container //--
local mainContainer = Instance.new("Frame")
mainContainer.Name = "MainContainer"
mainContainer.Parent = screenGui
mainContainer.Size = UDim2.new(0, 480, 0, 520)
mainContainer.Position = UDim2.new(0.5, -240, 0.5, -260)
mainContainer.BackgroundColor3 = UI_CONFIG.BackgroundColor
mainContainer.BackgroundTransparency = 0.05
mainContainer.BorderSizePixel = 0
mainContainer.Active = true
mainContainer.ClipsDescendants = false

local containerCorner = Instance.new("UICorner")
containerCorner.CornerRadius = UDim.new(0, 16)
containerCorner.Parent = mainContainer

local containerStroke = Instance.new("UIStroke")
containerStroke.Color = UI_CONFIG.SecondaryColor
containerStroke.Transparency = 0.5
containerStroke.Thickness = 1
containerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
containerStroke.Parent = mainContainer

-- Container glow effect
local containerGlow = createGlow(mainContainer, UI_CONFIG.PrimaryColor)

-- Background Gradient
local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, UI_CONFIG.BackgroundColor),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(224, 231, 255))
})
bgGradient.Rotation = 0
bgGradient.Parent = mainContainer

--// Header //--
local header = Instance.new("Frame")
header.Name = "Header"
header.Parent = mainContainer
header.Size = UDim2.new(1, 0, 0, 70)
header.BackgroundTransparency = 1
header.ZIndex = 2

-- Header separator line
local headerSeparator = Instance.new("Frame")
headerSeparator.Size = UDim2.new(1, -40, 0, 1)
headerSeparator.Position = UDim2.new(0, 20, 1, -10)
headerSeparator.BackgroundColor3 = UI_CONFIG.SecondaryColor
headerSeparator.BackgroundTransparency = 0.8
headerSeparator.BorderSizePixel = 0
headerSeparator.Parent = header

local headerSeparatorCorner = Instance.new("UICorner")
headerSeparatorCorner.CornerRadius = UDim.new(0, 2)
headerSeparatorCorner.Parent = headerSeparator

-- Header background for better text contrast
local headerBg = Instance.new("Frame")
headerBg.Size = UDim2.new(1, 0, 1, 0)
headerBg.BackgroundColor3 = UI_CONFIG.TextColor
headerBg.BackgroundTransparency = 0.95
headerBg.BorderSizePixel = 0
headerBg.Parent = header
local headerBgCorner = Instance.new("UICorner")
headerBgCorner.CornerRadius = UDim.new(0, 16)
headerBgCorner.Parent = headerBg

-- Logo Circle
local logoCircle = Instance.new("Frame")
logoCircle.Name = "LogoCircle"
logoCircle.Size = UDim2.new(0, 40, 0, 40)
logoCircle.Position = UDim2.new(0, 20, 0.5, -20)
logoCircle.BackgroundColor3 = UI_CONFIG.CardColor
logoCircle.BorderSizePixel = 0
logoCircle.Parent = header

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(1, 0)
logoCorner.Parent = logoCircle

local logoStroke = Instance.new("UIStroke")
logoStroke.Color = UI_CONFIG.PrimaryColor
logoStroke.Thickness = 1.5
logoStroke.Transparency = 0.5
logoStroke.Parent = logoCircle

-- Try loading image from the provided asset ID, fallback to default if fails
local logoIcon = Instance.new("ImageLabel")
logoIcon.Size = UDim2.new(0, 24, 0, 24)
logoIcon.Position = UDim2.new(0.5, -12, 0.5, -12)
logoIcon.BackgroundTransparency = 1
logoIcon.ImageColor3 = UI_CONFIG.PrimaryColor
logoIcon.ScaleType = Enum.ScaleType.Fit
logoIcon.Parent = logoCircle

-- Notification Frame
local notificationFrame = Instance.new("Frame")
notificationFrame.Size = UDim2.new(0, 300, 0, 50)
notificationFrame.Position = UDim2.new(0.5, -150, 0, -60)
notificationFrame.BackgroundColor3 = UI_CONFIG.TextColor
notificationFrame.BackgroundTransparency = 0.9
notificationFrame.BorderSizePixel = 0
notificationFrame.ZIndex = 10
notificationFrame.Parent = mainContainer
local notificationCorner = Instance.new("UICorner")
notificationCorner.CornerRadius = UDim.new(0, 8)
notificationCorner.Parent = notificationFrame

local notificationLabel = Instance.new("TextLabel")
notificationLabel.Size = UDim2.new(1, 0, 1, 0)
notificationLabel.BackgroundTransparency = 1
notificationLabel.Text = ""
notificationLabel.TextColor3 = UI_CONFIG.PrimaryColor
notificationLabel.TextSize = 14
notificationLabel.Font = UI_CONFIG.Font
notificationLabel.ZIndex = 10
notificationLabel.Parent = notificationFrame

-- Notification showing which logo is being attempted
notificationLabel.Text = "🔍 Attempting to load logo: @logo_seamless.png"

-- Attempt to set the image and handle failure gracefully with notifications
local success, errorMessage = pcall(function()
    logoIcon.Image = "@logo_seamless.png"  -- Provided local asset reference
    notificationLabel.Text = "✅ Logo loaded: @logo_seamless.png (Local Asset)"
end)

-- If first attempt fails, try GitHub URL
if not success then
    -- Update notification to show what failed
    notificationLabel.Text = "⚠️ Local asset failed, trying GitHub URL..."

    wait(1) -- Pause to allow user to see the status

    local urlSuccess, urlErrorMessage = pcall(function()
        logoIcon.Image = "https://raw.githubusercontent.com/Bloxhouse/bloxhouse-fishit-gifting-script/refs/heads/main/logo_seamless.png"
        notificationLabel.Text = "✅ Logo loaded: GitHub Raw URL"
    end)

    -- If GitHub URL also fails, use default fallback
    if not urlSuccess then
        notificationLabel.Text = "⚠️ GitHub URL failed, using default asset..."

        wait(1) -- Pause to allow user to see the status

        local defaultSuccess, defaultError = pcall(function()
            logoIcon.Image = "rbxassetid://6034842695"  -- Default circle icon as fallback
            notificationLabel.Text = "✅ Logo loaded: Roblox Default Asset"
        end)

        if not defaultSuccess then
            notificationLabel.Text = "❌ All logo attempts failed - using fallback"
        end
    else
        notificationLabel.Text = "✅ Success: GitHub Raw URL loaded"
    end
else
    notificationLabel.Text = "✅ Success: Local asset loaded"
end

-- Keep notification visible for 10 seconds so user can see which logo loaded
spawn(function()
    wait(10)
    TweenService:Create(notificationFrame, TweenInfo.new(1), {
        Position = UDim2.new(0.5, -150, 0, -100)
    }):Play()
    wait(1)
    notificationFrame:Destroy()
end)

-- Title with gradient effect
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Parent = header
titleLabel.Size = UDim2.new(0, 250, 0, 30)
titleLabel.Position = UDim2.new(0, 75, 0.5, -15)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = UI_CONFIG.Title
titleLabel.Font = UI_CONFIG.Font
titleLabel.TextColor3 = UI_CONFIG.PrimaryColor
titleLabel.TextSize = 20
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, UI_CONFIG.PrimaryColor),
    ColorSequenceKeypoint.new(1, UI_CONFIG.SecondaryColor)
})
titleGradient.Rotation = 45
titleGradient.Parent = titleLabel

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(0, 250, 0, 15)
subtitle.Position = UDim2.new(0, 75, 0.5, 10)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Deleted items can no longer be gifted at FishIt, Please choose wisely."
subtitle.Font = Enum.Font.Gotham
subtitle.TextColor3 = UI_CONFIG.SecondaryColor
subtitle.TextSize = 11
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

-- Header Buttons
local headerBtnContainer = Instance.new("Frame")
headerBtnContainer.Size = UDim2.new(0, 120, 0, 30)  -- Reduced width and height
headerBtnContainer.Position = UDim2.new(1, -130, 0.5, -15)  -- Adjusted position
headerBtnContainer.BackgroundTransparency = 1
headerBtnContainer.Parent = header

local btnLayout = Instance.new("UIListLayout")
btnLayout.FillDirection = Enum.FillDirection.Horizontal
btnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
btnLayout.SortOrder = Enum.SortOrder.LayoutOrder
btnLayout.Padding = UDim.new(0, 6)  -- Reduced padding
btnLayout.Parent = headerBtnContainer

-- Maximize Button
local maximizeBtn = Instance.new("TextButton")
maximizeBtn.Name = "MaximizeBtn"
maximizeBtn.Size = UDim2.new(0, 26, 0, 26)  -- Reduced size
maximizeBtn.BackgroundColor3 = UI_CONFIG.CardColor
maximizeBtn.BackgroundTransparency = 0.2
maximizeBtn.Text = "□"  -- Square character for maximize
maximizeBtn.Font = UI_CONFIG.Font
maximizeBtn.TextColor3 = UI_CONFIG.SecondaryColor
maximizeBtn.TextSize = 16  -- Reduced text size
maximizeBtn.Parent = headerBtnContainer

local maxBtnCorner = Instance.new("UICorner")
maxBtnCorner.CornerRadius = UDim.new(0, 6)  -- Reduced corner radius
maxBtnCorner.Parent = maximizeBtn

local maxBtnStroke = Instance.new("UIStroke")
maxBtnStroke.Color = UI_CONFIG.SecondaryColor
maxBtnStroke.Transparency = 0.7
maxBtnStroke.Thickness = 1
maxBtnStroke.Parent = maximizeBtn

-- Minimize Button
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 26, 0, 26)  -- Reduced size
minimizeBtn.BackgroundColor3 = UI_CONFIG.CardColor
minimizeBtn.BackgroundTransparency = 0.2
minimizeBtn.Text = "−"
minimizeBtn.Font = UI_CONFIG.Font
minimizeBtn.TextColor3 = UI_CONFIG.SecondaryColor
minimizeBtn.TextSize = 16  -- Reduced text size
minimizeBtn.Parent = headerBtnContainer

local minBtnCorner = Instance.new("UICorner")
minBtnCorner.CornerRadius = UDim.new(0, 6)  -- Reduced corner radius
minBtnCorner.Parent = minimizeBtn

local minBtnStroke = Instance.new("UIStroke")
minBtnStroke.Color = UI_CONFIG.SecondaryColor
minBtnStroke.Transparency = 0.7
minBtnStroke.Thickness = 1
minBtnStroke.Parent = minimizeBtn

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 26, 0, 26)  -- Reduced size
closeBtn.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
closeBtn.BackgroundTransparency = 0.2
closeBtn.Text = "×"
closeBtn.Font = UI_CONFIG.Font
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 18  -- Reduced text size
closeBtn.Parent = headerBtnContainer

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 6)  -- Reduced corner radius
closeBtnCorner.Parent = closeBtn

local closeBtnStroke = Instance.new("UIStroke")
closeBtnStroke.Color = Color3.fromRGB(239, 68, 68)
closeBtnStroke.Transparency = 0.5
closeBtnStroke.Thickness = 1
closeBtnStroke.Parent = closeBtn

-- Button hover effects
for _, btn in ipairs({maximizeBtn, minimizeBtn}) do
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0, TextColor3 = UI_CONFIG.PrimaryColor}):Play()
        TweenService:Create(btn, TweenInfo.new(0.2), {Size = UDim2.new(0, 30, 0, 30)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2, TextColor3 = UI_CONFIG.SecondaryColor}):Play()
        TweenService:Create(btn, TweenInfo.new(0.2), {Size = UDim2.new(0, 26, 0, 26)}):Play()
    end)
end

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {Size = UDim2.new(0, 30, 0, 30)}):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {Size = UDim2.new(0, 26, 0, 26)}):Play()
end)

--// Content Area //--
local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Parent = mainContainer
contentFrame.Size = UDim2.new(1, -30, 1, -95)
contentFrame.Position = UDim2.new(0, 15, 0, 80)
contentFrame.BackgroundTransparency = 1
contentFrame.ZIndex = 2

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Parent = contentFrame
scrollFrame.Size = UDim2.new(1, 0, 1, 0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = UI_CONFIG.SecondaryColor
scrollFrame.ScrollBarImageTransparency = 0.5
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y

-- Scroll bar styling
local scrollBarCorner = Instance.new("UICorner")
scrollBarCorner.CornerRadius = UDim.new(0, 3)
scrollBarCorner.Parent = scrollFrame

-- Replace UIGridLayout with UIListLayout for list format
local listLayout = Instance.new("UIListLayout")
listLayout.Parent = scrollFrame
listLayout.Padding = UDim.new(0, 12)  -- Increased space between items
listLayout.SortOrder = Enum.SortOrder.LayoutOrder

--// Create Item List Items //--
for i, item in ipairs(ITEMS) do
    local listItem = Instance.new("TextButton")
    listItem.Name = "ListItem_" .. i
    listItem.Parent = scrollFrame
    listItem.BackgroundColor3 = UI_CONFIG.CardColor
    listItem.BackgroundTransparency = 0.1
    listItem.Text = ""
    listItem.LayoutOrder = i
    listItem.Size = UDim2.new(1, 0, 0, 65)  -- Increased height for better spacing
    listItem.ClipsDescendants = true

    local itemCorner = Instance.new("UICorner")
    itemCorner.CornerRadius = UDim.new(0, 12)
    itemCorner.Parent = listItem

    local itemStroke = Instance.new("UIStroke")
    itemStroke.Color = item.color
    itemStroke.Thickness = 1
    itemStroke.Transparency = 0.8
    itemStroke.Parent = listItem

    -- Icon container
    local iconContainer = Instance.new("Frame")
    iconContainer.Size = UDim2.new(0, 45, 0, 45)
    iconContainer.Position = UDim2.new(0, 15, 0.5, -22.5)
    iconContainer.BackgroundColor3 = item.color
    iconContainer.BackgroundTransparency = 0.9
    iconContainer.BorderSizePixel = 0
    iconContainer.Parent = listItem

    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 8)
    iconCorner.Parent = iconContainer

    -- Icon text
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(1, 0, 1, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = item.icon
    iconLabel.Font = UI_CONFIG.Font
    iconLabel.TextSize = 22
    iconLabel.TextColor3 = item.color
    iconLabel.Parent = iconContainer

    -- Item name
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0, 180, 1, 0)
    nameLabel.Position = UDim2.new(0, 75, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = item.name
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextColor3 = UI_CONFIG.TextColor
    nameLabel.TextSize = 15
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.TextYAlignment = Enum.TextYAlignment.Center
    nameLabel.Parent = listItem

    -- Hover effect
    local hoverFrame = Instance.new("Frame")
    hoverFrame.Size = UDim2.new(1, 0, 1, 0)
    hoverFrame.BackgroundColor3 = item.color
    hoverFrame.BackgroundTransparency = 0.95
    hoverFrame.BorderSizePixel = 0
    hoverFrame.ZIndex = 0
    hoverFrame.Parent = listItem

    local hoverCorner = Instance.new("UICorner")
    hoverCorner.CornerRadius = UDim.new(0, 12)
    hoverCorner.Parent = hoverFrame

    -- Animations
    listItem.MouseEnter:Connect(function()
        TweenService:Create(listItem, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
        TweenService:Create(itemStroke, TweenInfo.new(0.2), {Transparency = 0.3, Thickness = 2}):Play()
        TweenService:Create(hoverFrame, TweenInfo.new(0.2), {BackgroundTransparency = 0.8}):Play()
        TweenService:Create(iconLabel, TweenInfo.new(0.2), {TextSize = 26}):Play()
        TweenService:Create(nameLabel, TweenInfo.new(0.2), {TextColor3 = item.color, Font = Enum.Font.GothamBlack}):Play()
    end)

    listItem.MouseLeave:Connect(function()
        TweenService:Create(listItem, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.1}):Play()
        TweenService:Create(itemStroke, TweenInfo.new(0.2), {Transparency = 0.8, Thickness = 1}):Play()
        TweenService:Create(hoverFrame, TweenInfo.new(0.2), {BackgroundTransparency = 0.95}):Play()
        TweenService:Create(iconLabel, TweenInfo.new(0.2), {TextSize = 22}):Play()
        TweenService:Create(nameLabel, TweenInfo.new(0.2), {TextColor3 = UI_CONFIG.TextColor, Font = Enum.Font.GothamBold}):Play()
    end)

    -- Click action
    listItem.MouseButton1Click:Connect(function()
        -- Change text
        local originalText = nameLabel.Text
        nameLabel.Text = "✓ Sent!"
        nameLabel.TextColor3 = UI_CONFIG.AccentColor2

        executeGift(item.name)

        wait(1.5)
        nameLabel.Text = originalText
        nameLabel.TextColor3 = UI_CONFIG.TextColor
    end)
end

-- Update canvas size
listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)
end)

--// State Management //--
local isMinimized = false
local isMaximized = false
local isVisible = true
local normalSize = UDim2.new(0, 480, 0, 520)
local normalPosition = UDim2.new(0.5, -240, 0.5, -260)
local maximizedSize = UDim2.new(0, 800, 0, 520)
local maximizedPosition = UDim2.new(0.5, -400, 0.5, -260)

-- Store the original list layout
local currentLayout = listLayout

maximizeBtn.MouseButton1Click:Connect(function()
    isMaximized = not isMaximized

    if isMaximized then
        -- Change button to minimize icon
        maximizeBtn.Text = "❐"  -- Minimize from maximized icon
        -- Animate to maximized size
        TweenService:Create(mainContainer, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
            Size = maximizedSize,
            Position = maximizedPosition
        }):Play()

        -- Switch to grid layout
        currentLayout:Destroy()
        local gridLayout = Instance.new("UIGridLayout")
        gridLayout.Parent = scrollFrame
        gridLayout.CellPadding = UDim2.new(0, 12, 0, 12)
        gridLayout.CellSize = UDim2.new(0.45, 0, 0, 70)  -- Two columns with some spacing
        gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
        currentLayout = gridLayout

        -- Update canvas size for grid
        gridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, gridLayout.AbsoluteContentSize.Y + 20)
        end)
    else
        -- Change button back to maximize icon
        maximizeBtn.Text = "□"
        -- Animate back to normal size
        TweenService:Create(mainContainer, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
            Size = normalSize,
            Position = normalPosition
        }):Play()

        -- Switch back to list layout
        currentLayout:Destroy()
        local listLayout = Instance.new("UIListLayout")
        listLayout.Parent = scrollFrame
        listLayout.Padding = UDim.new(0, 12)  -- Space between items
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        currentLayout = listLayout

        -- Update canvas size for list
        listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)
        end)
    end
end)

minimizeBtn.MouseButton1Click:Connect(function()
    if isMaximized then
        -- If maximized, first return to normal size before minimizing
        isMaximized = false
        maximizeBtn.Text = "□"  -- Change button back to maximize
        -- Animate to normal size first
        TweenService:Create(mainContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Size = normalSize,
            Position = normalPosition
        }):Play()
        wait(0.2)
    end

    isMinimized = true
    TweenService:Create(mainContainer, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(1, -80, 0, 20)
    }):Play()
    wait(0.4)
    mainContainer.Visible = false
    minimizedButton.Visible = true
    TweenService:Create(minimizedButton, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 60, 0, 60)
    }):Play()
end)

minimizedButton.MouseButton1Click:Connect(function()
    isMinimized = false
    TweenService:Create(minimizedButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    wait(0.2)
    minimizedButton.Visible = false
    mainContainer.Visible = true
    mainContainer.Size = UDim2.new(0, 0, 0, 0)
    mainContainer.Position = UDim2.new(1, -80, 0, 20)
    TweenService:Create(mainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
        Size = isMaximized and maximizedSize or normalSize,
        Position = isMaximized and maximizedPosition or normalPosition
    }):Play()
end)

closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(mainContainer, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1
    }):Play()
    wait(0.3)
    screenGui:Destroy()
end)

--// Draggable //--
if UI_CONFIG.Draggable then
    local dragging, dragInput, dragStart, startPos

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and not isMinimized then
            dragging = true
            dragStart = input.Position
            startPos = mainContainer.Position
        end
    end)

    header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            mainContainer.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

--// Toggle Visibility //--
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == UI_CONFIG.ToggleKey then
        isVisible = not isVisible
        if isMinimized then
            minimizedButton.Visible = isVisible
        else
            mainContainer.Visible = isVisible
        end
    end
end)

--// Entrance Animation //--
mainContainer.Size = UDim2.new(0, 0, 0, 0)
mainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
mainContainer.BackgroundTransparency = 1

TweenService:Create(mainContainer, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
    Size = UDim2.new(0, 480, 0, 520),
    Position = UDim2.new(0.5, -240, 0.5, -260),
    BackgroundTransparency = 0.05
}):Play()

-- Fade in cards
for i, card in ipairs(scrollFrame:GetChildren()) do
    if card:IsA("TextButton") then
        card.BackgroundTransparency = 0.8
        task.wait(0.05)
        TweenService:Create(card, TweenInfo.new(0.4), {BackgroundTransparency = 0.1}):Play()
    end
end

print("🎨 Ultra Modern FishIt UI Loaded!")
print("⌨️ Press Right-Ctrl to toggle visibility")