-- [[ PROJECT DIAMOND X - RELOADED ]]
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")

-- Видаляємо старі копії перед запуском
if coreGui:FindFirstChild("DiamondX_Final") then coreGui.DiamondX_Final:Destroy() end

local screenGui = Instance.new("ScreenGui", coreGui)
screenGui.Name = "DiamondX_Final"

-- === ГОЛОВНЕ МЕНЮ ===
local main = Instance.new("Frame", screenGui)
main.Size = UDim2.new(0, 220, 0, 320)
main.Position = UDim2.new(0.5, -110, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true -- Щоб можна було рухати
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)

-- Тінь/Сяйво
local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(0, 255, 255)
stroke.Thickness = 2
stroke.Transparency = 0.5

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 45)
title.Text = "DIAMOND X CORE"
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundTransparency = 1

-- Кнопка "ЗАКРИТИ" (щоб меню не висіло вічно)
local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0, 20, 0, 20)
close.Position = UDim2.new(1, -25, 0, 10)
close.Text = "X"; close.TextColor3 = Color3.new(1,0,0); close.BackgroundTransparency = 1
close.MouseButton1Click:Connect(function() screenGui:Destroy() end)

-- КОНТЕЙНЕР ДЛЯ КНОПОК
local list = Instance.new("ScrollingFrame", main)
list.Size = UDim2.new(0.9, 0, 0.8, 0)
list.Position = UDim2.new(0.05, 0, 0.18, 0)
list.BackgroundTransparency = 1
list.CanvasSize = UDim2.new(0, 0, 1.2, 0)
list.ScrollBarThickness = 0
Instance.new("UIListLayout", list).Padding = UDim.new(0, 8)

local function createBtn(txt, color, func)
    local b = Instance.new("TextButton", list)
    b.Size = UDim2.new(1, 0, 0, 35)
    b.Text = txt
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(func)
end

-- === ФУНКЦІЇ ===
createBtn("START DDoS (2/sec)", Color3.fromRGB(180, 0, 0), function()
    _G.stressing = not _G.stressing
    print("DDoS Status: ", _G.stressing)
    -- Тут код атаки, який ми робили раніше
end)

createBtn("GET BREAKER", Color3.fromRGB(40, 40, 40), function()
    local tool = Instance.new("Tool", players.LocalPlayer.Backpack)
    tool.Name = "💎 BREAKER"; tool.RequiresHandle = false
    tool.Activated:Connect(function()
        local m = players.LocalPlayer:GetMouse()
        if m.Target and not players:GetPlayerFromCharacter(m.Target.Parent) then m.Target:Destroy() end
    end)
end)

-- Гаряча клавіша RightControl для приховування
userInputService.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.RightControl then
        main.Visible = not main.Visible
    end
end)

print("💎 Diamond X Loaded! Натисніть RightControl, щоб сховати.")
