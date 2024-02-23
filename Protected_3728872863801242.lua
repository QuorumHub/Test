game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Quorum Hub on top!";
    Text = "https://discord.gg/F63WSheQyg";
    Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150";
    Duration = 5;
})

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robojini/Tuturial_UI_Library/main/UI_Template_1"))()

local Window = Library.CreateLib("Toilet show 1.02 by Quorum Hub", "RJTheme3")

local Tab = Window:NewTab("Main")

local Section = Tab:NewSection("Player")


Section:NewButton("Unfinished button", "It should have been godmode.", function()
    game.Players.LocalPlayer.Character.Humanoid.MaxHealth = 9999999999999999999999999999999999999999999
    game.Players.LocalPlayer.Character.Humanoid.Health = 9999999999999999999999999999999999999999999
end)


Section:NewButton("Anti-AFK", "Anti-AFK.", function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

local objectToDelete = ReplicatedStorage.afk
objectToDelete:Destroy()
wait (1)
repeat wait() until game:IsLoaded()
    game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)
end)


local ReportDetector = false
local isHooked = false -- Добавляем переменную для отслеживания, были ли уже установлены хуки

-- Функция для отправки уведомления
local function sendNotification(title, text, icon, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Icon = icon,
        Duration = duration,
    })
end

Section:NewToggle("Report detector", "Report detector.", function(state)
    if state then
        ReportDetector = true
        
        repeat
            task.wait()
        until game:IsLoaded()

        local function isAdonisAC(table)
            return rawget(table, "Detected") and typeof(rawget(table, "Detected")) == "function" and rawget(table, "RLocked")
        end

        -- Устанавливаем хуки только если их ещё нет
        if not isHooked then
            for _, v in next, getgc(true) do
                if typeof(v) == "table" and isAdonisAC(v) then
                    for i, v in next, v do
                        if rawequal(i, "Detected") then
                            local old;
                            old = hookfunction(v, function(action, info, nocrash)
                                if rawequal(action, "_") and rawequal(info, "_") and rawequal(nocrash, true) then
                                    return old(action, info, nocrash)
                                end
                                sendNotification(playerValue.Value, "Bypassed Adonis AC", "", 3) -- Отправляем уведомление
                                return task.wait(9e9)
                            end)
                            break
                        end
                    end
                end
            end
            isHooked = true -- Устанавливаем флаг, что хуки были установлены
        end

        repeat
            wait(5) -- Подождать 5 секунд

            local replicatedStorage = game:GetService("ReplicatedStorage")
            local currentReports = replicatedStorage:FindFirstChild("CURRENT_REPORTS")

            if currentReports then
                local gameReport = currentReports:FindFirstChild("Game Report")
                if gameReport then
                    local playerValue = gameReport:FindFirstChild("Player")
                    local reportReasonValue = gameReport:FindFirstChild("ReportReason")

                    if playerValue and reportReasonValue then
                        local value = playerValue.Value
                        local value2 = reportReasonValue.Value

                        if value2 ~= previousReportReason then
                            sendNotification(value, "Report Reason: " .. value2, "", 3) -- Отправляем уведомление
                            previousReportReason = value2
                        end
                    end
                end
            end

            wait(1)
        until not ReportDetector
    else
        ReportDetector = false
    end
end)


Section:NewSlider("Player speed", "Change player speed", 1000, 1, function(s) -- 500 (Макс. значение) | 0 (Мин. значение)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)


