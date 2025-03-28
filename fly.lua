local _0x1a2b3c = false
local _0x4d5e6f = 100000000000000
local _0x7g8h9i = game.UserInputService
local _0x0a1b2c = game.Players.LocalPlayer
local _0x3d4e5f = _0x0a1b2c:GetMouse()

local function _0x6g7h8i(_0xa, _0xb, _0xc)
    local _0xd = (_0xb - _0xa)
    local _0xe = _0xd.Magnitude
    return (_0xd / _0xe) * _0xc
end

local function _0x9j0k1l(_0xf)
    local _0xg = tostring(_0xf):lower()
    local _0xh, _0xi = _0xg:find("keycode.")
    return _0xg:sub(_0xi + 1)
end

local _0x2j3k4l = {}
game:GetService("RunService").Heartbeat:connect(function()
    pcall(function()
        local _0xm = _0x0a1b2c.Character.HumanoidRootPart
        local _0xn = CFrame.new() + Vector3.new(0, 0, -_0x4d5e6f)
        local _0xo = CFrame.new() + Vector3.new(0, 0, _0x4d5e6f)
        local _0xp = CFrame.new() + Vector3.new(-_0x4d5e6f, 0, 0)
        local _0xq = CFrame.new() + Vector3.new(_0x4d5e6f, 0, 0)
        local _0xr = CFrame.new() + Vector3.new(0, _0x4d5e6f, 0)
        local _0xs = CFrame.new() + Vector3.new(0, -_0x4d5e6f, 0)
        local _0xt = Vector3.new()

        if _0x1a2b3c and getgenv().Fly then
            if _0x2j3k4l.w_active then
                _0xt = _0xt + _0x6g7h8i(_0xm.Position, (_0xm.CFrame * _0xn).Position, getgenv().FlySpeed)
            end
            if _0x2j3k4l.s_active then
                _0xt = _0xt + _0x6g7h8i(_0xm.Position, (_0xm.CFrame * _0xo).Position, getgenv().FlySpeed)
            end
            if _0x2j3k4l.a_active then
                _0xt = _0xt + _0x6g7h8i(_0xm.Position, (_0xm.CFrame * _0xp).Position, getgenv().FlySpeed)
            end
            if _0x2j3k4l.d_active then
                _0xt = _0xt + _0x6g7h8i(_0xm.Position, (_0xm.CFrame * _0xq).Position, getgenv().FlySpeed)
            end
            if _0x2j3k4l.e_active then
                _0xt = _0xt + _0x6g7h8i(_0xm.Position, (CFrame.new(_0xm.Position) * _0xr).Position, getgenv().FlySpeed)
            end
            if _0x2j3k4l.q_active then
                _0xt = _0xt + _0x6g7h8i(_0xm.Position, (CFrame.new(_0xm.Position) * _0xs).Position, getgenv().FlySpeed)
            end
            _0xm.Velocity = _0xt
            _0xm.CFrame = CFrame.new(_0xm.Position, (workspace.Camera.CFrame * (CFrame.new() + Vector3.new(0, 0, -_0x4d5e6f))).Position)
        end

        if _0x1a2b3c and not _0x2j3k4l.w_active and not _0x2j3k4l.a_active and not _0x2j3k4l.s_active and not _0x2j3k4l.d_active and not _0x2j3k4l.q_active and not _0x2j3k4l.e_active then
            _0xm.Anchored = true
        else
            _0xm.Anchored = false
        end
    end)
end)

_0x7g8h9i.InputBegan:connect(function(_0xu, _0xv)
    if _0xv then return end
    if _0xu.KeyCode == Enum.KeyCode.F and getgenv().Fly then
        _0x1a2b3c = not _0x1a2b3c
        if _0x1a2b3c then
            _0x7g8h9i.MouseBehavior = Enum.MouseBehavior.LockCenter
            _0x0a1b2c.Character.Humanoid.CameraOffset = Vector3.new(2, 0, 0)
        else
            _0x7g8h9i.MouseBehavior = Enum.MouseBehavior.Default
            _0x0a1b2c.Character.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
        end
    end
    _0x2j3k4l[_0x9j0k1l(_0xu.KeyCode) .. "_active"] = true
end)

_0x7g8h9i.InputEnded:connect(function(_0xw)
    _0x2j3k4l[_0x9j0k1l(_0xw.KeyCode) .. "_active"] = false
end)
