local a={}
local b=game:GetService("Lighting")
local c=game:GetService("RunService")
d={}
for e,f in pairs(d)do
    pcall(f.Disconnect,f)
end
table.clear(d)
local function g(h,i)
    local j,k=pcall(function()
        return h[i]
    end)
    return j and k or nil
end
local function l(h,i,m)
    return pcall(function()
        h[i]=m
    end)
end
n={
    o={p=g(b,"GlobalShadows"),q=false},
    r={p=g(b,"ShadowSoftness"),q=0},
    s={p=g(b,"Technology"),q=Enum.Technology.Voxel},
    t={p=g(b,"FogEnd"),q=9e9},
    u={p=g(b,"FogStart"),q=9e9}
}
v={}
local function w(x)
    if typeof(x)~="Instance"or not x:IsA("BasePart")then return end
    if v[x]~=nil then return end
    v[x]={
        y=g(x,"Material"),
        z=g(x,"Reflectance"),
        A=g(x,"CastShadow")
    }
end
for e,f in pairs(workspace:GetDescendants())do
    if not f:IsA("BasePart")then continue end
    w(f)
end
table.insert(d,workspace.DescendantAdded:Connect(function(f)
    if not f:IsA("BasePart")then return end
    w(f)
end))
table.insert(d,workspace.DescendantRemoving:Connect(function(f)
    if not f:IsA("BasePart")then return end
    pcall(function()
        v[f]=nil
    end)
end))
function a.On(B)
    for f,C in pairs(v)do
        l(f,"Material",B and Enum.Material.SmoothPlastic or C.y)
        l(f,"Reflectance",B and 0 or C.z)
        l(f,"CastShadow",B and false or C.A)
    end
    for f,C in pairs(n)do
        l(b,f,B and C.q or C.p)
    end
end

a.NoclipEnabled=false
table.insert(d,c.Stepped:Connect(function()
    if a.NoclipEnabled then
        for _,D in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if D:IsA("BasePart") then
                D.CanCollide=false
            end
        end
    end
end))

function a.Noclip(E)
    a.NoclipEnabled=E
end

a.On(false)
return a