Section:NewSlider("Player Jump Power", "Change player jump power", 1000, 1, function(s) -- 500 (Макс. значение) | 0 (Мин. значение)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

local Section = Tab:NewSection("Stage bypass")
Section:NewButton("Bypass stage", "Please do not spam this button.", function()
    local maxTimeWithoutDeath = 5 -- Максимальное время без смерти в секундах
    local interval = 0.001 -- Интервал в секундах для обновления CFrame каждую миллисекунду
    
    local player = game.Players.LocalPlayer
    local lastDeathTime = tick()
    
    while true do
        local character = player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChild("Humanoid")
            
            if humanoid and humanoid.Health <= 0 then
                lastDeathTime = tick()
            end
            
            if tick() - lastDeathTime >= maxTimeWithoutDeath then
                break -- Прерываем цикл, если игрок остается живым в течение указанного времени
            end
            
            if humanoidRootPart then
                humanoidRootPart.CFrame = CFrame.new(91, 101, -493) -- Обновляем CFrame игрока
            end
        end
        
        wait(interval)
    end
end)


Section:NewButton("Bypass stage(For lagged servers)", "Please do not spam this button.", function()
    local maxTimeWithoutDeath = 15 -- Максимальное время без смерти в секундах
    local interval = 0.001 -- Интервал в секундах для обновления CFrame каждую миллисекунду
    
    local player = game.Players.LocalPlayer
    local lastDeathTime = tick()
    
    while true do
        local character = player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChild("Humanoid")
            
            if humanoid and humanoid.Health <= 0 then
                lastDeathTime = tick()
            end
            
            if tick() - lastDeathTime >= maxTimeWithoutDeath then
                break -- Прерываем цикл, если игрок остается живым в течение указанного времени
            end
            
            if humanoidRootPart then
                humanoidRootPart.CFrame = CFrame.new(91, 101, -493) -- Обновляем CFrame игрока
            end
        end
        
        wait(interval)
    end
end)

local Section = Tab:NewSection("Troll")


Section:NewButton("Auto host", "Automatically transfers you to the host team. It doesn't always work.", function()
    local Players = game:GetService("Players")
    local Teams = game:GetService("Teams")
    
    local teamToCheck = Teams["Host"] -- замените на название вашей команды
    local actionPerformed = false -- флаг, показывающий, было ли выполнено действие
    
    while true do
        local playersInTeam = teamToCheck:GetPlayers()
        if #playersInTeam == 0 and not actionPerformed then
            -- Здесь можно добавить любое действие, которое нужно выполнить, если в команде не осталось игроков
            -- Script generated by R2Sv2
            -- R2Sv2 developed by Luckyxero
     
            local A_1 = "Host"
            local Event = game:GetService("ReplicatedStorage").Remotes.PlayerRemotes.ChangeTeam
            Event:FireServer(A_1)
            actionPerformed = true -- устанавливаем флаг, что действие было выполнено
        end
        wait() -- Проверка происходит каждую секунду, чтобы не нагружать сервер
    end
end)


local active = false
local trueActive = false
local dmgEnabled = false
local visualizerEnabled = false

local visualizer = Instance.new("Part")
visualizer.BrickColor = BrickColor.Blue()
visualizer.Transparency = 0.6
visualizer.Anchored = true
visualizer.CanCollide = false
visualizer.Size = Vector3.new(0.5, 0.5, 0.5)
visualizer.BottomSurface = Enum.SurfaceType.Smooth
visualizer.TopSurface = Enum.SurfaceType.Smooth

Section:NewToggle("Hit All Script", "You can attack Host and Performer team members as an Auditioner, and as a Host, you can attack Judges and Auditioners.", function(state)
    if state then
            active = true
            trueActive = true
            local reachType = "Sphere"
            dmgEnabled = true
            visualizerEnabled = false
            
            local visualizer = Instance.new("Part")
            visualizer.BrickColor = BrickColor.Blue()
            visualizer.Transparency = 0.6
            visualizer.Anchored = true
            visualizer.CanCollide = false
            visualizer.Size = Vector3.new(0.5, 0.5, 0.5)
            visualizer.BottomSurface = Enum.SurfaceType.Smooth
            visualizer.TopSurface = Enum.SurfaceType.Smooth
            
            repeat wait() until game.Players.LocalPlayer
            
            local plr = game.Players.LocalPlayer
            
            local function onHit(hit, handle)
                local victim = hit.Parent:FindFirstChildOfClass("Humanoid")
                if victim and victim.Parent.Name ~= game.Players.LocalPlayer.Name then
                    if dmgEnabled then
                        for _, v in pairs(hit.Parent:GetChildren()) do
                            if v:IsA("Part") then
                                firetouchinterest(v, handle, 0)
                                firetouchinterest(v, handle, 1)
                            end
                        end
                    else
                        firetouchinterest(hit, handle, 0)
                        firetouchinterest(hit, handle, 1)
                    end
                end
            end
            
            local function getWhiteList()
                local wl = {}
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= plr then
                        local char = v.Character
                        if char then
                            for _, q in pairs(char:GetChildren()) do
                                if q:IsA("Part") then
                                    table.insert(wl, q)
                                end
                            end
                        end
                    end
                end
                return wl
            end
            
            game:GetService("RunService").RenderStepped:connect(function()
                if not active or not trueActive then
                    return
                end
                local s = plr.Character and plr.Character:FindFirstChildOfClass("Tool")
                if not s then
                    visualizer.Parent = nil
                end
                if s then
                    local handle = s:FindFirstChild("Handle") or s:FindFirstChildOfClass("Part")
                    if handle then
                        if visualizerEnabled then
                            visualizer.Parent = workspace
                        else
                            visualizer.Parent = nil
                        end
                        local reach = 200
                        if reach then
                            if reachType == "Sphere" then
                                visualizer.Shape = Enum.PartType.Ball
                                visualizer.Size = Vector3.new(reach, reach, reach)
                                visualizer.CFrame = handle.CFrame
                                for _, v in pairs(game.Players:GetPlayers()) do
                                    local hrp = v.Character and v.Character:FindFirstChild("HumanoidRootPart")
                                    if hrp and handle then
                                        local mag = (hrp.Position - handle.Position).magnitude
                                        if mag <= reach then
                                            onHit(hrp, handle)
                                        end
                                    end
                                end
                            elseif reachType == "Line" then
                                local origin = (handle.CFrame * CFrame.new(0, 0, -2)).p
                                local ray = Ray.new(origin, handle.CFrame.lookVector * -reach)
                                local p, pos = workspace:FindPartOnRayWithWhitelist(ray, getWhiteList())
                                visualizer.Shape = Enum.PartType.Block
                                visualizer.Size = Vector3.new(1, 0.8, reach)
                                visualizer.CFrame = handle.CFrame * CFrame.new(0, 0, (reach / 2) + 2)
                                if p then
                                    onHit(p, handle)
                                else
                                    for _, v in pairs(handle:GetTouchingParts()) do
                                        onHit(v, handle)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
    else
        active = false
        trueActive = false
        dmgEnabled = false
        visualizerEnabled = false
    end
end)


local AutoDoor = false

Section:NewToggle("Auto OpenAudDoor", "Auto open auditioner door.", function(state)
    if state then
        AutoDoor = true
        repeat
            local performerCount = 0
            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                if player.Team and player.Team.Name == "Performer" then
                    performerCount = performerCount + 1
                end
            end
            
            if performerCount == 0 then
                local Event = game:GetService("ReplicatedStorage").Remotes.HostRemotes.OpenAuditionerDoor
                Event:FireServer()
            end
            
            wait(1)
        until not AutoDoor
    else
        AutoDoor = false
    end
end)


local AutoClear = false
Section:NewToggle("Auto clear", "Auto Clear Map", function(state)
    if state then
        AutoClear = true
        local Players = game:GetService("Players")
        local Teams = game:GetService("Teams")
        
        local teamToCheck = Teams["Performer"] -- замените на название вашей команды
        
        while AutoClear do
            local playersInTeam = teamToCheck:GetPlayers()
            if #playersInTeam == 0 then
                local A_1 = "Clear Map"
                local Event = game:GetService("ReplicatedStorage").Remotes.HostRemotes.ChangeMap
                Event:FireServer(A_1)
            end
            wait(1)
        end
    else
        AutoClear = false
    end
end)


local LavaAbuse = false
Section:NewToggle("INF lava floor", "INF lava floor abuse.", function(state)
    if state then
        LavaAbuse = true
        repeat
            local A_1 = "Kill Performers"
            local Event = game:GetService("ReplicatedStorage").Remotes.HostRemotes.ChangeMap
            Event:FireServer(A_1)
            wait(2)
        until not LavaAbuse
    else
        LavaAbuse = false
    end
end)


Section:NewButton("Lava floor abuse", "Lava floor without cooldown, works only if you are in the host team.", function()
    -- Script generated by R2Sv2
-- R2Sv2 developed by Luckyxero
 
local A_1 = "Kill Performers"
local Event = game:GetService("ReplicatedStorage").Remotes.HostRemotes.ChangeMap
Event:FireServer(A_1)
end)


Section:NewButton("SwordFight map", "Sword fight map.", function()
-- Script generated by R2Sv2
-- R2Sv2 developed by Luckyxero
 
local A_1 = "Sword Fight The Host"
local Event = game:GetService("ReplicatedStorage").Remotes.HostRemotes.ChangeMap
Event:FireServer(A_1)
end)


Section:NewButton("Clear map", "Clear map.", function()
-- Script generated by R2Sv2
-- R2Sv2 developed by Luckyxero
 
local A_1 = "Clear Map"
local Event = game:GetService("ReplicatedStorage").Remotes.HostRemotes.ChangeMap
Event:FireServer(A_1)
end)


Section:NewButton("OpenAuditionerDoor", "Open aud door.", function()
-- Script generated by R2Sv2
-- R2Sv2 developed by Luckyxero
 
local Event = game:GetService("ReplicatedStorage").Remotes.HostRemotes.OpenAuditionerDoor
Event:FireServer()
end)


local Tab = Window:NewTab("Teleports")

local Section = Tab:NewSection("Teleports")


Section:NewButton("Admin room", "Go to admin room.", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(113, 146, -544)
end)


Section:NewButton("VIP room", "Go to VIP room.", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(233, 130, -407)
end)


Section:NewButton("Lobby", "Lobby teleport.", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(100, 101, -568)
end)


Section:NewButton("Control room", "Control teleport.", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(244, 144, -406)
end)


Section:NewButton("Audience room", "Audience teleport.", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141, 94, -230)
end)


Section:NewButton("Audience room 2", "Audience2 teleport.", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(270, 100, -405)
end)


Section:NewButton("Winner teleport", "Winner teleport.", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(107, 99, -295)
end)


Section:NewButton("Judge teleport", "Judge teleport.", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(164, 96, -407)
end)


Section:NewButton("Stage teleport", "Stage teleport.", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(91, 101, -493)
end)


Section:NewButton("Outdoors teleport", "Outdoors teleport.", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(188, 101, -730)
end)


Section:NewButton("Hats teleport", "Hats teleport.", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-36, 102, -540)
end)


