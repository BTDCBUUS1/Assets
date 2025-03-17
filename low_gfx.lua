local a={}
local b=game:GetService("Lighting")
c={}
for d,e in pairs(c)do
    pcall(e.Disconnect,e)
end
table.clear(c)
local function f(g,h)
    local i,j=pcall(function()
        return g[h]
    end)
    return i and j or nil
end
local function k(g,h,l)
    return pcall(function()
        g[h]=l
    end)
end
l={
    m={n=f(b,"GlobalShadows"),o=false},
    p={n=f(b,"ShadowSoftness"),o=0},
    q={n=f(b,"Technology"),o=Enum.Technology.Voxel},
    r={n=f(b,"FogEnd"),o=9e9},
    s={n=f(b,"FogStart"),o=9e9}
}
t={}
local function u(v)
    if typeof(v)~="Instance"or not v:IsA("BasePart")then return end
    if t[v]~=nil then return end
    t[v]={
        w=f(v,"Material"),
        x=f(v,"Reflectance"),
        y=f(v,"CastShadow")
    }
end
for d,e in pairs(workspace:GetDescendants())do
    if not e:IsA("BasePart")then continue end
    u(e)
end
table.insert(c,workspace.DescendantAdded:Connect(function(e)
    if not e:IsA("BasePart")then return end
    u(e)
end))
table.insert(c,workspace.DescendantRemoving:Connect(function(e)
    if not e:IsA("BasePart")then return end
    pcall(function()
        t[e]=nil
    end)
end))
function a.On(z)
    for e,A in pairs(t)do
        k(e,"Material",z and Enum.Material.SmoothPlastic or A.w)
        k(e,"Reflectance",z and 0 or A.x)
        k(e,"CastShadow",z and false or A.y)
    end
    for e,A in pairs(l)do
        k(b,e,z and A.o or A.n)
    end
end
a.On(false)
return a
