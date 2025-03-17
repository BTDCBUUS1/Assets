-- esp.lua
--// Variables
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera
local cache = {}

--// Settings
local ESP_SETTINGS = {
    BoxOutlineColor = Color3.new(0, 0, 0),
    BoxColor = Color3.new(1, 1, 1),
    NameColor = Color3.new(1, 1, 1),
    HealthOutlineColor = Color3.new(0, 0, 0),
    armorOutline = Color3.new(0, 0, 255),
    HealthHighColor = Color3.new(0, 1, 0),
    HealthLowColor = Color3.new(1, 0, 0),
    CharSize = Vector2.new(4, 6),
    Teamcheck = false,
    WallCheck = false,
    Enabled = false,
    ShowBox = false,
    BoxType = "2D",
    ShowName = false,
    ShowHealth = false,
    ShowDistance = false,
    ShowTracer = false,
    TracerColor = Color3.new(1, 1, 1), 
    TracerThickness = 2,
    TracerPosition = "Bottom",
}

local function create(class, properties)
    local drawing = Drawing.new(class)
    for property, value in pairs(properties) do
        drawing[property] = value
    end
    return drawing
end

local function createEsp(player)
    local esp = {
        tracer = create("Line", {
            Thickness = ESP_SETTINGS.TracerThickness,
            Color = ESP_SETTINGS.TracerColor,
            Transparency = 0.5
        }),
        boxOutline = create("Square", {
            Color = ESP_SETTINGS.BoxOutlineColor,
            Thickness = 3,
            Filled = false
        }),
        box = create("Square", {
            Color = ESP_SETTINGS.BoxColor,
            Thickness = 1,
            Filled = false
        }),
        name = create("Text", {
            Color = ESP_SETTINGS.NameColor,
            Outline = true,
            Center = true,
            Size = 13
        }),
        healthOutline = create("Line", {
            Thickness = 3,
            Color = ESP_SETTINGS.HealthOutlineColor
        }),
        health = create("Line", {
            Thickness = 1
        }),
        distance = create("Text", {
            Color = Color3.new(1, 1, 1),
            Size = 12,
            Outline = true,
            Center = true
        }),
        boxLines = {},
    }

    cache[player] = esp
end

local function removeEsp(player)
    local esp = cache[player]
    if not esp then return end

    for _, drawing in pairs(esp) do
        drawing:Remove()
    end

    cache[player] = nil
end

local function updateReputation(player)
    local playerList = localPlayer:FindFirstChild("PlayerGui")
        and localPlayer.PlayerGui:FindFirstChild("HUD")
        and localPlayer.PlayerGui.HUD:FindFirstChild("Playerlist")
        and localPlayer.PlayerGui.HUD.Playerlist:FindFirstChild("List")

    if playerList then
        local playerFrame = playerList:FindFirstChild(player.Name)
        if playerFrame then
            local reputationLabel = playerFrame:FindFirstChild("Reputation")
            if reputationLabel and reputationLabel:IsA("TextLabel") then
                return "Rep: " .. reputationLabel.Text
            end
        end
    end
    return "Rep: ???"
end

local function updateEsp()
    for player, esp in pairs(cache) do
        local character, team = player.Character, player.Team
        if character and (not ESP_SETTINGS.Teamcheck or (team and team ~= localPlayer.Team)) then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            local head = character:FindFirstChild("Head")
            local humanoid = character:FindFirstChild("Humanoid")
            local shouldShow = ESP_SETTINGS.Enabled
            if rootPart and head and humanoid and shouldShow then
                local position, onScreen = camera:WorldToViewportPoint(rootPart.Position)
                if onScreen then
                    local hrp2D = camera:WorldToViewportPoint(rootPart.Position)
                    local boxSize = Vector2.new(50, 100)
                    local boxPosition = Vector2.new(hrp2D.X - boxSize.X / 2, hrp2D.Y - boxSize.Y / 2)
                    
                    if ESP_SETTINGS.ShowName then
                        esp.name.Visible = true
                        esp.name.Text = string.lower(player.Name)
                        esp.name.Position = Vector2.new(boxSize.X / 2 + boxPosition.X, boxPosition.Y - 16)
                    else
                        esp.name.Visible = false
                    end

                    if ESP_SETTINGS.ShowBox then
                        esp.boxOutline.Size = boxSize
                        esp.boxOutline.Position = boxPosition
                        esp.box.Size = boxSize
                        esp.box.Position = boxPosition
                        esp.box.Visible = true
                        esp.boxOutline.Visible = true
                    else
                        esp.box.Visible = false
                        esp.boxOutline.Visible = false
                    end

                    if ESP_SETTINGS.ShowDistance then
                        local rep = updateReputation(player)
                        esp.distance.Text = string.format(rep)
                        esp.distance.Position = Vector2.new(boxPosition.X + boxSize.X / 2, boxPosition.Y + boxSize.Y + 5)
                        esp.distance.Visible = true
                    else
                        esp.distance.Visible = false
                    end

                    if ESP_SETTINGS.ShowTracer then
                        local tracerY = ESP_SETTINGS.TracerPosition == "Top" and 0 or ESP_SETTINGS.TracerPosition == "Middle" and camera.ViewportSize.Y / 2 or camera.ViewportSize.Y
                        esp.tracer.Visible = true
                        esp.tracer.From = Vector2.new(camera.ViewportSize.X / 2, tracerY)
                        esp.tracer.To = Vector2.new(hrp2D.X, hrp2D.Y)
                    else
                        esp.tracer.Visible = false
                    end
                else
                    for _, drawing in pairs(esp) do
                        drawing.Visible = false
                    end
                end
            else
                for _, drawing in pairs(esp) do
                    drawing.Visible = false
                end
            end
        else
            for _, drawing in pairs(esp) do
                drawing.Visible = false
            end
        end
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= localPlayer then
        createEsp(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= localPlayer then
        createEsp(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    pcall(function()
        removeEsp(player)
    end)
end)

RunService.RenderStepped:Connect(updateEsp)

return ESP_SETTINGS