Section:NewButton("Teleport to the aud. chairs right side", "Teleport to the audience chairs right side.", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(128, 96, -444)
end)


Section:NewButton("Teleport to the aud. chairs left side", "Teleport to the audience chairs left side.", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(131, 96, -375)
end)


local Tab = Window:NewTab("Tools")

local Section = Tab:NewSection("Tools")


Section:NewButton("Get sword", "It is necessary for the host to set the map Sword Fight The Host", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(270, 100, -405)
    workspace.Stage["Sword Fight The Host"].Swords:GetChildren()[4].Handle.CFrame = CFrame.new(270, 100, -405)
    workspace.Stage["Sword Fight The Host"].Swords.ClassicSword.Handle.CFrame = CFrame.new(270, 100, -405)
end)


Section:NewButton("Get paint tool", "It is necessary for the host to set the map Painting", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(270, 100, -405)
    workspace.Stage["Painting"].Draw.Handle.CFrame = CFrame.new(270, 100, -405)
end)


Section:NewButton("Get blue hockey stick", "Get blue hockey stick", function()
    local blueHockeyStick = workspace.LobbyHockey.Tools:FindFirstChild("BlueHockeyStick")
    
    if blueHockeyStick then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(121, 97, -905)
    end
    wait(1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(270, 100, -405)
end)


Section:NewButton("Get red hockey stick", "Get red hockey stick", function()
    local redHockeyStick = workspace.LobbyHockey.Tools:FindFirstChild("RedHockeyStick")
    
    if redHockeyStick then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(168, 97, -905)
    end
    wait(1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(270, 100, -405)
end)


local Tab = Window:NewTab("Visuals")

local Section = Tab:NewSection("Visuals")


Section:NewButton("Fake dinnerstick", "It gives you a fake dinnerstick.", function()
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")

local player = Players.LocalPlayer -- Получаем локального игрока
local backpack = player:FindFirstChildOfClass("Backpack") -- Получаем его рюкзак
local dinnerStick = Teams.Host["Dinner Stick"] -- Получаем объект "Dinner Stick" из команды "Host"

if backpack and dinnerStick then
    local clone = dinnerStick:Clone() -- Создаем копию объекта
    clone.Parent = backpack -- Добавляем копию в рюкзак игрока
end
end)


Section:NewButton("Fake microphone", "It gives you a fake microphone.", function()
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
    
local player = Players.LocalPlayer -- Получаем локального игрока
local backpack = player:FindFirstChildOfClass("Backpack") -- Получаем его рюкзак
local dinnerStick = Teams.Host["Microphone"] -- Получаем объект "Dinner Stick" из команды "Host"
    
if backpack and dinnerStick then
    local clone = dinnerStick:Clone() -- Создаем копию объекта
    clone.Parent = backpack -- Добавляем копию в рюкзак игрока
end
end)


Section:NewButton("Fake Server Host", "Fake Server Host in leader board.", function()
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local newTeam = game:GetService("Teams")["Server Host"]

player.Team = newTeam
end)


Section:NewButton("Server Host ESP", "Server Host ESP box.", function()
    while wait(3) do
        for i, childrik in ipairs(workspace:GetDescendants()) do
            if childrik:FindFirstChild("Humanoid") then
                if not childrik:FindFirstChild("EspBox") then
                    if childrik ~= game.Players.LocalPlayer.Character then
                        local player = game.Players:GetPlayerFromCharacter(childrik)
                        if player and player.Team and player.Team.Name == "Server Host" then
                            local esp = Instance.new("BoxHandleAdornment",childrik)
                            esp.Adornee = childrik
                            esp.ZIndex = 0
                            esp.Size = Vector3.new(4, 5, 1)
                            esp.Transparency = 0.65
                            esp.Color3 = Color3.fromRGB(255,0,0)
                            esp.AlwaysOnTop = true
                            esp.Name = "EspBox"
                        end
                    end
                end
            end
        end
    end
end)


local Tab = Window:NewTab("Autofarm")

local Section = Tab:NewSection("Autofarm")


local Farming = false
Section:NewToggle("Start autofarm", "Autofarm rep.", function(state)
    if state then
        Farming = true
        while Farming do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-15.3128, 138, -566)
            wait(2)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-25, 138, -565)
            wait(6)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(71, 134, -558)
            wait(2)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(79, 140, -557)
            wait(6)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(196, 125, -209)
            wait(2)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(205, 123, -209)
            wait(6)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(453, 159, -855)
            wait(2)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(465, 160, -853)
            wait(6)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(370, 149, -738)
            wait(2)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(370, 152, -726)
            wait(6)
        end
    else
        Farming = false
    end
end)


