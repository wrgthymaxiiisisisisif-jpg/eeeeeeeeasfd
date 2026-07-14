-- Library.lua
local Library = {}
Library.__index = Library

local UIS = game:GetService("UserInputService")
local ACCENT_COLOR = Color3.fromRGB(0, 214, 255)
local TAB_SELECTED_COLOR = Color3.fromRGB(30, 30, 30)   -- same as Group
local TAB_DEFAULT_COLOR  = Color3.fromRGB(24, 24, 24)

-- ============================================================
-- WINDOW
-- ============================================================
function Library:CreateWindow(title)
    local win = {}

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KiciaLib"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local Main = Instance.new("Frame", ScreenGui)
    Main.Name = "Main"
    Main.Size = UDim2.new(0, 400, 0, 437)
    Main.Position = UDim2.new(0.34232, 0, 0.14576, 0)
    Main.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
    Main.BorderSizePixel = 0

    local MainStroke = Instance.new("UIStroke", Main)
    MainStroke.Thickness = 0.51
    MainStroke.Color = ACCENT_COLOR
    MainStroke.LineJoinMode = Enum.LineJoinMode.Miter
    MainStroke.Name = "MainUIStroke"

    -- Title label
    local TitleLabel = Instance.new("TextLabel", Main)
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Size = UDim2.new(0, 84, 0, 21)
    TitleLabel.Position = UDim2.new(0.02503, 0, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 12
    TitleLabel.FontFace = Font.new([[rbxasset://fonts/families/Arial.json]])
    TitleLabel.ZIndex = 998

    -- Drag bar
    local DragBar = Instance.new("Frame", Main)
    DragBar.Name = "DragBar"
    DragBar.Size = UDim2.new(1, 0, 0, 22)
    DragBar.Position = UDim2.new(0, 0, 0, 0)
    DragBar.BackgroundTransparency = 1
    DragBar.ZIndex = 999

    local dragging, dragStart, frameStart = false, nil, nil
    DragBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging   = true
            dragStart  = input.Position
            frameStart = Main.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local d = input.Position - dragStart
            Main.Position = UDim2.new(
                frameStart.X.Scale, frameStart.X.Offset + d.X,
                frameStart.Y.Scale, frameStart.Y.Offset + d.Y
            )
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- Group (tab bar + content)
    local Group = Instance.new("Frame", Main)
    Group.Name = "Group"
    Group.Size = UDim2.new(0, 379, 0, 400)
    Group.Position = UDim2.new(0.02503, 0, 0.05361, 0)
    Group.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Group.BorderSizePixel = 0
    local gS1 = Instance.new("UIStroke", Group)
    gS1.Name = "GroupUIStroke1"
    local gS2 = Instance.new("UIStroke", Group)
    gS2.Thickness = 2; gS2.Color = Color3.fromRGB(58,58,58); gS2.ZIndex = 0

    -- Tab bar container
    local TabBar = Instance.new("Frame", Group)
    TabBar.Name = "TabBar"
    TabBar.Size = UDim2.new(1, 0, 0, 20)
    TabBar.Position = UDim2.new(0, 0, 0.02, 0)
    TabBar.BackgroundTransparency = 1
    TabBar.BorderSizePixel = 0

    local TabBarLayout = Instance.new("UIListLayout", TabBar)
    TabBarLayout.FillDirection = Enum.FillDirection.Horizontal
    TabBarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabBarLayout.Padding = UDim.new(0, 4)

    -- Content area (holds GroupBoxes)
    local ContentArea = Instance.new("Frame", Group)
    ContentArea.Name = "ContentArea"
    ContentArea.Size = UDim2.new(0, 357, 0, 358)
    ContentArea.Position = UDim2.new(0.02739, 0, 0.07122, 0)
    ContentArea.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
    ContentArea.BorderSizePixel = 0
    ContentArea.ClipsDescendants = false
    local caS1 = Instance.new("UIStroke", ContentArea)
    caS1.Thickness = 2; caS1.Color = Color3.fromRGB(58,58,58); caS1.ZIndex = 0

    win._Main        = Main
    win._Group       = Group
    win._TabBar      = TabBar
    win._ContentArea = ContentArea
    win._tabs        = {}
    win._tabFrames   = {}
    win._tabOrder    = 0
    win._activeTab   = nil

    setmetatable(win, {__index = WindowMethods})
    return win
end

-- ============================================================
-- WINDOW METHODS
-- ============================================================
WindowMethods = {}
WindowMethods.__index = WindowMethods

function WindowMethods:AddTab(name)
    local tab = {}
    self._tabOrder = self._tabOrder + 1
    local order = self._tabOrder

    -- Tab button frame
    local TabFrame = Instance.new("Frame", self._TabBar)
    TabFrame.Name = "Tab_" .. name
    TabFrame.Size = UDim2.new(0, 90, 1, 0)
    TabFrame.BackgroundColor3 = TAB_DEFAULT_COLOR
    TabFrame.BorderSizePixel = 0
    TabFrame.LayoutOrder = order

    local tS1 = Instance.new("UIStroke", TabFrame)
    tS1.ZIndex = 0; tS1.Thickness = 2; tS1.LineJoinMode = Enum.LineJoinMode.Miter
    local tS2 = Instance.new("UIStroke", TabFrame)
    tS2.ZIndex = 2; tS2.Color = Color3.fromRGB(64,64,64); tS2.LineJoinMode = Enum.LineJoinMode.Miter

    local TabLabel = Instance.new("TextLabel", TabFrame)
    TabLabel.BackgroundTransparency = 1
    TabLabel.Size = UDim2.new(1, 0, 1, 0)
    TabLabel.Text = name
    TabLabel.TextSize = 12
    TabLabel.TextColor3 = Color3.fromRGB(255,255,255)
    TabLabel.FontFace = Font.new([[rbxasset://fonts/families/Arial.json]])

    -- Content frame for this tab
    local TabContent = Instance.new("Frame", self._ContentArea)
    TabContent.Name = "TabContent_" .. name
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.BorderSizePixel = 0
    TabContent.Visible = false

    -- Invisible button to detect clicks
    local TabBtn = Instance.new("TextButton", TabFrame)
    TabBtn.Size = UDim2.new(1,0,1,0)
    TabBtn.BackgroundTransparency = 1
    TabBtn.Text = ""
    TabBtn.ZIndex = 10

    -- Click logic
    local allTabs    = self._tabs
    local allFrames  = self._tabFrames

    TabBtn.MouseButton1Click:Connect(function()
        -- hide all tabs
        for _, t in ipairs(allTabs) do
            t._Content.Visible = false
            t._Frame.BackgroundColor3 = TAB_DEFAULT_COLOR
        end
        -- show this tab
        TabContent.Visible = true
        TabFrame.BackgroundColor3 = TAB_SELECTED_COLOR
        self._activeTab = tab
        print("Tab selected: " .. name)
    end)

    tab._Frame   = TabFrame
    tab._Content = TabContent
    tab._name    = name
    tab._win     = self

    -- Left groupbox column x offset tracker
    tab._gbLeft  = 0
    tab._gbRight = 0

    table.insert(self._tabs, tab)
    table.insert(self._tabFrames, TabFrame)

    -- Auto-select first tab
    if #self._tabs == 1 then
        TabContent.Visible = true
        TabFrame.BackgroundColor3 = TAB_SELECTED_COLOR
        self._activeTab = tab
    end

    setmetatable(tab, {__index = TabMethods})
    return tab
end

-- ============================================================
-- TAB METHODS
-- ============================================================
TabMethods = {}
TabMethods.__index = TabMethods

function TabMethods:AddGroupbox(name, side)
    -- side: "left" or "right"
    side = side or "left"

    local gb = {}

    local GBWidth  = 155
    local GBStartY = 9
    local padding  = 9

    local xOffset
    if side == "left" then
        xOffset = 9
        self._gbLeftY = self._gbLeftY or GBStartY
    else
        xOffset = 9 + GBWidth + padding
        self._gbRightY = self._gbRightY or GBStartY
    end

    local currentY = (side == "left") and self._gbLeftY or self._gbRightY

    local GBFrame = Instance.new("Frame", self._Content)
    GBFrame.Name = "GroupBox_" .. name
    GBFrame.Size = UDim2.new(0, GBWidth, 0, 40) -- starts small, auto grows
    GBFrame.Position = UDim2.new(0, xOffset, 0, currentY)
    GBFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    GBFrame.BorderSizePixel = 0
    GBFrame.ClipsDescendants = false

    local gbS1 = Instance.new("UIStroke", GBFrame)
    gbS1.ZIndex = 0; gbS1.Thickness = 2; gbS1.Color = Color3.fromRGB(21,21,21)
    gbS1.LineJoinMode = Enum.LineJoinMode.Miter
    local gbS2 = Instance.new("UIStroke", GBFrame)
    gbS2.Color = Color3.fromRGB(57,57,57); gbS2.LineJoinMode = Enum.LineJoinMode.Miter

    -- Top color bar
    local TopBar = Instance.new("Frame", GBFrame)
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, -4, 0, 2)
    TopBar.Position = UDim2.new(0, 2, 0, 0)
    TopBar.BackgroundColor3 = ACCENT_COLOR
    TopBar.BorderSizePixel = 0

    -- Title
    local GBTitle = Instance.new("TextLabel", GBFrame)
    GBTitle.Name = "GBTitle"
    GBTitle.BackgroundTransparency = 1
    GBTitle.Size = UDim2.new(1, 0, 0, 20)
    GBTitle.Position = UDim2.new(0, 4, 0, 2)
    GBTitle.Text = name
    GBTitle.TextSize = 12
    GBTitle.TextColor3 = Color3.fromRGB(255,255,255)
    GBTitle.FontFace = Font.new([[rbxasset://fonts/families/Arial.json]])
    GBTitle.TextXAlignment = Enum.TextXAlignment.Center

    -- Item container (auto layout)
    local ItemList = Instance.new("Frame", GBFrame)
    ItemList.Name = "ItemList"
    ItemList.BackgroundTransparency = 1
    ItemList.BorderSizePixel = 0
    ItemList.Size = UDim2.new(1, 0, 0, 0)
    ItemList.Position = UDim2.new(0, 0, 0, 24)
    ItemList.AutomaticSize = Enum.AutomaticSize.Y

    local ItemLayout = Instance.new("UIListLayout", ItemList)
    ItemLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ItemLayout.Padding = UDim.new(0, 4)
    local ItemPadding = Instance.new("UIPadding", ItemList)
    ItemPadding.PaddingLeft   = UDim.new(0, 8)
    ItemPadding.PaddingRight  = UDim.new(0, 8)
    ItemPadding.PaddingBottom = UDim.new(0, 6)

    -- Auto resize groupbox height
    local function resizeGB()
        local h = ItemList.AbsoluteSize.Y + 30
        GBFrame.Size = UDim2.new(0, GBWidth, 0, h)
    end
    ItemLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resizeGB)

    gb._Frame    = GBFrame
    gb._ItemList = ItemList
    gb._ItemOrder = 0
    gb._side     = side
    gb._tab      = self

    setmetatable(gb, {__index = GroupboxMethods})
    return gb
end

-- ============================================================
-- GROUPBOX METHODS
-- ============================================================
GroupboxMethods = {}
GroupboxMethods.__index = GroupboxMethods

local function makeItemRow(parent, order)
    local row = Instance.new("Frame", parent)
    row.BackgroundTransparency = 1
    row.BorderSizePixel = 0
    row.Size = UDim2.new(1, 0, 0, 20)
    row.LayoutOrder = order
    row.Name = "Row_" .. order
    return row
end

-- TOGGLE
function GroupboxMethods:AddToggle(name, default, callback)
    self._ItemOrder = self._ItemOrder + 1
    local order = self._ItemOrder
    local state = default or false

    local Row = makeItemRow(self._ItemList, order)

    -- Box
    local Box = Instance.new("Frame", Row)
    Box.Size = UDim2.new(0, 12, 0, 12)
    Box.Position = UDim2.new(0, 0, 0.5, -6)
    Box.BackgroundColor3 = state and ACCENT_COLOR or Color3.fromRGB(39,39,39)
    Box.BorderSizePixel = 0

    local bS1 = Instance.new("UIStroke", Box)
    bS1.Thickness = 1.6; bS1.LineJoinMode = Enum.LineJoinMode.Miter
    local bS2 = Instance.new("UIStroke", Box)
    bS2.Color = Color3.fromRGB(64,64,64); bS2.LineJoinMode = Enum.LineJoinMode.Miter

    -- Label
    local Lbl = Instance.new("TextLabel", Row)
    Lbl.BackgroundTransparency = 1
    Lbl.Size = UDim2.new(1, -18, 1, 0)
    Lbl.Position = UDim2.new(0, 18, 0, 0)
    Lbl.Text = name
    Lbl.TextSize = 12
    Lbl.TextColor3 = Color3.fromRGB(255,255,255)
    Lbl.FontFace = Font.new([[rbxasset://fonts/families/Arial.json]])
    Lbl.TextXAlignment = Enum.TextXAlignment.Left

    -- Button
    local Btn = Instance.new("TextButton", Row)
    Btn.Size = UDim2.new(1,0,1,0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.ZIndex = 10
    Btn.AutoButtonColor = false

    Btn.MouseButton1Click:Connect(function()
        state = not state
        Box.BackgroundColor3 = state and ACCENT_COLOR or Color3.fromRGB(39,39,39)
        print(name .. " Toggle: " .. tostring(state))
        if callback then callback(state) end
    end)

    return {
        GetValue = function() return state end,
        SetValue = function(v)
            state = v
            Box.BackgroundColor3 = state and ACCENT_COLOR or Color3.fromRGB(39,39,39)
            if callback then callback(state) end
        end
    }
end

-- BUTTON
function GroupboxMethods:AddButton(name, callback)
    self._ItemOrder = self._ItemOrder + 1
    local order = self._ItemOrder

    local Row = makeItemRow(self._ItemList, order)

    local BtnFrame = Instance.new("Frame", Row)
    BtnFrame.Size = UDim2.new(1, 0, 1, 0)
    BtnFrame.BackgroundColor3 = Color3.fromRGB(39,39,39)
    BtnFrame.BorderSizePixel = 0

    local bS1 = Instance.new("UIStroke", BtnFrame)
    bS1.Thickness = 1.6; bS1.LineJoinMode = Enum.LineJoinMode.Miter
    local bS2 = Instance.new("UIStroke", BtnFrame)
    bS2.Color = Color3.fromRGB(64,64,64); bS2.LineJoinMode = Enum.LineJoinMode.Miter

    local BtnLbl = Instance.new("TextLabel", BtnFrame)
    BtnLbl.BackgroundTransparency = 1
    BtnLbl.Size = UDim2.new(1,0,1,0)
    BtnLbl.Text = name
    BtnLbl.TextSize = 12
    BtnLbl.TextColor3 = Color3.fromRGB(255,255,255)
    BtnLbl.FontFace = Font.new([[rbxasset://fonts/families/Arial.json]])

    local Btn = Instance.new("TextButton", BtnFrame)
    Btn.Size = UDim2.new(1,0,1,0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.ZIndex = 10
    Btn.AutoButtonColor = false

    Btn.MouseButton1Click:Connect(function()
        print(name .. " Button pressed!")
        if callback then callback() end
    end)
end

-- SLIDER
function GroupboxMethods:AddSlider(name, min, max, default, callback)
    self._ItemOrder = self._ItemOrder + 1
    local order = self._ItemOrder
    local value = default or min
    local dragging = false

    -- Label row
    local LabelRow = makeItemRow(self._ItemList, order)
    LabelRow.Size = UDim2.new(1, 0, 0, 14)

    local NameLbl = Instance.new("TextLabel", LabelRow)
    NameLbl.BackgroundTransparency = 1
    NameLbl.Size = UDim2.new(0.6, 0, 1, 0)
    NameLbl.Text = name
    NameLbl.TextSize = 12
    NameLbl.TextColor3 = Color3.fromRGB(255,255,255)
    NameLbl.FontFace = Font.new([[rbxasset://fonts/families/Arial.json]])
    NameLbl.TextXAlignment = Enum.TextXAlignment.Left

    local ValLbl = Instance.new("TextLabel", LabelRow)
    ValLbl.BackgroundTransparency = 1
    ValLbl.Size = UDim2.new(0.4, 0, 1, 0)
    ValLbl.Position = UDim2.new(0.6, 0, 0, 0)
    ValLbl.Text = value .. "/" .. max
    ValLbl.TextSize = 12
    ValLbl.TextColor3 = Color3.fromRGB(255,255,255)
    ValLbl.FontFace = Font.new([[rbxasset://fonts/families/Arial.json]])
    ValLbl.TextXAlignment = Enum.TextXAlignment.Right

    -- Slider row
    self._ItemOrder = self._ItemOrder + 1
    local SliderRow = makeItemRow(self._ItemList, self._ItemOrder)
    SliderRow.Size = UDim2.new(1, 0, 0, 5)

    local Track = Instance.new("Frame", SliderRow)
    Track.Size = UDim2.new(1, 0, 1, 0)
    Track.BackgroundColor3 = Color3.fromRGB(39,39,39)
    Track.BorderSizePixel = 0

    local tS1 = Instance.new("UIStroke", Track)
    tS1.Thickness = 1.6; tS1.LineJoinMode = Enum.LineJoinMode.Miter
    local tS2 = Instance.new("UIStroke", Track)
    tS2.Color = Color3.fromRGB(64,64,64); tS2.LineJoinMode = Enum.LineJoinMode.Miter

    local Fill = Instance.new("Frame", Track)
    Fill.BackgroundColor3 = ACCENT_COLOR
    Fill.BorderSizePixel = 0
    local rel = (value - min) / (max - min)
    Fill.Size = UDim2.new(rel, 0, 1, 0)

    local function updateSlider(x)
        local ap = Track.AbsolutePosition.X
        local as = Track.AbsoluteSize.X
        local r  = math.clamp((x - ap) / as, 0, 1)
        value = math.floor(r * (max - min) + min)
        Fill.Size = UDim2.new(r, 0, 1, 0)
        ValLbl.Text = value .. "/" .. max
        print(name .. " Slider: " .. value)
        if callback then callback(value) end
    end

    local SliderBtn = Instance.new("TextButton", Track)
    SliderBtn.Size = UDim2.new(1, 0, 1, 16)
    SliderBtn.Position = UDim2.new(0, 0, 0, -8)
    SliderBtn.BackgroundTransparency = 1
    SliderBtn.Text = ""
    SliderBtn.ZIndex = 10
    SliderBtn.AutoButtonColor = false

    SliderBtn.MouseButton1Down:Connect(function(x)
        dragging = true
        updateSlider(x)
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input.Position.X)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    return {
        GetValue = function() return value end,
        SetValue = function(v)
            value = math.clamp(v, min, max)
            local r = (value - min)/(max - min)
            Fill.Size = UDim2.new(r, 0, 1, 0)
            ValLbl.Text = value .. "/" .. max
            if callback then callback(value) end
        end
    }
end

-- LABEL
function GroupboxMethods:AddLabel(text)
    self._ItemOrder = self._ItemOrder + 1
    local order = self._ItemOrder

    local Row = makeItemRow(self._ItemList, order)

    local Lbl = Instance.new("TextLabel", Row)
    Lbl.BackgroundTransparency = 1
    Lbl.Size = UDim2.new(1,0,1,0)
    Lbl.Text = text
    Lbl.TextSize = 12
    Lbl.TextColor3 = Color3.fromRGB(200,200,200)
    Lbl.FontFace = Font.new([[rbxasset://fonts/families/Arial.json]])
    Lbl.TextXAlignment = Enum.TextXAlignment.Left

    return {
        SetText = function(t) Lbl.Text = t end
    }
end

-- DROPDOWN
function GroupboxMethods:AddDropdown(name, options, default, callback)
    self._ItemOrder = self._ItemOrder + 1
    local order = self._ItemOrder
    local selected = default or "none"
    local open = false

    local ITEM_HEIGHT  = 18
    local MAX_VISIBLE  = 3

    -- Label row
    local LabelRow = makeItemRow(self._ItemList, order)
    LabelRow.Size = UDim2.new(1, 0, 0, 14)

    local NameLbl = Instance.new("TextLabel", LabelRow)
    NameLbl.BackgroundTransparency = 1
    NameLbl.Size = UDim2.new(1,0,1,0)
    NameLbl.Text = name
    NameLbl.TextSize = 12
    NameLbl.TextColor3 = Color3.fromRGB(255,255,255)
    NameLbl.FontFace = Font.new([[rbxasset://fonts/families/Arial.json]])
    NameLbl.TextXAlignment = Enum.TextXAlignment.Left

    -- Dropdown row
    self._ItemOrder = self._ItemOrder + 1
    local DDRow = makeItemRow(self._ItemList, self._ItemOrder)
    DDRow.Size = UDim2.new(1, 0, 0, 17)
    DDRow.ZIndex = 20
    DDRow.ClipsDescendants = false

    local DDFrame = Instance.new("Frame", DDRow)
    DDFrame.Size = UDim2.new(1, 0, 1, 0)
    DDFrame.BackgroundColor3 = Color3.fromRGB(39,39,39)
    DDFrame.BorderSizePixel = 0
    DDFrame.ZIndex = 20
    DDFrame.ClipsDescendants = false

    local dS1 = Instance.new("UIStroke", DDFrame)
    dS1.Thickness = 1.6; dS1.LineJoinMode = Enum.LineJoinMode.Miter
    local dS2 = Instance.new("UIStroke", DDFrame)
    dS2.Color = Color3.fromRGB(64,64,64); dS2.LineJoinMode = Enum.LineJoinMode.Miter

    local SelLbl = Instance.new("TextLabel", DDFrame)
    SelLbl.BackgroundTransparency = 1
    SelLbl.Size = UDim2.new(1, -16, 1, 0)
    SelLbl.Position = UDim2.new(0, 4, 0, 0)
    SelLbl.Text = selected
    SelLbl.TextSize = 12
    SelLbl.TextColor3 = Color3.fromRGB(255,255,255)
    SelLbl.FontFace = Font.new([[rbxasset://fonts/families/Arial.json]])
    SelLbl.TextXAlignment = Enum.TextXAlignment.Left
    SelLbl.ZIndex = 21

    local ArrowLbl = Instance.new("TextLabel", DDFrame)
    ArrowLbl.BackgroundTransparency = 1
    ArrowLbl.Size = UDim2.new(0, 14, 1, 0)
    ArrowLbl.Position = UDim2.new(1, -16, 0, 0)
    ArrowLbl.Text = "v"
    ArrowLbl.TextSize = 10
    ArrowLbl.TextColor3 = Color3.fromRGB(180,180,180)
    ArrowLbl.FontFace = Font.new([[rbxasset://fonts/families/Arial.json]])
    ArrowLbl.ZIndex = 21

    -- List container
    local ListContainer = Instance.new("Frame", DDFrame)
    ListContainer.Name = "DropdownList"
    ListContainer.ZIndex = 50
    ListContainer.BorderSizePixel = 0
    ListContainer.BackgroundColor3 = Color3.fromRGB(39,39,39)
    ListContainer.Size = UDim2.new(1, 0, 0, math.min(#options, MAX_VISIBLE) * ITEM_HEIGHT)
    ListContainer.Position = UDim2.new(0, 0, 1, 2)
    ListContainer.ClipsDescendants = true
    ListContainer.Visible = false

    local lcS = Instance.new("UIStroke", ListContainer)
    lcS.Color = Color3.fromRGB(64,64,64); lcS.Thickness = 1.6
    lcS.LineJoinMode = Enum.LineJoinMode.Miter; lcS.ZIndex = 51

    local Scroll = Instance.new("ScrollingFrame", ListContainer)
    Scroll.Size = UDim2.new(1,0,1,0)
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.ScrollBarThickness = 3
    Scroll.ScrollBarImageColor3 = ACCENT_COLOR
    Scroll.ZIndex = 52
    Scroll.CanvasSize = UDim2.new(0,0,0,0)
    Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local ScrollLayout = Instance.new("UIListLayout", Scroll)
    ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ScrollLayout.Padding = UDim.new(0,0)

    for i, opt in ipairs(options) do
        local ItemBtn = Instance.new("TextButton", Scroll)
        ItemBtn.Name = "Item_" .. opt
        ItemBtn.Size = UDim2.new(1, 0, 0, ITEM_HEIGHT)
        ItemBtn.BackgroundColor3 = Color3.fromRGB(39,39,39)
        ItemBtn.BorderSizePixel = 0
        ItemBtn.Text = opt
        ItemBtn.TextSize = 12
        ItemBtn.TextColor3 = Color3.fromRGB(255,255,255)
        ItemBtn.FontFace = Font.new([[rbxasset://fonts/families/Arial.json]])
        ItemBtn.ZIndex = 53
        ItemBtn.LayoutOrder = i
        ItemBtn.AutoButtonColor = false

        ItemBtn.MouseEnter:Connect(function()
            ItemBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
        end)
        ItemBtn.MouseLeave:Connect(function()
            ItemBtn.BackgroundColor3 = Color3.fromRGB(39,39,39)
        end)
        ItemBtn.MouseButton1Click:Connect(function()
            selected = opt
            SelLbl.Text = opt
            open = false
            ArrowLbl.Text = "v"
            ListContainer.Visible = false
            print(name .. " Dropdown selected: " .. opt)
            if callback then callback(opt) end
        end)
    end

    -- Toggle button
    local DDBtn = Instance.new("TextButton", DDFrame)
    DDBtn.Size = UDim2.new(1,0,1,0)
    DDBtn.BackgroundTransparency = 1
    DDBtn.Text = ""
    DDBtn.ZIndex = 55
    DDBtn.AutoButtonColor = false

    DDBtn.MouseButton1Click:Connect(function()
        open = not open
        ArrowLbl.Text = open and "^" or "v"
        ListContainer.Visible = open
        print(name .. " Dropdown " .. (open and "opened" or "closed"))
    end)

    return {
        GetValue = function() return selected end,
        SetValue = function(v)
            selected = v
            SelLbl.Text = v
            if callback then callback(v) end
        end
    }
end

return Library
