-- [[ DIAMOND X | AIDEL - BUTTON FIX ]]
local cg = game:GetService("CoreGui")
local lp = game:GetService("Players").LocalPlayer

-- Видаляємо старі об'єкти
if cg:FindFirstChild("DX_FIX") then cg.DX_FIX:Destroy() end

local sg = Instance.new("ScreenGui", cg)
sg.Name = "DX_FIX"
sg.DisplayOrder = 9999

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 220, 0, 260)
main.Position = UDim2.new(0.5, -110, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.BorderSizePixel = 2
main.BorderColor3 = Color3.fromRGB(0, 255, 255)
main.Active = true
main.Draggable = true

-- Заголовок
local t = Instance.new("TextLabel", main)
t.Size = UDim2.new(1, 0, 0, 40)
t.Text = "DIAMOND X CORE"
t.TextColor3 = Color3.new(0, 1, 1)
t.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
t.Font = Enum.Font.GothamBold
t.TextSize = 16

-- === ФУНКЦІЯ СТВОРЕННЯ КНОПОК ===
-- Тепер з жорсткою прив'язкою до вікна
local function b(name, y, color, func)
    local btn = Instance.new("TextButton")
    btn.Parent = main -- Пряма прив'язка
    btn.Name = name .. "_Btn"
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.BackgroundColor3 = color
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Visible = true
    btn.AutoButtonColor = true
    
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 8)
    
    btn.MouseButton1Click:Connect(func)
end

-- === САМІ КНОПКИ ===
-- Позиції виставлені вручну, щоб не перекривалися
b("FORCE DDOS", 50, Color3.fromRGB(150, 0, 0), function()
    _G.s = not _G.s
    print("DDoS Status: " .. tostring(_G.s))
end)

b("COOLKID ANIMS", 105, Color3.fromRGB(40, 40, 40), function()
    print("Anims Activated")
end)

b("WALL BREAKER", 160, Color3.fromRGB(0, 100, 180), function()
    print("Breaker Tool Added")
end)

b("CLOSE MENU", 215, Color3.fromRGB(30, 30, 30), function()
    sg:Destroy()
end)

-- Перемикач на RightControl
game:GetService("UserInputService").InputBegan:Connect(function(i, p)
    if i.KeyCode == Enum.KeyCode.RightControl then main.Visible = not main.Visible end
end)

warn("[aidel]: UI RENDERED WITH BUTTONS.")