local Tab = Window:NewTab("Other")

local Section = Tab:NewSection("GUI")


Section:NewButton("Noclip GUI", "Add noclip GUI", function()
    local Workspace = game:GetService("Workspace")
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local Noclip = Instance.new("ScreenGui")
    local BG = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Toggle = Instance.new("TextButton")
    local StatusPF = Instance.new("TextLabel")
    local Status = Instance.new("TextLabel")
    local Plr = Players.LocalPlayer
    local Clipon = false
    
    Noclip.Name = "Noclip"
    Noclip.Parent = game.CoreGui
    
    BG.Name = "BG"
    BG.Parent = Noclip
    BG.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
    BG.BorderColor3 = Color3.new(0.0588235, 0.0588235, 0.0588235)
    BG.BorderSizePixel = 2
    BG.Position = UDim2.new(0.149479166, 0, 0.82087779, 0)
    BG.Size = UDim2.new(0, 210, 0, 127)
    BG.Active = true
    BG.Draggable = true
    
    Title.Name = "Title"
    Title.Parent = BG
    Title.BackgroundColor3 = Color3.new(0.266667, 0.00392157, 0.627451)
    Title.BorderColor3 = Color3.new(0.180392, 0, 0.431373)
    Title.BorderSizePixel = 2
    Title.Size = UDim2.new(0, 210, 0, 33)
    Title.Font = Enum.Font.Highway
    Title.Text = "Noclip"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.FontSize = Enum.FontSize.Size32
    Title.TextSize = 30
    Title.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
    Title.TextStrokeTransparency = 0
    
    Toggle.Parent = BG
    Toggle.BackgroundColor3 = Color3.new(0.266667, 0.00392157, 0.627451)
    Toggle.BorderColor3 = Color3.new(0.180392, 0, 0.431373)
    Toggle.BorderSizePixel = 2
    Toggle.Position = UDim2.new(0.152380958, 0, 0.374192119, 0)
    Toggle.Size = UDim2.new(0, 146, 0, 36)
    Toggle.Font = Enum.Font.Highway
    Toggle.FontSize = Enum.FontSize.Size28
    Toggle.Text = "Toggle"
    Toggle.TextColor3 = Color3.new(1, 1, 1)
    Toggle.TextSize = 25
    Toggle.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
    Toggle.TextStrokeTransparency = 0
    
    StatusPF.Name = "StatusPF"
    StatusPF.Parent = BG
    StatusPF.BackgroundColor3 = Color3.new(1, 1, 1)
    StatusPF.BackgroundTransparency = 1
    StatusPF.Position = UDim2.new(0.314285725, 0, 0.708661377, 0)
    StatusPF.Size = UDim2.new(0, 56, 0, 20)
    StatusPF.Font = Enum.Font.Highway
    StatusPF.FontSize = Enum.FontSize.Size24
    StatusPF.Text = "Status:"
    StatusPF.TextColor3 = Color3.new(1, 1, 1)
    StatusPF.TextSize = 20
    StatusPF.TextStrokeColor3 = Color3.new(0.333333, 0.333333, 0.333333)
    StatusPF.TextStrokeTransparency = 0
    StatusPF.TextWrapped = true
    
    Status.Name = "Status"
    Status.Parent = BG
    Status.BackgroundColor3 = Color3.new(1, 1, 1)
    Status.BackgroundTransparency = 1
    Status.Position = UDim2.new(0.580952346, 0, 0.708661377, 0)
    Status.Size = UDim2.new(0, 56, 0, 20)
    Status.Font = Enum.Font.Highway
    Status.FontSize = Enum.FontSize.Size14
    Status.Text = "off"
    Status.TextColor3 = Color3.new(0.666667, 0, 0)
    Status.TextScaled = true
    Status.TextSize = 14
    Status.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
    Status.TextWrapped = true
    Status.TextXAlignment = Enum.TextXAlignment.Left
    
    
    Toggle.MouseButton1Click:connect(function()
        if Status.Text == "off" then
            Clipon = true
            Status.Text = "on"
            Status.TextColor3 = Color3.new(0,185,0)
            Stepped = game:GetService("RunService").Stepped:Connect(function()
                if not Clipon == false then
                    for a, b in pairs(Workspace:GetChildren()) do
                    if b.Name == Plr.Name then
                    for i, v in pairs(Workspace[Plr.Name]:GetChildren()) do
                    if v:IsA("BasePart") then
                    v.CanCollide = false
                    end end end end
                else
                    Stepped:Disconnect()
                end
            end)
        elseif Status.Text == "on" then
            Clipon = false
            Status.Text = "off"
            Status.TextColor3 = Color3.new(170,0,0)
        end
    end)
end)


