-- Library.lua
local Library = {}
Library.__index = Library

local UIS = game:GetService("UserInputService")
local ACCENT_COLOR = Color3.fromRGB(0, 214, 255)
local TAB_SELECTED_COLOR = Color3.fromRGB(30, 30, 30)
local TAB_DEFAULT_COLOR  = Color3.fromRGB(30, 30, 30)

function Library:CreateWindow(title)
    local G2L = {}
    
    -- ScreenGui
    G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
    G2L["1"]["Name"] = "kiciav2uiexample"
    G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
    
    -- Main
    G2L["2"] = Instance.new("Frame", G2L["1"])
    G2L["2"]["BorderSizePixel"] = 0
    G2L["2"]["BackgroundColor3"] = Color3.fromRGB(32, 32, 32)
    G2L["2"]["Size"] = UDim2.new(0, 400, 0, 437)
    G2L["2"]["Position"] = UDim2.new(0.34232, 0, 0.14576, 0)
    G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["2"]["Name"] = "Main"
    
    -- MainUIStroke
    G2L["38"] = Instance.new("UIStroke", G2L["2"])
    G2L["38"]["Thickness"] = 0.51
    G2L["38"]["Color"] = Color3.fromRGB(0, 214, 255)
    G2L["38"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    G2L["38"]["Name"] = "MainUIStroke"
    
    -- MainUINameUI
    G2L["39"] = Instance.new("TextLabel", G2L["2"])
    G2L["39"]["BorderSizePixel"] = 0
    G2L["39"]["TextSize"] = 12
    G2L["39"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["39"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    G2L["39"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["39"]["BackgroundTransparency"] = 1
    G2L["39"]["Size"] = UDim2.new(0, 84, 0, 21)
    G2L["39"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["39"]["Text"] = title
    G2L["39"]["Name"] = "MainUINameUI"
    G2L["39"]["Position"] = UDim2.new(0.02503, 0, 0, 0)
    
    -- Drag functionality
    local dragging, dragStart, startPos = false, nil, nil
    G2L["39"].InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = G2L["2"].Position
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            G2L["2"].Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Group
    G2L["3"] = Instance.new("Frame", G2L["2"])
    G2L["3"]["BorderSizePixel"] = 0
    G2L["3"]["BackgroundColor3"] = Color3.fromRGB(30, 30, 30)
    G2L["3"]["Size"] = UDim2.new(0, 379, 0, 400)
    G2L["3"]["Position"] = UDim2.new(0.02503, 0, 0.05361, 0)
    G2L["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["3"]["Name"] = "Group"
    
    G2L["4"] = Instance.new("UIStroke", G2L["3"])
    G2L["4"]["Name"] = "GroupUIStroke1"
    
    G2L["5"] = Instance.new("UIStroke", G2L["3"])
    G2L["5"]["ZIndex"] = 0
    G2L["5"]["Thickness"] = 2
    G2L["5"]["Color"] = Color3.fromRGB(58, 58, 58)
    G2L["5"]["Name"] = "GroupUIStroke2"
    
    -- Tab1
    G2L["2c"] = Instance.new("Frame", G2L["3"])
    G2L["2c"]["BorderSizePixel"] = 0
    G2L["2c"]["BackgroundColor3"] = Color3.fromRGB(30, 30, 30)
    G2L["2c"]["Size"] = UDim2.new(0, 90, 0, 20)
    G2L["2c"]["Position"] = UDim2.new(0.02639, 0, 0.02, 0)
    G2L["2c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["2c"]["Name"] = "Tab1"
    
    G2L["2d"] = Instance.new("UIStroke", G2L["2c"])
    G2L["2d"]["ZIndex"] = 0
    G2L["2d"]["Thickness"] = 2
    G2L["2d"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    
    G2L["2e"] = Instance.new("UIStroke", G2L["2c"])
    G2L["2e"]["ZIndex"] = 2
    G2L["2e"]["Color"] = Color3.fromRGB(64, 64, 64)
    G2L["2e"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    
    G2L["2f"] = Instance.new("TextLabel", G2L["2c"])
    G2L["2f"]["BorderSizePixel"] = 0
    G2L["2f"]["TextSize"] = 12
    G2L["2f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["2f"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    G2L["2f"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["2f"]["BackgroundTransparency"] = 1
    G2L["2f"]["Size"] = UDim2.new(0, 50, 0, 13)
    G2L["2f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["2f"]["Text"] = "Main"
    G2L["2f"]["Position"] = UDim2.new(0.21772, 0, 0.15, 0)
    
    -- Tab2
    G2L["30"] = Instance.new("Frame", G2L["3"])
    G2L["30"]["BorderSizePixel"] = 0
    G2L["30"]["BackgroundColor3"] = Color3.fromRGB(30, 30, 30)
    G2L["30"]["Size"] = UDim2.new(0, 90, 0, 20)
    G2L["30"]["Position"] = UDim2.new(0.28496, 0, 0.02, 0)
    G2L["30"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["30"]["Name"] = "Tab2"
    
    G2L["31"] = Instance.new("TextLabel", G2L["30"])
    G2L["31"]["BorderSizePixel"] = 0
    G2L["31"]["TextSize"] = 12
    G2L["31"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["31"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    G2L["31"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["31"]["BackgroundTransparency"] = 1
    G2L["31"]["Size"] = UDim2.new(0, 50, 0, 13)
    G2L["31"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["31"]["Text"] = "Visuals"
    G2L["31"]["Position"] = UDim2.new(0.21772, 0, 0.15, 0)
    
    G2L["32"] = Instance.new("UIStroke", G2L["30"])
    G2L["32"]["ZIndex"] = 2
    G2L["32"]["Color"] = Color3.fromRGB(64, 64, 64)
    G2L["32"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    
    G2L["33"] = Instance.new("UIStroke", G2L["30"])
    G2L["33"]["ZIndex"] = 0
    G2L["33"]["Thickness"] = 2
    G2L["33"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    
    -- Tab3
    G2L["34"] = Instance.new("Frame", G2L["3"])
    G2L["34"]["BorderSizePixel"] = 0
    G2L["34"]["BackgroundColor3"] = Color3.fromRGB(30, 30, 30)
    G2L["34"]["Size"] = UDim2.new(0, 90, 0, 20)
    G2L["34"]["Position"] = UDim2.new(0.5409, 0, 0.02, 0)
    G2L["34"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["34"]["Name"] = "Tab3"
    
    G2L["35"] = Instance.new("UIStroke", G2L["34"])
    G2L["35"]["ZIndex"] = 2
    G2L["35"]["Color"] = Color3.fromRGB(64, 64, 64)
    G2L["35"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    
    G2L["36"] = Instance.new("TextLabel", G2L["34"])
    G2L["36"]["BorderSizePixel"] = 0
    G2L["36"]["TextSize"] = 12
    G2L["36"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["36"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    G2L["36"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["36"]["BackgroundTransparency"] = 1
    G2L["36"]["Size"] = UDim2.new(0, 50, 0, 13)
    G2L["36"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["36"]["Text"] = "Misc"
    G2L["36"]["Position"] = UDim2.new(0.21772, 0, 0.15, 0)
    
    G2L["37"] = Instance.new("UIStroke", G2L["34"])
    G2L["37"]["ZIndex"] = 0
    G2L["37"]["Thickness"] = 2
    G2L["37"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    
    -- Tab selection logic
    local tabs = {G2L["2c"], G2L["30"], G2L["34"]}
    for _, tab in ipairs(tabs) do
        local btn = Instance.new("TextButton", tab)
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.ZIndex = 10
        btn.MouseButton1Click:Connect(function()
            for _, t in ipairs(tabs) do
                t.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            end
            tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            print("Tab selected:", tab:FindFirstChildOfClass("TextLabel").Text)
        end)
    end
    
    -- MainGroupBoxes
    G2L["6"] = Instance.new("Frame", G2L["3"])
    G2L["6"]["ZIndex"] = 999999999
    G2L["6"]["BorderSizePixel"] = 0
    G2L["6"]["BackgroundColor3"] = Color3.fromRGB(39, 39, 39)
    G2L["6"]["Size"] = UDim2.new(0, 357, 0, 358)
    G2L["6"]["Position"] = UDim2.new(0.02739, 0, 0.07122, 0)
    G2L["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["6"]["Name"] = "MainGroupBoxes"
    
    G2L["7"] = Instance.new("UIStroke", G2L["6"])
    G2L["7"]["ZIndex"] = 3123
    G2L["7"]["Name"] = "MainGroupBoxesUIStroke1"
    
    G2L["8"] = Instance.new("UIStroke", G2L["6"])
    G2L["8"]["ZIndex"] = 0
    G2L["8"]["Thickness"] = 2
    G2L["8"]["Color"] = Color3.fromRGB(58, 58, 58)
    G2L["8"]["Name"] = "MainGroupBoxesUIStroke2"
    
    -- GroupBox1
    G2L["9"] = Instance.new("Frame", G2L["6"])
    G2L["9"]["BorderSizePixel"] = 0
    G2L["9"]["BackgroundColor3"] = Color3.fromRGB(30, 30, 30)
    G2L["9"]["Size"] = UDim2.new(0, 155, 0, 111)
    G2L["9"]["Position"] = UDim2.new(0.02609, 0, 0.04852, 0)
    G2L["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["9"]["Name"] = "GroupBox1"
    
    G2L["a"] = Instance.new("UIStroke", G2L["9"])
    G2L["a"]["ZIndex"] = 0
    G2L["a"]["Thickness"] = 2
    G2L["a"]["Color"] = Color3.fromRGB(21, 21, 21)
    G2L["a"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    G2L["a"]["Name"] = "GroupBox1UIStroke"
    
    G2L["b"] = Instance.new("Frame", G2L["9"])
    G2L["b"]["BorderSizePixel"] = 0
    G2L["b"]["BackgroundColor3"] = Color3.fromRGB(0, 194, 228)
    G2L["b"]["Size"] = UDim2.new(0, 152, 0, 2)
    G2L["b"]["Position"] = UDim2.new(0.01318, 0, 0, 0)
    G2L["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["b"]["Name"] = "GroupBoxTop"
    
    G2L["c"] = Instance.new("TextLabel", G2L["9"])
    G2L["c"]["BorderSizePixel"] = 0
    G2L["c"]["TextSize"] = 12
    G2L["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["c"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    G2L["c"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["c"]["BackgroundTransparency"] = 1
    G2L["c"]["Size"] = UDim2.new(0, 86, 0, 22)
    G2L["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["c"]["Text"] = "groupbox"
    G2L["c"]["Name"] = "GroupBox1Text"
    G2L["c"]["Position"] = UDim2.new(0.21862, 0, 0.01802, 0)
    
    G2L["d"] = Instance.new("UIStroke", G2L["9"])
    G2L["d"]["Color"] = Color3.fromRGB(57, 57, 57)
    G2L["d"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    G2L["d"]["Name"] = "GroupBox1UIStroke2"
    
    -- Toggle
    local toggleState = false
    G2L["e"] = Instance.new("Frame", G2L["9"])
    G2L["e"]["BorderSizePixel"] = 0
    G2L["e"]["BackgroundColor3"] = Color3.fromRGB(39, 39, 39)
    G2L["e"]["Size"] = UDim2.new(0, 12, 0, 12)
    G2L["e"]["Position"] = UDim2.new(0.10323, 0, 0.30631, 0)
    G2L["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["e"]["Name"] = "Toggle"
    
    G2L["f"] = Instance.new("UIStroke", G2L["e"])
    G2L["f"]["ZIndex"] = 0
    G2L["f"]["Thickness"] = 1.6
    G2L["f"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    
    G2L["10"] = Instance.new("UIStroke", G2L["e"])
    G2L["10"]["Color"] = Color3.fromRGB(64, 64, 64)
    G2L["10"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    
    G2L["11"] = Instance.new("TextLabel", G2L["e"])
    G2L["11"]["BorderSizePixel"] = 0
    G2L["11"]["TextSize"] = 12
    G2L["11"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["11"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    G2L["11"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["11"]["BackgroundTransparency"] = 1
    G2L["11"]["Size"] = UDim2.new(0, 45, 0, 18)
    G2L["11"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["11"]["Text"] = "Toggle"
    G2L["11"]["Position"] = UDim2.new(0.96666, 0, -0.3, 0)
    
    local toggleBtn = Instance.new("TextButton", G2L["e"])
    toggleBtn.Size = UDim2.new(1, 0, 1, 0)
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Text = ""
    toggleBtn.ZIndex = 10
    toggleBtn.MouseButton1Click:Connect(function()
        toggleState = not toggleState
        G2L["e"].BackgroundColor3 = toggleState and ACCENT_COLOR or Color3.fromRGB(39, 39, 39)
        print("Toggle:", toggleState)
    end)
    
    -- Slider
    local sliderValue = 0
    local sliderDragging = false
    G2L["12"] = Instance.new("Frame", G2L["9"])
    G2L["12"]["BorderSizePixel"] = 0
    G2L["12"]["BackgroundColor3"] = Color3.fromRGB(39, 39, 39)
    G2L["12"]["Size"] = UDim2.new(0, 121, 0, 8)
    G2L["12"]["Position"] = UDim2.new(0.10323, 0, 0.67568, 0)
    G2L["12"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["12"]["Name"] = "Slider"
    
    G2L["13"] = Instance.new("UIStroke", G2L["12"])
    G2L["13"]["ZIndex"] = 0
    G2L["13"]["Thickness"] = 1.6
    G2L["13"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    
    G2L["14"] = Instance.new("UIStroke", G2L["12"])
    G2L["14"]["Color"] = Color3.fromRGB(64, 64, 64)
    G2L["14"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    
    -- Slider fill
    local sliderFill = Instance.new("Frame", G2L["12"])
    sliderFill.BorderSizePixel = 0
    sliderFill.BackgroundColor3 = ACCENT_COLOR
    sliderFill.Size = UDim2.new(0, 0, 1, 0)
    sliderFill.Name = "Fill"
    
    G2L["15"] = Instance.new("TextLabel", G2L["12"])
    G2L["15"]["BorderSizePixel"] = 0
    G2L["15"]["TextSize"] = 12
    G2L["15"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["15"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    G2L["15"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["15"]["BackgroundTransparency"] = 1
    G2L["15"]["Size"] = UDim2.new(0, 45, 0, 18)
    G2L["15"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["15"]["Text"] = "0/100"
    G2L["15"]["Position"] = UDim2.new(0.62782, 0, -2.6, 0)
    
    G2L["16"] = Instance.new("TextLabel", G2L["12"])
    G2L["16"]["BorderSizePixel"] = 0
    G2L["16"]["TextSize"] = 12
    G2L["16"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["16"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    G2L["16"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["16"]["BackgroundTransparency"] = 1
    G2L["16"]["Size"] = UDim2.new(0, 45, 0, 18)
    G2L["16"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["16"]["Text"] = "Slider"
    G2L["16"]["Position"] = UDim2.new(0.25592, 0, -2.6, 0)
    
    local function updateSlider(x)
        local absPos = G2L["12"].AbsolutePosition.X
        local absSize = G2L["12"].AbsoluteSize.X
        local rel = math.clamp((x - absPos) / absSize, 0, 1)
        sliderValue = math.floor(rel * 100)
        sliderFill.Size = UDim2.new(rel, 0, 1, 0)
        G2L["15"].Text = sliderValue .. "/100"
        print("Slider:", sliderValue)
    end
    
    local sliderBtn = Instance.new("TextButton", G2L["12"])
    sliderBtn.Size = UDim2.new(1, 0, 1, 16)
    sliderBtn.Position = UDim2.new(0, 0, 0, -8)
    sliderBtn.BackgroundTransparency = 1
    sliderBtn.Text = ""
    sliderBtn.ZIndex = 10
    sliderBtn.MouseButton1Down:Connect(function(x)
        sliderDragging = true
        updateSlider(x)
    end)
    
    UIS.InputChanged:Connect(function(input)
        if sliderDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input.Position.X)
        end
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliderDragging = false
        end
    end)
    
    -- GroupBox2
    G2L["17"] = Instance.new("Frame", G2L["6"])
    G2L["17"]["BorderSizePixel"] = 0
    G2L["17"]["BackgroundColor3"] = Color3.fromRGB(30, 30, 30)
    G2L["17"]["Size"] = UDim2.new(0, 155, 0, 225)
    G2L["17"]["Position"] = UDim2.new(0.52189, 0, 0.04852, 0)
    G2L["17"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["17"]["Name"] = "GroupBox2"
    
    G2L["18"] = Instance.new("Frame", G2L["17"])
    G2L["18"]["BorderSizePixel"] = 0
    G2L["18"]["BackgroundColor3"] = Color3.fromRGB(0, 194, 228)
    G2L["18"]["Size"] = UDim2.new(0, 152, 0, 2)
    G2L["18"]["Position"] = UDim2.new(0.01318, 0, 0, 0)
    G2L["18"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["18"]["Name"] = "GroupBox2Top"
    
    G2L["19"] = Instance.new("TextLabel", G2L["17"])
    G2L["19"]["BorderSizePixel"] = 0
    G2L["19"]["TextSize"] = 12
    G2L["19"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["19"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    G2L["19"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["19"]["BackgroundTransparency"] = 1
    G2L["19"]["Size"] = UDim2.new(0, 86, 0, 22)
    G2L["19"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["19"]["Text"] = "groupbox2"
    G2L["19"]["Name"] = "GroupBox2Text"
    G2L["19"]["Position"] = UDim2.new(0.21862, 0, 0.01802, 0)
    
    G2L["1a"] = Instance.new("UIStroke", G2L["17"])
    G2L["1a"]["ZIndex"] = 0
    G2L["1a"]["Thickness"] = 2
    G2L["1a"]["Color"] = Color3.fromRGB(21, 21, 21)
    G2L["1a"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    G2L["1a"]["Name"] = "GroupBox2UIStroke"
    
    G2L["1b"] = Instance.new("UIStroke", G2L["17"])
    G2L["1b"]["Color"] = Color3.fromRGB(57, 57, 57)
    G2L["1b"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    G2L["1b"]["Name"] = "GroupBox2UIStroke2"
    
    -- Button
    G2L["1c"] = Instance.new("Frame", G2L["17"])
    G2L["1c"]["BorderSizePixel"] = 0
    G2L["1c"]["BackgroundColor3"] = Color3.fromRGB(39, 39, 39)
    G2L["1c"]["Size"] = UDim2.new(0, 135, 0, 17)
    G2L["1c"]["Position"] = UDim2.new(0.05359, 0, 0.13742, 0)
    G2L["1c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["1c"]["Name"] = "Button"
    
    G2L["1d"] = Instance.new("UIStroke", G2L["1c"])
    G2L["1d"]["ZIndex"] = 0
    G2L["1d"]["Thickness"] = 1.6
    G2L["1d"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    
    G2L["1e"] = Instance.new("UIStroke", G2L["1c"])
    G2L["1e"]["Color"] = Color3.fromRGB(64, 64, 64)
    G2L["1e"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    
    G2L["1f"] = Instance.new("TextLabel", G2L["1c"])
    G2L["1f"]["BorderSizePixel"] = 0
    G2L["1f"]["TextSize"] = 12
    G2L["1f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["1f"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    G2L["1f"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["1f"]["BackgroundTransparency"] = 1
    G2L["1f"]["Size"] = UDim2.new(0, 45, 0, 18)
    G2L["1f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["1f"]["Text"] = "Button"
    G2L["1f"]["Position"] = UDim2.new(0.34444, 0, -0.00588, 0)
    
    local buttonBtn = Instance.new("TextButton", G2L["1c"])
    buttonBtn.Size = UDim2.new(1, 0, 1, 0)
    buttonBtn.BackgroundTransparency = 1
    buttonBtn.Text = ""
    buttonBtn.ZIndex = 10
    buttonBtn.MouseButton1Click:Connect(function()
        print("Button pressed!")
    end)
    
    -- Label
    G2L["20"] = Instance.new("TextLabel", G2L["17"])
    G2L["20"]["BorderSizePixel"] = 0
    G2L["20"]["TextSize"] = 12
    G2L["20"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["20"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    G2L["20"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["20"]["BackgroundTransparency"] = 1
    G2L["20"]["Size"] = UDim2.new(0, 45, 0, 18)
    G2L["20"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["20"]["Text"] = "This is a label"
    G2L["20"]["Name"] = "Label"
    G2L["20"]["Position"] = UDim2.new(0.35735, 0, 0.30078, 0)
    
    -- Dropdown
    local dropdownOpen = false
    local selectedOption = "none"
    
    G2L["21"] = Instance.new("Frame", G2L["17"])
    G2L["21"]["ZIndex"] = 99999999
    G2L["21"]["BorderSizePixel"] = 0
    G2L["21"]["BackgroundColor3"] = Color3.fromRGB(39, 39, 39)
    G2L["21"]["Size"] = UDim2.new(0, 135, 0, 17)
    G2L["21"]["Position"] = UDim2.new(0.05359, 0, 0.46186, 0)
    G2L["21"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["21"]["Name"] = "Dropdown"
    G2L["21"]["ClipsDescendants"] = false
    
    G2L["22"] = Instance.new("UIStroke", G2L["21"])
    G2L["22"]["ZIndex"] = 0
    G2L["22"]["Thickness"] = 1.6
    G2L["22"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    
    G2L["23"] = Instance.new("UIStroke", G2L["21"])
    G2L["23"]["Color"] = Color3.fromRGB(64, 64, 64)
    G2L["23"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    
    G2L["24"] = Instance.new("TextLabel", G2L["21"])
    G2L["24"]["BorderSizePixel"] = 0
    G2L["24"]["TextSize"] = 12
    G2L["24"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["24"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    G2L["24"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["24"]["BackgroundTransparency"] = 1
    G2L["24"]["Size"] = UDim2.new(0, 45, 0, 18)
    G2L["24"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["24"]["Text"] = "none"
    G2L["24"]["Position"] = UDim2.new(0.34444, 0, -0.06235, 0)
    G2L["24"]["ZIndex"] = 99999999
    
    -- DropdownSelected
    G2L["25"] = Instance.new("Frame", G2L["21"])
    G2L["25"]["ZIndex"] = 99999999
    G2L["25"]["BorderSizePixel"] = 0
    G2L["25"]["BackgroundColor3"] = Color3.fromRGB(39, 39, 39)
    G2L["25"]["Size"] = UDim2.new(0, 135, 0, 54)
    G2L["25"]["Position"] = UDim2.new(-0.00567, 0, 1.10892, 0)
    G2L["25"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["25"]["Name"] = "DropdownSelected"
    G2L["25"]["Visible"] = false
    G2L["25"]["ClipsDescendants"] = true
    
    G2L["26"] = Instance.new("UIStroke", G2L["25"])
    G2L["26"]["ZIndex"] = 99999999
    G2L["26"]["Thickness"] = 1.6
    G2L["26"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    
    G2L["27"] = Instance.new("UIStroke", G2L["25"])
    G2L["27"]["ZIndex"] = 99999998
    G2L["27"]["Color"] = Color3.fromRGB(64, 64, 64)
    G2L["27"]["LineJoinMode"] = Enum.LineJoinMode.Miter
    
    local scroll = Instance.new("ScrollingFrame", G2L["25"])
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3
    scroll.ScrollBarImageColor3 = ACCENT_COLOR
    scroll.ZIndex = 99999999
    scroll.CanvasSize = UDim2.new(0, 0, 0, 72)
    
    G2L["2b"] = Instance.new("UIListLayout", scroll)
    G2L["2b"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center
    G2L["2b"]["SortOrder"] = Enum.SortOrder.LayoutOrder
    G2L["2b"]["ItemLineAlignment"] = Enum.ItemLineAlignment.Center
    
    local options = {"1", "2", "3", "4"}
    for i, opt in ipairs(options) do
        local optLabel = Instance.new("TextLabel", scroll)
        optLabel.BorderSizePixel = 0
        optLabel.TextSize = 12
        optLabel.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
        optLabel.FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        optLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        optLabel.BackgroundTransparency = 1
        optLabel.Size = UDim2.new(0, 45, 0, 18)
        optLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        optLabel.Text = opt
        optLabel.ZIndex = 99999999
        optLabel.LayoutOrder = i
        
        local optBtn = Instance.new("TextButton", optLabel)
        optBtn.Size = UDim2.new(1, 0, 1, 0)
        optBtn.BackgroundTransparency = 1
        optBtn.Text = ""
        optBtn.ZIndex = 99999999
        optBtn.MouseButton1Click:Connect(function()
            selectedOption = opt
            G2L["24"].Text = opt
            dropdownOpen = false
            G2L["25"].Visible = false
            print("Selected:", opt)
        end)
    end
    
    local ddBtn = Instance.new("TextButton", G2L["21"])
    ddBtn.Size = UDim2.new(1, 0, 1, 0)
    ddBtn.BackgroundTransparency = 1
    ddBtn.Text = ""
    ddBtn.ZIndex = 99999999
    ddBtn.MouseButton1Click:Connect(function()
        dropdownOpen = not dropdownOpen
        G2L["25"].Visible = dropdownOpen
        print("Dropdown:", dropdownOpen and "opened" or "closed")
    end)
    
    return G2L["1"]
end

return Library
