local a = {}
local b = game:GetService("Lighting")
local c = {}

for _, d in pairs(c) do
    pcall(d.Disconnect, d)
end

table.clear(c)

local function e(f, g)
    local h, i = pcall(function()
        return f[g]
    end)
    return h and i or nil
end

local function j(f, g, k)
    return pcall(function()
        f[g] = k
    end)
end

local l = {
    GlobalShadows = { Original = e(b, "GlobalShadows"), SwappedVersion = false },
    ShadowSoftness = { Original = e(b, "ShadowSoftness"), SwappedVersion = 0 },
    Technology = { Original = e(b, "Technology"), SwappedVersion = Enum.Technology.Voxel },
    FogEnd = { Original = e(b, "FogEnd"), SwappedVersion = 9e9 },
    FogStart = { Original = e(b, "FogStart"), SwappedVersion = 9e9 }
}

local m = {}

local function n(o)
    if typeof(o) ~= "Instance" or not o:IsA("BasePart") then return end
    if m[o] ~= nil then return end
    
    m[o] = {
        Material = e(o, "Material"),
        Reflectance = e(o, "Reflectance"),
        CastShadow = e(o, "CastShadow")
    }
end

for _, p in pairs(workspace:GetDescendants()) do
    if not p:IsA("BasePart") then continue end
    n(p)
end

table.insert(c, workspace.DescendantAdded:Connect(function(p)
    if not p:IsA("BasePart") then return end
    n(p)
end))

table.insert(c, workspace.DescendantRemoving:Connect(function(p)
    if not p:IsA("BasePart") then return end
    pcall(function()
        m[p] = nil
    end)
end))

local isEnabled = false

function a.q(r)
    isEnabled = not isEnabled if r == nil then r = isEnabled end

    for s, t in pairs(m) do
        j(s, "Material", r and Enum.Material.SmoothPlastic or t.Material)
        j(s, "Reflectance", r and 0 or t.Reflectance)
        j(s, "CastShadow", r and false or t.CastShadow)
    end
    
    for u, v in pairs(l) do
        j(b, u, r and v.SwappedVersion or v.Original)
    end
end

a.q()

return a