Section:NewButton("Fly GUI", "Add fly GUI", function()
    local main = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local up = Instance.new("TextButton")
    local down = Instance.new("TextButton")
    local onof = Instance.new("TextButton")
    local TextLabel = Instance.new("TextLabel")
    local plus = Instance.new("TextButton")
    local speed = Instance.new("TextLabel")
    local mine = Instance.new("TextButton")
    local closebutton = Instance.new("TextButton")
    local mini = Instance.new("TextButton")
    local mini2 = Instance.new("TextButton") 
    
    main.Name = "main"
    main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    main.ResetOnSpawn = false 
    
    Frame.Parent = main
    Frame.BackgroundColor3 = Color3.fromRGB(163, 255, 137)
    Frame.BorderColor3 = Color3.fromRGB(103, 221, 213)
    Frame.Position = UDim2.new(0.100320168, 0, 0.379746825, 0)
    Frame.Size = UDim2.new(0, 190, 0, 57) 
    
    up.Name = "up"
    up.Parent = Frame
    up.BackgroundColor3 = Color3.fromRGB(79, 255, 152)
    up.Size = UDim2.new(0, 44, 0, 28)
    up.Font = Enum.Font.SourceSans
    up.Text = "UP"
    up.TextColor3 = Color3.fromRGB(0, 0, 0)
    up.TextSize = 14.000 
    
    down.Name = "down"
    down.Parent = Frame
    down.BackgroundColor3 = Color3.fromRGB(215, 255, 121)
    down.Position = UDim2.new(0, 0, 0.491228074, 0)
    down.Size = UDim2.new(0, 44, 0, 28)
    down.Font = Enum.Font.SourceSans
    down.Text = "DOWN"
    down.TextColor3 = Color3.fromRGB(0, 0, 0)
    down.TextSize = 14.000 
    
    onof.Name = "onof"
    onof.Parent = Frame
    onof.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
    onof.Position = UDim2.new(0.702823281, 0, 0.491228074, 0)
    onof.Size = UDim2.new(0, 56, 0, 28)
    onof.Font = Enum.Font.SourceSans
    onof.Text = "fly"
    onof.TextColor3 = Color3.fromRGB(0, 0, 0)
    onof.TextSize = 14.000 
    
    TextLabel.Parent = Frame
    TextLabel.BackgroundColor3 = Color3.fromRGB(242, 60, 255)
    TextLabel.Position = UDim2.new(0.469327301, 0, 0, 0)
    TextLabel.Size = UDim2.new(0, 100, 0, 28)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.Text = "Fly GUI V3"
    TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 14.000
    TextLabel.TextWrapped = true 
    
    plus.Name = "plus"
    plus.Parent = Frame
    plus.BackgroundColor3 = Color3.fromRGB(133, 145, 255)
    plus.Position = UDim2.new(0.231578946, 0, 0, 0)
    plus.Size = UDim2.new(0, 45, 0, 28)
    plus.Font = Enum.Font.SourceSans
    plus.Text = "+"
    plus.TextColor3 = Color3.fromRGB(0, 0, 0)
    plus.TextScaled = true
    plus.TextSize = 14.000
    plus.TextWrapped = true 
    
    speed.Name = "speed"
    speed.Parent = Frame
    speed.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
    speed.Position = UDim2.new(0.468421042, 0, 0.491228074, 0)
    speed.Size = UDim2.new(0, 44, 0, 28)
    speed.Font = Enum.Font.SourceSans
    speed.Text = "1"
    speed.TextColor3 = Color3.fromRGB(0, 0, 0)
    speed.TextScaled = true
    speed.TextSize = 14.000
    speed.TextWrapped = true 
    
    mine.Name = "mine"
    mine.Parent = Frame
    mine.BackgroundColor3 = Color3.fromRGB(123, 255, 247)
    mine.Position = UDim2.new(0.231578946, 0, 0.491228074, 0)
    mine.Size = UDim2.new(0, 45, 0, 29)
    mine.Font = Enum.Font.SourceSans
    mine.Text = "-"
    mine.TextColor3 = Color3.fromRGB(0, 0, 0)
    mine.TextScaled = true
    mine.TextSize = 14.000
    mine.TextWrapped = true 
    
    closebutton.Name = "Close"
    closebutton.Parent = main.Frame
    closebutton.BackgroundColor3 = Color3.fromRGB(225, 25, 0)
    closebutton.Font = "SourceSans"
    closebutton.Size = UDim2.new(0, 45, 0, 28)
    closebutton.Text = "X"
    closebutton.TextSize = 30
    closebutton.Position = UDim2.new(0, 0, -1, 27) 
    
    mini.Name = "minimize"
    mini.Parent = main.Frame
    mini.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
    mini.Font = "SourceSans"
    mini.Size = UDim2.new(0, 45, 0, 28)
    mini.Text = "-"
    mini.TextSize = 40
    mini.Position = UDim2.new(0, 44, -1, 27) 
    
    mini2.Name = "minimize2"
    mini2.Parent = main.Frame
    mini2.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
    mini2.Font = "SourceSans"
    mini2.Size = UDim2.new(0, 45, 0, 28)
    mini2.Text = "+"
    mini2.TextSize = 40
    mini2.Position = UDim2.new(0, 44, -1, 57)
    mini2.Visible = false 
    
    speeds = 1 
    
    local speaker = game:GetService("Players").LocalPlayer 
    
    local chr = game.Players.LocalPlayer.Character
    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid") 
    
    nowe = false 
    
    game:GetService("StarterGui"):SetCore("SendNotification", { 
    Title = "Fly GUI V3";
    Text = "By me_ozone and Quandale The Dinglish XII#3550";
    Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"})
    Duration = 5; 
    
    Frame.Active = true -- main = gui
    Frame.Draggable = true 
    
    onof.MouseButton1Down:connect(function() 
    
    if nowe == true then
    nowe = false 
    
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
    speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
    else 
    nowe = true
    
    
    
    for i = 1, speeds do
    spawn(function() 
    
    local hb = game:GetService("RunService").Heartbeat
    
    
    tpwalking = true
    local chr = game.Players.LocalPlayer.Character
    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
    while tpwalking and hb:Wait() and chr and hum and hum.Parent do
    if hum.MoveDirection.Magnitude > 0 then
    chr:TranslateBy(hum.MoveDirection)
    end
    end 
    
    end)
    end
    game.Players.LocalPlayer.Character.Animate.Disabled = true
    local Char = game.Players.LocalPlayer.Character
    local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController") 
    
    for i,v in next, Hum:GetPlayingAnimationTracks() do
    v:AdjustSpeed(0)
    end
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
    speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
    end
    
    
    
    
    if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
    
    
    
    local plr = game.Players.LocalPlayer
    local torso = plr.Character.Torso
    local flying = true
    local deb = true
    local ctrl = {f = 0, b = 0, l = 0, r = 0}
    local lastctrl = {f = 0, b = 0, l = 0, r = 0}
    local maxspeed = 50
    local speed = 0
    
    
    local bg = Instance.new("BodyGyro", torso)
    bg.P = 9e4
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.cframe = torso.CFrame
    local bv = Instance.new("BodyVelocity", torso)
    bv.velocity = Vector3.new(0,0.1,0)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
    if nowe == true then
    plr.Character.Humanoid.PlatformStand = true
    end
    while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
    game:GetService("RunService").RenderStepped:Wait() 
    
    if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
    speed = speed+.5+(speed/maxspeed)
    if speed > maxspeed then
    speed = maxspeed
    end
    elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
    speed = speed-1
    if speed < 0 then
    speed = 0
    end
    end
    if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
    bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
    lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
    elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
    bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
    else
    bv.velocity = Vector3.new(0,0,0)
    end
    --game.Players.LocalPlayer.Character.Animate.Disabled = true
    bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
    end
    ctrl = {f = 0, b = 0, l = 0, r = 0}
    lastctrl = {f = 0, b = 0, l = 0, r = 0}
    speed = 0
    bg:Destroy()
    bv:Destroy()
    plr.Character.Humanoid.PlatformStand = false
    game.Players.LocalPlayer.Character.Animate.Disabled = false
    tpwalking = false
    
    
    
    
    else
    local plr = game.Players.LocalPlayer
    local UpperTorso = plr.Character.UpperTorso
    local flying = true
    local deb = true
    local ctrl = {f = 0, b = 0, l = 0, r = 0}
    local lastctrl = {f = 0, b = 0, l = 0, r = 0}
    local maxspeed = 50
    local speed = 0
    
    
    local bg = Instance.new("BodyGyro", UpperTorso)
    bg.P = 9e4
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.cframe = UpperTorso.CFrame
    local bv = Instance.new("BodyVelocity", UpperTorso)
    bv.velocity = Vector3.new(0,0.1,0)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
    if nowe == true then
    plr.Character.Humanoid.PlatformStand = true
    end
    while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
    wait() 
    
    if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
    speed = speed+.5+(speed/maxspeed)
    if speed > maxspeed then
    speed = maxspeed
    end
    elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
    speed = speed-1
    if speed < 0 then
    speed = 0
    end
    end
    if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
    bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
    lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
    elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
    bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
    else
    bv.velocity = Vector3.new(0,0,0)
    end 
    
    bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
    end
    ctrl = {f = 0, b = 0, l = 0, r = 0}
    lastctrl = {f = 0, b = 0, l = 0, r = 0}
    speed = 0
    bg:Destroy()
    bv:Destroy()
    plr.Character.Humanoid.PlatformStand = false
    game.Players.LocalPlayer.Character.Animate.Disabled = false
    tpwalking = false
    
    
    
    end
    
    
    
    
    
    end) 
    
    local tis 
    
    up.MouseButton1Down:connect(function()
    tis = up.MouseEnter:connect(function()
    while tis do
    wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,0)
    end
    end)
    end) 
    
    up.MouseLeave:connect(function()
    if tis then
    tis:Disconnect()
    tis = nil
    end
    end) 
    
    local dis 
    
    down.MouseButton1Down:connect(function()
    dis = down.MouseEnter:connect(function()
    while dis do
    wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,0)
    end
    end)
    end) 
    
    down.MouseLeave:connect(function()
    if dis then
    dis:Disconnect()
    dis = nil
    end
    end)
    
    
    game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
    wait(0.7)
    game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
    game.Players.LocalPlayer.Character.Animate.Disabled = false 
    
    end)
    
    
    plus.MouseButton1Down:connect(function()
    speeds = speeds + 1
    speed.Text = speeds
    if nowe == true then
    
    
    tpwalking = false
    for i = 1, speeds do
    spawn(function() 
    
    local hb = game:GetService("RunService").Heartbeat
    
    
    tpwalking = true
    local chr = game.Players.LocalPlayer.Character
    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
    while tpwalking and hb:Wait() and chr and hum and hum.Parent do
    if hum.MoveDirection.Magnitude > 0 then
    chr:TranslateBy(hum.MoveDirection)
    end
    end 
    
    end)
    end
    end
    end)
    mine.MouseButton1Down:connect(function()
    if speeds == 1 then
    speed.Text = 'cannot be less than 1'
    wait(1)
    speed.Text = speeds
    else
    speeds = speeds - 1
    speed.Text = speeds
    if nowe == true then
    tpwalking = false
    for i = 1, speeds do
    spawn(function() 
    
    local hb = game:GetService("RunService").Heartbeat
    
    
    tpwalking = true
    local chr = game.Players.LocalPlayer.Character
    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
    while tpwalking and hb:Wait() and chr and hum and hum.Parent do
    if hum.MoveDirection.Magnitude > 0 then
    chr:TranslateBy(hum.MoveDirection)
    end
    end 
    
    end)
    end
    end
    end
    end) 
    
    closebutton.MouseButton1Click:Connect(function()
    main:Destroy()
    end) 
    
    mini.MouseButton1Click:Connect(function()
    up.Visible = false
    down.Visible = false
    onof.Visible = false
    plus.Visible = false
    speed.Visible = false
    mine.Visible = false
    mini.Visible = false
    mini2.Visible = true
    main.Frame.BackgroundTransparency = 1
    closebutton.Position = UDim2.new(0, 0, -1, 57)
    end) 
    
    mini2.MouseButton1Click:Connect(function()
    up.Visible = true
    down.Visible = true
    onof.Visible = true
    plus.Visible = true
    speed.Visible = true
    mine.Visible = true
    mini.Visible = true
    mini2.Visible = false
    main.Frame.BackgroundTransparency = 0 
    closebutton.Position = UDim2.new(0, 0, -1, 27)
    end)
end)

local Section = Tab:NewSection("Useful")


Section:NewButton("BTools", "BTools", function()
    loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/BTools.txt"))()
end)
