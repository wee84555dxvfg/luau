do
    local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui

    repeat task.wait() until not PlayerGui:FindFirstChild("LoadingScreen")
    repeat task.wait() until not PlayerGui:FindFirstChild("FinishedLoading")
    wait(0.5)

    _G.nga_link = "https://fingernail-loader.assqwesersed.workers.dev/" -- for skinchanger    
    -- cfg
    local HttpService = game:GetService("HttpService")
    local dir_config = "ad/ad_cfg.cfg"
    local dir_keybinds = "ad/ad_keybinds.cfg"
    local defaultConfig = {
        uiTheme = "Emerald",
        mhud = true,
        input_TargetSurvName = nil,

        showBox = false,
        showName = false,
        showDistance = false,
        showSkeleton = false,
        showHealthBar = false,
        showHealthText = true,
        showTracers = false,
        showBlockCapacity = false,
        showSelectedTag = false,
        tracerToNearPlayer = false,
        showStandNspec = false,
        showAttacks = false,
        saR = 255,
        saB = 255,
        saG = 255,
        
        enableFovChanger = false,

        changeBoxColor = false,
        boxR = 255,
        boxG = 255,
        boxB = 255,

        changeNameColor = false,
        nameR = 255,
        nameG = 255,
        nameB = 255,

        changeDistanceColor = false,
        distanceR = 255,
        distanceG = 255,
        distanceB = 255,

        changeSkeletonColor = false,
        skeletonR = 255,
        skeletonG = 255,
        skeletonB = 255,

        changeTracerColor = false,
        tracerR = 255,
        tracerG = 255,
        tracerB = 255,

        changeSelectedTagColor = false,
        selectedTagR = 255,
        selectedTagG = 255,
        selectedTagB = 255,

        changeMaxVisibilityDistance = false,
        maxVisibilityDistance = 500,
        espFadeByDistance = true,
        espFilledBox = true,
        espFullBox = true,
        espCornerBox = true,
        espAnimatedGradient = true,

        hideUi = false,
        mobileUi = false,
        hidePlayerlist = false,
        hideBlur = false,

        instantBarrage = false,
        instantBarrageR = false,
        instantBarrageHoldDuration = 6,
        enableBoxModify = false,
        shuffleCd = 8,
        shuffleDist = 1.25,
        enableAntiTS = false,
        antiTsType = "Under",
        autoParryEnabled = false,
        autoParryRadius = 10,
        autoParryCooldown = 1,
        autoParryShowRadius = false,
        autoParryRadiusColor = { R = 80, G = 255, B = 120 },
        autoParryRadiusTransparency = 0.55,
        autoParryRadiusYOffset = -1.5,
        autoParryAttacks = {
            "HeavyMarker",
            "Reality Overwrite Punch",
            "Reality Overwriting Punch",
        },
        autoParryBlockSequence = {
            releaseAttack = true,
            releaseInput = "E",
            beforeBlockDelay = 0.45,
            holdDuration = 0.3,
        },
        enableDash = false,
        dashDistance = 20,
        enableSpeedhack = false,
        enableSpeedExploits = false,
        speedExploitsVal = 16,
        meStrafeSpeed = 16,
        meJumpPower = 50,
        enableMobileExploit = false,
        speedhackValue = 3,
        enableFly = false,
        fovValue = 70,
        flySpeed = 80,
        ttpExploit = false,

        SilentAimbotEnabled = false,
        SilentAimbotPrediction = 0.165,
        SilentAimbotBulletDelay = 0,  
        SilentAimbotShowTracer = false,
        SilentAimbotFOV = 999,     

        unlockTimeSkip = false,
        timeSkipAngle = 0.3,

        enableCustomDeathSound = false,
        oldSounds = false,
        oldAnimationsSp = false,
        oldAnimationsBox = false,
        customDeathSound = "...",

        enableAimbot = false,
        aimbotMode = "Target Lock",
        prediction = 0.15,
        circle = false,
        circleRadius = 250,
        Resolution = 1,

        autofarm_farm = false,
        autofarm_sell = false,

        oldCooldowns = false,
        pilotMode = "Free",
        standPilotEnabled = false,
        standPilotSpeed = 50,
        targetLockPredict = 10,
        standOnlyTimeout = 3,
        standPilotUnderground = 15,
        standPilotYPos = 5,
        standPilotWait = 1,

        clocktime = 12,
        Finisher = "None",
        removeBarrage = false,
        changeMap = false,
        leghtink = "...",
        OldWaterTexture = false,
        OldMapTextures = false,
        poseEnabled = false,
        pose = "...",
        itemSkinGloves = "...",

        standAuraEnabled = false,
        standAuraRgb = false,
        standAuraR = 0,
        standAuraG = 0,
        standAuraB = 0
    }

    local defaultKeybinds = {
        OpenMenu = "Delete",
        selectTarget = "C",
        dash = "Tab",
        speedhack = "CapsLock",
        fly = "End",
        aimbot = "LeftAlt",
        standPilot = "P",
        tpToTrgt = "RightAlt",
        tpToDioOverHeaven = "K"
    }

    function mergeDefaults(target, defaults)
        target = type(target) == "table" and target or {}
        for key, value in pairs(defaults) do
            if target[key] == nil then
                target[key] = value
            end
        end
        return target
    end

    function ensureConfigFolder()
        if isfolder and not isfolder("ad") then
            makefolder("ad")
        end
    end

    function loadJsonFile(path)
        if not isfile or not isfile(path) then return nil end
        local ok, data = pcall(function()
            return HttpService:JSONDecode(readfile(path))
        end)
        return ok and data or nil
    end

    function SaveConfig()
        if not writefile then return false end
        ensureConfigFolder()
        local encoded = HttpService:JSONEncode(_G.Config)
        local ok, err = pcall(function()
            writefile(dir_config, encoded)
        end)
        if not ok then
            _G.ConfigSaveError = err
            warn("[CONFIG] Save failed: " .. tostring(err))
            return false
        end

        if readfile and isfile and isfile(dir_config) then
            local verifyOk, saved = pcall(function()
                return readfile(dir_config)
            end)
            if not verifyOk or saved ~= encoded then
                _G.ConfigSaveError = verifyOk and "verification mismatch" or saved
                warn("[CONFIG] Save verification failed: " .. tostring(_G.ConfigSaveError))
                return false
            end
        end

        _G.ConfigSaveError = nil
        return true
    end

    function SaveKeybinds()
        if not writefile then return false end
        ensureConfigFolder()
        local encoded = HttpService:JSONEncode(_G.Keybinds)
        local ok, err = pcall(function()
            writefile(dir_keybinds, encoded)
        end)
        if not ok then
            _G.KeybindSaveError = err
            warn("[KEYBINDS] Save failed: " .. tostring(err))
            return false
        end

        _G.KeybindSaveError = nil
        return true
    end

    function keyCode(name)
        return Enum.KeyCode[_G.Keybinds[name] or defaultKeybinds[name]]
    end


    function getKey(name)
        return keyCode(name)
    end


    _G.Config = mergeDefaults(loadJsonFile(dir_config), defaultConfig)
    _G.Keybinds = mergeDefaults(loadJsonFile(dir_keybinds), defaultKeybinds)

    SaveConfig()
    SaveKeybinds()
    _G.ldr_lddd11 = true
end

do
    local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

if _G.DrawingESP_Cleanup then
    pcall(_G.DrawingESP_Cleanup)
end

pcall(function()
    RunService:UnbindFromRenderStep("DrawingESP_Update")
end)

_G.Settings = _G.Config

local visuals = {}
local playerCache = {}
local removingConnection = nil

local cachedColors = {
    box = Color3.fromRGB(255, 255, 255),
    name = Color3.fromRGB(255, 255, 255),
    distance = Color3.fromRGB(255, 255, 255),
    skeleton = Color3.fromRGB(255, 255, 255),
    tracer = Color3.fromRGB(255, 255, 255),
    selectedTag = Color3.fromRGB(255, 255, 255),
}

local function updateCachedColors()
    local cfg = _G.Config
    if cfg.changeBoxColor then
        cachedColors.box = Color3.fromRGB(
            math.clamp(math.floor(cfg.boxR or 255), 0, 255),
            math.clamp(math.floor(cfg.boxG or 255), 0, 255),
            math.clamp(math.floor(cfg.boxB or 255), 0, 255)
        )
    else
        cachedColors.box = Color3.fromRGB(255, 255, 255)
    end
    if cfg.changeNameColor then
        cachedColors.name = Color3.fromRGB(
            math.clamp(math.floor(cfg.nameR or 255), 0, 255),
            math.clamp(math.floor(cfg.nameG or 255), 0, 255),
            math.clamp(math.floor(cfg.nameB or 255), 0, 255)
        )
    else
        cachedColors.name = Color3.fromRGB(255, 255, 255)
    end
    if cfg.changeDistanceColor then
        cachedColors.distance = Color3.fromRGB(
            math.clamp(math.floor(cfg.distanceR or 255), 0, 255),
            math.clamp(math.floor(cfg.distanceG or 255), 0, 255),
            math.clamp(math.floor(cfg.distanceB or 255), 0, 255)
        )
    else
        cachedColors.distance = Color3.fromRGB(255, 255, 255)
    end
    if cfg.changeSkeletonColor then
        cachedColors.skeleton = Color3.fromRGB(
            math.clamp(math.floor(cfg.skeletonR or 255), 0, 255),
            math.clamp(math.floor(cfg.skeletonG or 255), 0, 255),
            math.clamp(math.floor(cfg.skeletonB or 255), 0, 255)
        )
    else
        cachedColors.skeleton = Color3.fromRGB(255, 255, 255)
    end
    if cfg.changeTracerColor then
        cachedColors.tracer = Color3.fromRGB(
            math.clamp(math.floor(cfg.tracerR or 255), 0, 255),
            math.clamp(math.floor(cfg.tracerG or 255), 0, 255),
            math.clamp(math.floor(cfg.tracerB or 255), 0, 255)
        )
    else
        cachedColors.tracer = Color3.fromRGB(255, 255, 255)
    end
    if cfg.changeSelectedTagColor then
        cachedColors.selectedTag = Color3.fromRGB(
            math.clamp(math.floor(cfg.selectedTagR or 255), 0, 255),
            math.clamp(math.floor(cfg.selectedTagG or 255), 0, 255),
            math.clamp(math.floor(cfg.selectedTagB or 255), 0, 255)
        )
    else
        cachedColors.selectedTag = Color3.fromRGB(255, 255, 255)
    end
end
updateCachedColors()

local function makeLine(thickness)
    local line = Drawing.new("Line")
    line.Thickness = thickness or 1
    line.Transparency = 1
    line.Visible = false
    return line
end

local function makeText(size)
    local text = Drawing.new("Text")
    text.Size = size or 14
    text.Center = true
    text.Outline = true
    text.Transparency = 1
    text.Color = Color3.fromRGB(255, 255, 255)
    text.Visible = false
    pcall(function() text.Font = 2 end)
    return text
end

local function makeSquare(filled, thickness)
    local square = Drawing.new("Square")
    square.Filled = filled or false
    square.Thickness = thickness or 1
    square.Transparency = 1
    square.Visible = false
    return square
end

local function makeBoxLines(thickness)
    return {
        topLeftH = makeLine(thickness),
        topLeftV = makeLine(thickness),
        topRightH = makeLine(thickness),
        topRightV = makeLine(thickness),
        bottomLeftH = makeLine(thickness),
        bottomLeftV = makeLine(thickness),
        bottomRightH = makeLine(thickness),
        bottomRightV = makeLine(thickness)
    }
end

local function makeVisual()
    return {
        boxFill = makeSquare(true, 1),
        boxFull = makeSquare(false, 1),
        box = makeBoxLines(1.5),
        boxShadow = makeBoxLines(3),
        name = makeText(13),
        distance = makeText(12),
        selectedTag = makeText(12),
        healthBack = makeLine(4),
        healthFill = makeLine(3),
        healthText = makeText(11),
        tracer = makeLine(1.5),
        skeleton = {}
    }
end

local function removeDrawing(obj)
    if obj then pcall(function() obj:Remove() end) end
end

local function hideVisual(v)
    v.boxFill.Visible = false
    v.boxFull.Visible = false
    for _, line in pairs(v.box) do line.Visible = false end
    for _, line in pairs(v.boxShadow) do line.Visible = false end
    v.name.Visible = false
    v.distance.Visible = false
    v.selectedTag.Visible = false
    v.healthBack.Visible = false
    v.healthFill.Visible = false
    v.healthText.Visible = false
    v.tracer.Visible = false
    for _, line in pairs(v.skeleton) do line.Visible = false end
end

local function cleanupPlayer(player)
    local v = visuals[player]
    if not v then return end
    removeDrawing(v.boxFill)
    removeDrawing(v.boxFull)
    for _, line in pairs(v.box) do removeDrawing(line) end
    for _, line in pairs(v.boxShadow) do removeDrawing(line) end
    removeDrawing(v.name)
    removeDrawing(v.distance)
    removeDrawing(v.selectedTag)
    removeDrawing(v.healthBack)
    removeDrawing(v.healthFill)
    removeDrawing(v.healthText)
    removeDrawing(v.tracer)
    for _, line in pairs(v.skeleton) do removeDrawing(line) end
    visuals[player] = nil
    playerCache[player] = nil
end

local function getVisual(player)
    if not visuals[player] then
        visuals[player] = makeVisual()
    end
    return visuals[player]
end

local bodyPartNames = {
    "Head", "UpperTorso", "LowerTorso", "Torso",
    "Left Arm", "Right Arm", "Left Leg", "Right Leg",
    "LeftUpperArm", "LeftLowerArm", "LeftHand",
    "RightUpperArm", "RightLowerArm", "RightHand",
    "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
    "RightUpperLeg", "RightLowerLeg", "RightFoot"
}

local fallbackMap = {
    UpperTorso = "Torso",
    LowerTorso = "UpperTorso",
    LeftUpperArm = "Left Arm",
    LeftLowerArm = "LeftUpperArm",
    LeftHand = "LeftLowerArm",
    RightUpperArm = "Right Arm",
    RightLowerArm = "RightUpperArm",
    RightHand = "RightLowerArm",
    LeftUpperLeg = "Left Leg",
    LeftLowerLeg = "LeftUpperLeg",
    LeftFoot = "LeftLowerLeg",
    RightUpperLeg = "Right Leg",
    RightLowerLeg = "RightUpperLeg",
    RightFoot = "RightLowerLeg"
}

local function cacheCharacterParts(player, character)
    local root = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not root or not humanoid then return end

    local parts = {}
    for _, name in ipairs(bodyPartNames) do
        local part = character:FindFirstChild(name)
        if not part and fallbackMap[name] then
            part = character:FindFirstChild(fallbackMap[name])
        end
        if not part and fallbackMap[fallbackMap[name]] then
            part = character:FindFirstChild(fallbackMap[fallbackMap[name]])
        end
        if part and part:IsA("BasePart") then
            parts[name] = part
        end
    end

    playerCache[player] = {
        character = character,
        root = root,
        humanoid = humanoid,
        parts = parts
    }
end

local bodyBoundsOrder = {
    "Head", "UpperTorso", "LowerTorso", "Torso",
    "Left Arm", "Right Arm", "Left Leg", "Right Leg",
    "LeftUpperArm", "LeftLowerArm", "LeftHand",
    "RightUpperArm", "RightLowerArm", "RightHand",
    "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
    "RightUpperLeg", "RightLowerLeg", "RightFoot"
}

local function includePartBounds(camera, part, bounds)
    local half = part.Size * 0.5
    local cf = part.CFrame
    local points = {
        Vector3.new(-half.X, -half.Y, -half.Z),
        Vector3.new(-half.X, -half.Y, half.Z),
        Vector3.new(-half.X, half.Y, -half.Z),
        Vector3.new(-half.X, half.Y, half.Z),
        Vector3.new(half.X, -half.Y, -half.Z),
        Vector3.new(half.X, -half.Y, half.Z),
        Vector3.new(half.X, half.Y, -half.Z),
        Vector3.new(half.X, half.Y, half.Z)
    }

    for _, point in ipairs(points) do
        local screen = camera:WorldToViewportPoint(cf:PointToWorldSpace(point))
        if screen.Z > 0 then
            bounds.minX = math.min(bounds.minX, screen.X)
            bounds.minY = math.min(bounds.minY, screen.Y)
            bounds.maxX = math.max(bounds.maxX, screen.X)
            bounds.maxY = math.max(bounds.maxY, screen.Y)
        end
    end
end

local function getBodyBounds(camera, parts)
    local bounds = {
        minX = math.huge,
        minY = math.huge,
        maxX = -math.huge,
        maxY = -math.huge
    }

    for _, name in ipairs(bodyBoundsOrder) do
        local part = parts[name]
        if part and part.Parent and part:IsA("BasePart") then
            includePartBounds(camera, part, bounds)
        end
    end

    if bounds.minX == math.huge then return nil end

    local padX = math.clamp((bounds.maxX - bounds.minX) * 0.035, 2, 7)
    local padY = math.clamp((bounds.maxY - bounds.minY) * 0.025, 2, 6)
    return bounds.minX - padX, bounds.minY - padY, bounds.maxX + padX, bounds.maxY + padY
end

local function worldToScreen(camera, part)
    if not part then return nil end
    local screen, visible = camera:WorldToViewportPoint(part.Position)
    if not visible or screen.Z <= 0 then return nil end
    return Vector2.new(screen.X, screen.Y)
end

local function getOrCreateSkeletonLine(v, name)
    if not v.skeleton[name] then
        v.skeleton[name] = makeLine(1)
    end
    return v.skeleton[name]
end

local function drawSkeletonLine(camera, v, color, name, aPart, bPart)
    local line = getOrCreateSkeletonLine(v, name)
    local a = worldToScreen(camera, aPart)
    local b = worldToScreen(camera, bPart)
    if a and b then
        line.From = a
        line.To = b
        line.Color = color
        line.Transparency = 0.85
        line.Visible = true
    else
        line.Visible = false
    end
end

local function setLine(line, from, to, color, transparency)
    line.From = from
    line.To = to
    line.Color = color
    line.Transparency = transparency or 1
    line.Visible = true
end

local function drawCornerBox(lines, minX, minY, maxX, maxY, color, transparency, offset)
    offset = offset or 0
    local width = maxX - minX
    local height = maxY - minY
    local corner = math.clamp(math.min(width, height) * 0.28, 8, 18)
    local left = minX - offset
    local right = maxX + offset
    local top = minY - offset
    local bottom = maxY + offset

    setLine(lines.topLeftH, Vector2.new(left, top), Vector2.new(left + corner, top), color, transparency)
    setLine(lines.topLeftV, Vector2.new(left, top), Vector2.new(left, top + corner), color, transparency)
    setLine(lines.topRightH, Vector2.new(right - corner, top), Vector2.new(right, top), color, transparency)
    setLine(lines.topRightV, Vector2.new(right, top), Vector2.new(right, top + corner), color, transparency)
    setLine(lines.bottomLeftH, Vector2.new(left, bottom), Vector2.new(left + corner, bottom), color, transparency)
    setLine(lines.bottomLeftV, Vector2.new(left, bottom - corner), Vector2.new(left, bottom), color, transparency)
    setLine(lines.bottomRightH, Vector2.new(right - corner, bottom), Vector2.new(right, bottom), color, transparency)
    setLine(lines.bottomRightV, Vector2.new(right, bottom - corner), Vector2.new(right, bottom), color, transparency)
end

local function drawSkeleton(camera, parts, v)
    if not _G.Config.showSkeleton then
        for _, line in pairs(v.skeleton) do line.Visible = false end
        return
    end

    local head = parts.Head
    local torso = parts.UpperTorso or parts.Torso
    local lowerTorso = parts.LowerTorso or torso
    local color = cachedColors.skeleton

    if head and torso then
        drawSkeletonLine(camera, v, color, "headTorso", head, torso)
    end
    if torso and lowerTorso then
        drawSkeletonLine(camera, v, color, "torsoLower", torso, lowerTorso)
    end

    local function drawArm(side)
        local upper = parts[side .. "UpperArm"]
        local lower = parts[side .. "LowerArm"]
        local hand = parts[side .. "Hand"]
        if torso and upper then drawSkeletonLine(camera, v, color, side .. "Arm1", torso, upper) end
        if upper and lower then drawSkeletonLine(camera, v, color, side .. "Arm2", upper, lower) end
        if lower and hand then drawSkeletonLine(camera, v, color, side .. "Arm3", lower, hand) end
    end

    local function drawLeg(side)
        local upper = parts[side .. "UpperLeg"]
        local lower = parts[side .. "LowerLeg"]
        local foot = parts[side .. "Foot"]
        if lowerTorso and upper then drawSkeletonLine(camera, v, color, side .. "Leg1", lowerTorso, upper) end
        if upper and lower then drawSkeletonLine(camera, v, color, side .. "Leg2", upper, lower) end
        if lower and foot then drawSkeletonLine(camera, v, color, side .. "Leg3", lower, foot) end
    end

    drawArm("Left")
    drawArm("Right")
    drawLeg("Left")
    drawLeg("Right")
end

local function updatePlayer(camera, player, nearestPlayer)
    local cache = playerCache[player]
    if not cache then
        local char = player.Character
        if char then
            cacheCharacterParts(player, char)
            cache = playerCache[player]
        end
        if not cache then return end
    end

    local character = cache.character
    local root = cache.root
    local humanoid = cache.humanoid
    local parts = cache.parts

    if not root or not humanoid or not root.Parent or humanoid.Health <= 0 then
        local v = visuals[player]
        if v then hideVisual(v) end
        return
    end

    local v = getVisual(player)

    pcall(function() humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None end)

    local offset = camera.CFrame.Position - root.Position
    local distSquared = offset.X * offset.X + offset.Y * offset.Y + offset.Z * offset.Z
    local maxDist = _G.Config.changeMaxVisibilityDistance and _G.Config.maxVisibilityDistance or math.huge
    if distSquared > maxDist * maxDist then
        hideVisual(v)
        return
    end

    local minX, minY, maxX, maxY = getBodyBounds(camera, parts)
    if not minX then
        hideVisual(v)
        return
    end

    -- Box
    if _G.Config.showBox then
        drawCornerBox(v.boxShadow, minX, minY, maxX, maxY, Color3.fromRGB(0, 0, 0), 0.55, 1)
        drawCornerBox(v.box, minX, minY, maxX, maxY, cachedColors.box, 0.95, 0)
    else
        for _, line in pairs(v.box) do line.Visible = false end
        for _, line in pairs(v.boxShadow) do line.Visible = false end
    end

    -- Name
    if _G.Config.showName then
        v.name.Text = player.Name
        v.name.Position = Vector2.new((minX + maxX) * 0.5, minY - 18)
        v.name.Color = cachedColors.name
        v.name.Transparency = 0.95
        v.name.Visible = true
    else
        v.name.Visible = false
    end

    -- Distance
    if _G.Config.showDistance then
        local distance = math.sqrt(distSquared)
        v.distance.Text = string.format("%dm", math.floor(distance))
        v.distance.Position = Vector2.new((minX + maxX) * 0.5, maxY + 4)
        v.distance.Color = cachedColors.distance
        v.distance.Transparency = 0.9
        v.distance.Visible = true
    else
        v.distance.Visible = false
    end

    -- Selected Tag
    if _G.Config.showSelectedTag and _G.Config.input_TargetSurvName == player.Name then
        v.selectedTag.Text = "SELECTED"
        v.selectedTag.Position = Vector2.new((minX + maxX) * 0.5, maxY + 18)
        v.selectedTag.Color = cachedColors.selectedTag
        v.selectedTag.Transparency = 0.95
        v.selectedTag.Visible = true
    else
        v.selectedTag.Visible = false
    end

    -- Health Bar
    if _G.Config.showHealthBar then
        local ratio = math.clamp(humanoid.Health / math.max(humanoid.MaxHealth, 1), 0, 1)
        local height = maxY - minY
        local fillHeight = height * ratio
        local x = minX - 6
        v.healthBack.From = Vector2.new(x, minY)
        v.healthBack.To = Vector2.new(x, maxY)
        v.healthBack.Color = Color3.fromRGB(0, 0, 0)
        v.healthBack.Transparency = 0.55
        v.healthBack.Visible = true
        v.healthFill.From = Vector2.new(x, maxY - fillHeight)
        v.healthFill.To = Vector2.new(x, maxY)
        v.healthFill.Color = Color3.fromRGB(
            math.clamp(math.floor(255 * (1 - ratio) * 2), 0, 255),
            math.clamp(math.floor(255 * ratio * 2), 0, 255),
            0
        )
        v.healthFill.Transparency = 0.95
        v.healthFill.Visible = true
    else
        v.healthBack.Visible = false
        v.healthFill.Visible = false
    end

    -- Tracers
    if _G.Config.showTracers and (not _G.Config.tracerToNearPlayer or nearestPlayer == player) then
        local viewport = camera.ViewportSize
        v.tracer.From = Vector2.new(viewport.X * 0.5, viewport.Y)
        v.tracer.To = Vector2.new((minX + maxX) * 0.5, maxY)
        v.tracer.Color = cachedColors.tracer
        v.tracer.Transparency = 0.75
        v.tracer.Visible = true
    else
        v.tracer.Visible = false
    end

    -- Skeleton
    if _G.Config.showSkeleton then
        drawSkeleton(camera, parts, v)
    else
        for _, line in pairs(v.skeleton) do line.Visible = false end
    end
end

local playerList = {}
local function updatePlayerList()
    local newList = Players:GetPlayers()
    playerList = newList
end
updatePlayerList()
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(function(player)
    cleanupPlayer(player)
    updatePlayerList()
end)

local function getNearestPlayer(camera)
    local nearest, nearestDistSq = nil, math.huge
    for _, player in ipairs(playerList) do
        if player ~= LocalPlayer then
            local cache = playerCache[player]
            if cache and cache.root and cache.humanoid and cache.humanoid.Health > 0 then
                local offset = camera.CFrame.Position - cache.root.Position
                local distSq = offset.X * offset.X + offset.Y * offset.Y + offset.Z * offset.Z
                if distSq < nearestDistSq then
                    nearestDistSq = distSq
                    nearest = player
                end
            end
        end
    end
    return nearest
end

local frameCount = 0
local function updateEsp()
    local camera = workspace.CurrentCamera
    if not camera then return end

    frameCount = frameCount + 1

    updateCachedColors()

    local nearestPlayer = _G.Config.tracerToNearPlayer and getNearestPlayer(camera) or nil

    for _, player in ipairs(playerList) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char then
                local cache = playerCache[player]
                if not cache or cache.character ~= char then
                    cacheCharacterParts(player, char)
                end
            end
            updatePlayer(camera, player, nearestPlayer)
        end
    end

    for player in pairs(visuals) do
        if not Players:FindFirstChild(player.Name) then
            cleanupPlayer(player)
        end
    end
end

local TweenService = game:GetService("TweenService")
local livingFolder = workspace:WaitForChild("Living")
local function setupCharacter(character)
	if not character:IsA("Model") then
		return
	end

	local blockingCapacity = character:FindFirstChild("Blocking_Capacity") or character:WaitForChild("Blocking_Capacity", 5)
	if not blockingCapacity then
		return
	end

	local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
	local head = character:FindFirstChild("Head")
	local adorneePart = rootPart or head
	if not adorneePart then
		return
	end

	local billboard = nil
	local textLabel = nil
	local imageLabel = nil
	local container = nil
	local currentTween = nil
	local isVisible = false
	local pendingValue = nil
	local animateChange = nil

	local function formatValue(value)
		return string.format("%.1f", value)
	end

	local function removeDisplay()
		if billboard then
			local fadeOut = TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				GroupTransparency = 1
			})
			fadeOut:Play()
			fadeOut.Completed:Connect(function()
				if billboard then
					billboard:Destroy()
					billboard = nil
					textLabel = nil
					imageLabel = nil
					container = nil
					isVisible = false
				end
			end)
		end
	end

	local function createDisplay()
		if billboard then
			return
		end

		billboard = Instance.new("BillboardGui")
		billboard.Name = "BlockingGui"
		billboard.Size = UDim2.new(0, 92, 0, 24)
		billboard.AlwaysOnTop = true
		billboard.Adornee = adorneePart
		billboard.Parent = adorneePart
		billboard.StudsOffset = Vector3.new(0, -4, 0)

		container = Instance.new("CanvasGroup")
		container.Name = "Container"
		container.Size = UDim2.new(1, 0, 1, 0)
		container.BackgroundTransparency = 1
		container.GroupTransparency = 1
		container.Parent = billboard

		imageLabel = Instance.new("ImageLabel")
		imageLabel.Name = "Icon"
		imageLabel.Size = UDim2.new(0, 18, 0, 18)
		imageLabel.Position = UDim2.new(0.22, -2, 0.5, -9)
		imageLabel.BackgroundTransparency = 1
		imageLabel.Image = "rbxassetid://137969276475561"
		imageLabel.ScaleType = Enum.ScaleType.Fit
		imageLabel.Parent = container

		textLabel = Instance.new("TextLabel")
		textLabel.Name = "TextLabel"
		textLabel.Size = UDim2.new(0.5, 0, 1, 0)
		textLabel.Position = UDim2.new(0.5, 2, 0, 0)
		textLabel.BackgroundTransparency = 1
		textLabel.TextColor3 = Color3.fromRGB(235, 238, 245)
		textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		textLabel.TextStrokeTransparency = 0.35
		textLabel.TextSize = 13
		textLabel.Font = Enum.Font.GothamMedium
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.Parent = container
	end

	local function showDisplay(value)
		if not _G.Config or not _G.Config.showBlockCapacity then
			pendingValue = value
			return
		end
		
		if not billboard then
			createDisplay()
			textLabel.Text = formatValue(value)
			local fadeIn = TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				GroupTransparency = 0
			})
			fadeIn:Play()
			isVisible = true
		else
			animateChange(value)
		end
	end

	animateChange = function(newValue)
		if not textLabel then
			return
		end

		if currentTween then
			currentTween:Cancel()
		end

		local hideInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local hideTween = TweenService:Create(textLabel, hideInfo, {
			TextTransparency = 1,
			TextStrokeTransparency = 1
		})
		hideTween:Play()

		hideTween.Completed:Connect(function()
			if not textLabel then
				return
			end

			textLabel.Text = formatValue(newValue)
			textLabel.Position = UDim2.new(0.5, 2, 0.3, 0)

			local showInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			currentTween = TweenService:Create(textLabel, showInfo, {
				TextTransparency = 0,
				TextStrokeTransparency = 0.5,
				Position = UDim2.new(0.5, 2, 0, 0)
			})
			currentTween:Play()
		end)
	end

	local function updateDisplay()
		local value = blockingCapacity.Value
		local configEnabled = _G.Config and _G.Config.showBlockCapacity

		if value <= 0 or not configEnabled then
			if isVisible then
				removeDisplay()
			end
			if value > 0 and not configEnabled then
				pendingValue = value
			end
		else
			showDisplay(value)
		end
	end

	task.spawn(function()
		while true do
			task.wait(0.5)
			local configEnabled = _G.Config and _G.Config.showBlockCapacity
			if configEnabled and pendingValue and not isVisible then
				showDisplay(pendingValue)
				pendingValue = nil
			elseif not configEnabled and isVisible then
				removeDisplay()
			end
		end
	end)
    pcall(function()
	blockingCapacity:GetPropertyChangedSignal("Value"):Connect(updateDisplay)
	updateDisplay()
    end)
end

for _, character in ipairs(livingFolder:GetChildren()) do
    task.spawn(setupCharacter, character)
end

livingFolder.ChildAdded:Connect(function(character)
    task.spawn(setupCharacter, character)
end)

RunService:BindToRenderStep("DrawingESP_Update", Enum.RenderPriority.Camera.Value + 1, updateEsp)

removingConnection = Players.PlayerRemoving:Connect(cleanupPlayer)

_G.DrawingESP_Cleanup = function()
    pcall(function() RunService:UnbindFromRenderStep("DrawingESP_Update") end)
    if removingConnection then removingConnection:Disconnect(); removingConnection = nil end
    for player in pairs(visuals) do cleanupPlayer(player) end
end
end

do
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Camera = workspace.CurrentCamera
local functionsConnections = {}
local speedhackConnection = nil
local flyConnection = nil
local flyActive = false
local flyVelocity = nil
local holdingAimbot = false
local lockedTarget = nil
local standPilotActive = false
local standPilotConns = {}

function addFunctionConnection(conn)
    table.insert(functionsConnections, conn)
    return conn
end

function getCharacterParts()
    local char = LocalPlayer.Character
    if not char then return nil end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    return char, hum, root
end

function instantTp(targetCFrame)
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    local anchoredParts = {}
    local collisionStates = {}

    hrp.Anchored = true
    hrp.CanCollide = false


    local start = hrp.CFrame
    local delta = targetCFrame.Position - start.Position
    local maxStep = 24
    local steps = math.max(1, math.ceil(delta.Magnitude / maxStep))

    for i = 1, steps do
        local pos
        if delta.Magnitude > 0 then
            pos = start.Position + delta.Unit * math.min(maxStep * i, delta.Magnitude)
        else
            pos = start.Position
        end
        pos = Vector3.new(pos.X, start.Position.Y + delta.Y * (i / steps), pos.Z)
        hrp.CFrame = CFrame.new(pos) * targetCFrame.Rotation
        RunService.Stepped:Wait()
    end

    task.wait(0.02)

    hrp.Anchored = false
    hrp.CanCollide = true
end

function findTargetByName(name)
    if not name or name == "" then return nil end

    local playerTarget = Players:FindFirstChild(name)
    if playerTarget then
        return playerTarget
    end

    local living = workspace:FindFirstChild("Living")
    if living then
        return living:FindFirstChild(name)
    end

    return nil
end

function getTargetCharacter(target)
    if not target then return nil end
    if target:IsA("Player") then
        return target.Character
    end
    if target:IsA("Model") then
        return target
    end
    return nil
end

function getTargetRoot(target)
    local char = getTargetCharacter(target)
    return char and char:FindFirstChild("HumanoidRootPart")
end

function findTargetInCircle()
    local currentCamera = workspace.CurrentCamera
    if not currentCamera or not _G.q_circle then return nil end
    local closestTarget = nil
    local smallestDistance = _G.q_circle.Radius

    for _, playerTarget in ipairs(Players:GetPlayers()) do
        if playerTarget ~= LocalPlayer and playerTarget.Character then
            local hrp = playerTarget.Character:FindFirstChild("HumanoidRootPart")
            local hum = playerTarget.Character:FindFirstChildOfClass("Humanoid")

            if hrp and hum and hum.Health > 0 then
                local screenPos, onScreen = currentCamera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - _G.q_circle.Position).Magnitude
                    if dist <= _G.q_circle.Radius and dist < smallestDistance then
                        smallestDistance = dist
                        closestTarget = playerTarget
                    end
                end
            end
        end
    end

    local living = workspace:FindFirstChild("Living")
    if living then
        for _, npc in ipairs(living:GetChildren()) do
            if npc.Name ~= LocalPlayer.Name then
                local hrp = npc:FindFirstChild("HumanoidRootPart")
                local hum = npc:FindFirstChildOfClass("Humanoid")

                if hrp and hum and hum.Health > 0 then
                    local screenPos, onScreen = currentCamera:WorldToViewportPoint(hrp.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - _G.q_circle.Position).Magnitude
                        if dist <= _G.q_circle.Radius and dist < smallestDistance then
                            smallestDistance = dist
                            closestTarget = npc
                        end
                    end
                end
            end
        end
    end

    return closestTarget and closestTarget.Name or _G.Config.input_TargetSurvName
end

function getMoveDirection(char, hum, root)
    local moveDir = hum and hum.MoveDirection or Vector3.zero
    if moveDir.Magnitude == 0 and root then
        moveDir = root.CFrame.LookVector
    end
    moveDir = Vector3.new(moveDir.X, 0, moveDir.Z)
    if moveDir.Magnitude == 0 then return nil end
    return moveDir.Unit
end

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local canDash = true
function dash()
    local character = Player.Character or Player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not canDash or not rootPart or not humanoid or humanoid.Health <= 0 then return end

    canDash = false
    local Camera = workspace.CurrentCamera
    local LookVector = Camera.CFrame.LookVector * Vector3.new(1, 0, 1).Unit
    local offset = LookVector * _G.Config.dashDistance
    --RootPart.Velocity = Vector3.new(0, 20, 0)
    rootPart.Anchored = true
    task.wait(0.01)
    character:PivotTo(character:GetPivot() + offset)
    rootPart.Anchored = false
    canDash = true
end

function speedhackStep()
    if not _G.Config.enableSpeedhack then return end
    local char, hum, root = getCharacterParts()
    if not char or not hum or not root or hum.Health <= 0 then return end

    local dir = getMoveDirection(char, hum, root)
    if not dir then return end

    local distance = _G.Config.speedhackValue
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = { char }
    params.FilterType = Enum.RaycastFilterType.Blacklist

    local hit = workspace:Raycast(root.Position, dir * distance, params)
    local targetPos = hit and (hit.Position - dir * 2) or (root.Position + dir * distance)
    root.CFrame = CFrame.new(targetPos, targetPos + dir)
end

function stopSpeedhack()
    if speedhackConnection then
        speedhackConnection:Disconnect()
        speedhackConnection = nil
    end
end

function startSpeedhack()
    if speedhackConnection then return end
    speedhackConnection = RunService.Heartbeat:Connect(speedhackStep)
end

function stopFly()
    flyActive = false
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    if flyVelocity then
        flyVelocity:Destroy()
        flyVelocity = nil
    end
    local _, hum = getCharacterParts()
    if hum then
        hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
        hum:ChangeState(Enum.HumanoidStateType.Landed)
    end
end

function toggleFly()
    if not _G.Config.enableFly then return end

    if flyActive then
        stopFly()
        return
    end

    local _, hum, root = getCharacterParts()
    if not hum or not root then return end

    flyActive = true
    flyVelocity = Instance.new("BodyVelocity")
    flyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    flyVelocity.Velocity = Vector3.zero
    flyVelocity.P = 1000
    flyVelocity.Parent = root

    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    hum:ChangeState(Enum.HumanoidStateType.Flying)

    flyConnection = RunService.Heartbeat:Connect(function()
        if not flyActive or not flyVelocity then return end
        local cam = workspace.CurrentCamera
        local direction = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then direction = direction - Vector3.new(0, 1, 0) end

        flyVelocity.Velocity = direction.Magnitude > 0 and direction.Unit * _G.Config.flySpeed or Vector3.zero
    end)
end

function tpToSelectedTarget()
    local target = findTargetByName(_G.Config.input_TargetSurvName)
    local root = getTargetRoot(target)
    if not root then return end
    instantTp(root.CFrame * CFrame.new(0, 0, 3))
end

function getAimbotTarget()
    return findTargetByName(_G.Config.input_TargetSurvName)
end

function targetHead(target)
    local char = getTargetCharacter(target)
    if not char then return nil end
    return char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
end

function aimAtTarget()
    if not _G.Config.enableAimbot or _G.Config.aimbotMode ~= "Target Lock" then return end
    if not holdingAimbot then return end

    local cam = workspace.CurrentCamera
    local part = targetHead(getAimbotTarget())
    if not part then return end

    local camPos = cam.CFrame.Position
    local targetPos = part.Position + (part.AssemblyLinearVelocity or Vector3.zero) * _G.Config.prediction
    local dir = targetPos - camPos
    cam.CFrame = CFrame.new(camPos, camPos + dir)
end

function uninstallSilentAimbot()
end

function installSilentAimbot()
    return true
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local standPilotActive = false

local megaConn
local camConn
local noclipConn
local mouseConn

local cameraAngleX = 0
local cameraAngleY = 0

local standY = 0
local standPos = Vector3.new(0, 0, 0) 
local playerVelocityY = 0
local isJumping = false
local jumpCooldown = 0
local previousCameraType = nil
local previousCameraSubject = nil

local targetLastPos = nil
local targetVelocity = Vector3.new(0, 0, 0)
local targetSmoothFactor = 0.15


function getStandPilotCharacterParts()
    local char = LocalPlayer.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    return char, nil, root
end


function getGroundHeight(pos)
    local rayOrigin = pos + Vector3.new(0, 5, 0)
    local rayDirection = Vector3.new(0, -50, 0)

    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist

    local ignoreList = {LocalPlayer.Character}
    local living = Workspace:FindFirstChild("Living")

    if living then
        for _, obj in ipairs(living:GetChildren()) do
            if obj:IsA("Model") then
                table.insert(ignoreList, obj)
            end
        end
    end

    rayParams.FilterDescendantsInstances = ignoreList

    local rayResult = Workspace:Raycast(rayOrigin, rayDirection, rayParams)

    if rayResult then
        return rayResult.Position.Y
    end

    return pos.Y
end


function getStandPilotTargetRoot()
    if not _G.Config.input_TargetSurvName then
        return nil
    end

    local living = Workspace:FindFirstChild("Living")
    if not living then return nil end

    local target = living:FindFirstChild(_G.Config.input_TargetSurvName)
    if not target then return nil end

    return target:FindFirstChild("HumanoidRootPart")
end


function startStandPilot()
    if standPilotActive then
        stopStandPilot()
        return
    end

    local char, _, root = getStandPilotCharacterParts()
    if not char or not root then return end

    local living = Workspace:FindFirstChild("Living")
    if not living then return end

    local stand = living:FindFirstChild(LocalPlayer.Name)
    if not stand then return end

    local standMorph = stand:FindFirstChild("StandMorph")
    if not standMorph then return end

    local standRoot = standMorph:FindFirstChild("HumanoidRootPart")
    if not standRoot then return end

    standPilotActive = true

    targetLastPos = nil
    targetVelocity = Vector3.new(0, 0, 0)

    standPos = root.Position + Vector3.new(0, _G.Config.standPilotUnderground, 0)
    standY = standPos.Y

    playerVelocityY = 0
    isJumping = false
    jumpCooldown = 0

    local cam = Workspace.CurrentCamera
    if cam then
        cameraAngleX = math.atan2(cam.CFrame.LookVector.Z, cam.CFrame.LookVector.X)
        cameraAngleY = math.asin(cam.CFrame.LookVector.Y)
    end

    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter

    mouseConn = UserInputService.InputChanged:Connect(function(input)
        if not standPilotActive then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Delta
            cameraAngleX = cameraAngleX + delta.X * 0.003
            cameraAngleY = math.clamp(cameraAngleY - delta.Y * 0.003, -1.4, 1.4)
        end
    end)

    local initialLook = root.CFrame.LookVector * Vector3.new(1, 0, 1)
    if initialLook.Magnitude <= 0 then
        initialLook = Vector3.new(0, 0, -1)
    else
        initialLook = initialLook.Unit
    end

    standRoot.CFrame = CFrame.lookAt(standPos, standPos + initialLook)
    root.CFrame = CFrame.new(standPos.X, standY - _G.Config.standPilotUnderground, standPos.Z)

    noclipConn = RunService.Stepped:Connect(function()
        if not standPilotActive then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)

    local currentCamera = Workspace.CurrentCamera
    if currentCamera then
        previousCameraType = currentCamera.CameraType
        previousCameraSubject = currentCamera.CameraSubject
        currentCamera.CameraType = Enum.CameraType.Scriptable
    end

    camConn = RunService.RenderStepped:Connect(function()
        if not standPilotActive then return end
        local currentCam = Workspace.CurrentCamera
        if currentCam and standRoot and standRoot.Parent then
            local lookDir = Vector3.new(
                math.cos(cameraAngleY) * math.cos(cameraAngleX),
                math.sin(cameraAngleY),
                math.cos(cameraAngleY) * math.sin(cameraAngleX)
            )
            local cameraFocusPos = standRoot.Position
            local camPos = cameraFocusPos + Vector3.new(0, 4, 0) - lookDir * 12
            currentCam.CFrame = CFrame.lookAt(camPos, camPos + lookDir)
        end
    end)

    megaConn = RunService.RenderStepped:Connect(function(dt)
        if not standPilotActive then return end
        if not standRoot or not standRoot.Parent then
            stopStandPilot()
            return
        end
        if not root or not root.Parent then
            stopStandPilot()
            return
        end

        local camLook = Vector3.new(math.cos(cameraAngleX), 0, math.sin(cameraAngleX))
        local camRight = Vector3.new(-camLook.Z, 0, camLook.X)

        if _G.Config.pilotMode == "Target Lock" then
            local targetRoot = getStandPilotTargetRoot()
            if targetRoot then
                local targetPos = targetRoot.Position

                if targetLastPos then
                    local rawVelocity = (targetPos - targetLastPos) / dt
                    targetVelocity = targetVelocity:Lerp(rawVelocity, targetSmoothFactor)
                end
                targetLastPos = targetPos

                local predictedPos = targetPos + targetVelocity * 0.5
                local predictOffset = predictedPos - targetPos
                if predictOffset.Magnitude > _G.Config.targetLockPredict then
                    predictedPos = targetPos + predictOffset.Unit * _G.Config.targetLockPredict
                end

                standPos = Vector3.new(predictedPos.X, predictedPos.Y + _G.Config.standPilotYPos, predictedPos.Z)
                standY = standPos.Y

                standRoot.CFrame = CFrame.lookAt(standPos, standPos + camLook)
                root.CFrame = CFrame.new(standPos.X, standY - _G.Config.standPilotUnderground, standPos.Z)
            end
            return
        end

        local moveDir = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDir += camLook
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDir -= camLook
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDir -= camRight
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDir += camRight
        end

        local speed = _G.Config.standPilotSpeed or 50

        if moveDir.Magnitude > 0 then
            moveDir = moveDir.Unit
            standPos = standPos + moveDir * speed * dt
        end

        local noclipMode = UserInputService:IsKeyDown(Enum.KeyCode.E)

        if not noclipMode then
            local groundY = getGroundHeight(standPos)
            local targetY = groundY + _G.Config.standPilotYPos

            if jumpCooldown > 0 then
                jumpCooldown = jumpCooldown - dt
            end

            local spaceHeld = UserInputService:IsKeyDown(Enum.KeyCode.Space)

            if spaceHeld and not isJumping and jumpCooldown <= 0 and standY <= targetY + 1 then
                playerVelocityY = 40
                isJumping = true
                jumpCooldown = 1
            end

            if isJumping then
                playerVelocityY = playerVelocityY - 100 * dt
                standY = standY + playerVelocityY * dt

                if standY <= targetY then
                    standY = targetY
                    playerVelocityY = 0
                    isJumping = false
                end
            else
                if standY > targetY then
                    standY = standY - 60 * dt
                    if standY < targetY then
                        standY = targetY
                    end
                else
                    standY = targetY
                end
            end
        end

        local finalPos = Vector3.new(standPos.X, standY, standPos.Z)

        standRoot.CFrame = CFrame.lookAt(finalPos, finalPos + camLook)
        root.CFrame = CFrame.new(standPos.X, standY - _G.Config.standPilotUnderground, standPos.Z)
    end)
end


function stopStandPilot()
    standPilotActive = false

    UserInputService.MouseBehavior = Enum.MouseBehavior.Default

    targetLastPos = nil
    targetVelocity = Vector3.new(0, 0, 0)

    if megaConn then
        megaConn:Disconnect()
        megaConn = nil
    end

    if noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end

    if camConn then
        camConn:Disconnect()
        camConn = nil
    end

    if mouseConn then
        mouseConn:Disconnect()
        mouseConn = nil
    end

    local char = LocalPlayer.Character
    char.HumanoidRootPart.CanCollide = true

    local cam = Workspace.CurrentCamera

    if cam then
        cam.CameraType = previousCameraType or Enum.CameraType.Custom

        if previousCameraSubject then
            cam.CameraSubject = previousCameraSubject
        elseif char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                cam.CameraSubject = hum
            end
        end
    end

    previousCameraType = nil
    previousCameraSubject = nil
end

function tpToDioOH()
    local args = {
        "EndDialogue",
        {
            Option = "Option1",
            Dialogue = "Dialogue8",
            NPC = "Path to Heaven"
        }
    }
    game:GetService("Players").LocalPlayer.Character:WaitForChild("RemoteEvent"):FireServer(unpack(args))
end

_G.autoFarm = false
_G.Farm = {
    ["Mysterious Arrow"] = true,
    ["Gold Coin"] = true,
    ["Rokakaka"] = true,
    ["Pure Rokakaka"] = true,
    ["Lucky Arrow"] = true,
    ["Lucky Stone Mask"] = true,
    ["Steel Ball"] = true,
    ["Ancient Scroll"] = true,
    ["Quinton's Glove"] = true,
    ["Stone Mask"] = true,
    ["Clackers"] = true,
    ["Rib Cage of The Saint's Corpse"] = true,
    ["Diamond"] = true,
    ["Dio's Diary"] = true
}

_G.autoSell = false
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local vim = game:GetService("VirtualInputManager")

-- sell
local backpackConn = nil
local selling = false

function sellItem(tool)
    if not _G.autoSell or not tool then return end
    if selling then return end

    selling = true
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")

    humanoid:EquipTool(tool)
    repeat task.wait() until tool.Parent == char or not _G.autoSell

    local args = {
        "EndDialogue",
        {
            Option = "Option2",
            Dialogue = "Dialogue5",
            NPC = "Merchant"
        }
    }

    char:WaitForChild("RemoteEvent"):FireServer(unpack(args))
    task.wait(0.35)
    selling = false
end

function scanBackpack()
    local backpack = player:FindFirstChild("Backpack")
    if not backpack then return end

    for _, tool in ipairs(backpack:GetChildren()) do
        if not _G.autoSell then break end
        if tool:IsA("Tool") and _G.Farm[tool.Name] then
            sellItem(tool)
        end
    end
end

function startAutoSell()
    local backpack = player:WaitForChild("Backpack")
    if backpackConn then
        backpackConn:Disconnect()
    end
    backpackConn = game:GetService("RunService").RenderStepped:Connect(function()
        if not _G.autoSell then return end
        scanBackpack()
    end)
end

function stopAutoSell()
    if backpackConn then
        backpackConn:Disconnect()
        backpackConn = nil
    end
    selling = false
end

function toggleAutoSell(state)
    _G.autoSell = state
    if state then
        startAutoSell()
    else
        stopAutoSell()
    end
end

-- shit
local lastFound = tick()
local lastSuccess = tick()
local SKIP_DELAY = 5

local cachedPrompts = {}
local lastUpdate = 0
local UPDATE_DELAY = 1 

function updatePrompts()
    table.clear(cachedPrompts)
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") and v.ObjectText and _G.Farm[v.ObjectText] then
            local model = v:FindFirstAncestorOfClass("Model")
            if model and model.Parent then
                table.insert(cachedPrompts, {item = model, prompt = v})
            end
        end
    end
    lastUpdate = tick()
end

function getAllPrompts()
    if tick() - lastUpdate > UPDATE_DELAY then
        updatePrompts()
    end
    return cachedPrompts
end

function getUnderPosition(item)
    local cf, size = item:GetBoundingBox()
    return cf.Position - Vector3.new(0, (size.Y/2) + 3, 0)
end

function getClosestItem(root)
    local prompts = getAllPrompts()
    local closest = nil
    local shortest = math.huge

    for _, data in ipairs(prompts) do
        if data.item and data.item.Parent then
            local pos = getUnderPosition(data.item)
            local dist = (root.Position - pos).Magnitude
            if dist < shortest then
                shortest = dist
                closest = data
            end
        end
    end
    return closest
end


local radius = 25
local disabledParts = {}
local active = false
function disableCollision()
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _, part in ipairs(Workspace:GetPartBoundsInRadius(root.Position, radius)) do
        if part:IsA("BasePart") and part.CanCollide and not part:IsDescendantOf(char) then
            part.CanCollide = false
            disabledParts[part] = true
        end
    end
end
function restoreCollision()
    for part in pairs(disabledParts) do
        if part and part:IsDescendantOf(Workspace) then
            part.CanCollide = true
        end
    end
    table.clear(disabledParts)
end

RunService.Stepped:Connect(function()
    if _G.autoFarm then
        active = true
        disableCollision()
    else
        if active then
            restoreCollision()
            active = false
        end
    end
end)

player.CharacterAdded:Connect(function()
    task.wait(1)
    if not _G.autoFarm then restoreCollision() end
end)

-- FAST TRAVEL
local fastTravelPoints = {
    "Merchant's Keep",
    "Parking Lot",
    "Prison Bridge",
    "Train Station",
    "Via Toledo",
    "Via dell'Oceano"
}
local fastIndex = 1
function fastTravel(root)
    local fastTravel = Workspace:FindFirstChild("FastTravel")
    if not fastTravel then return end

    local name = fastTravelPoints[fastIndex]
    local zone = fastTravel:FindFirstChild(name)

    if zone and zone:FindFirstChild("TeleportTo") then
        local tp = zone.TeleportTo
        local cf = tp.Value

        root.CFrame = cf + Vector3.new(
            math.random(-2,2),
            3,
            math.random(-2,2)
        )
    end

    fastIndex += 1
    if fastIndex > #fastTravelPoints then fastIndex = 1 end
    lastFound = tick()
    lastSuccess = tick()
end
-- loop
local holding = false
RunService.Heartbeat:Connect(function()
    if not _G.autoFarm then return end

    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local target = getClosestItem(root)

    if target then
        lastFound = tick()
        local item = target.item
        local prompt = target.prompt
        if not item or not item.Parent then return end

        local targetPos = getUnderPosition(item) + Vector3.new(0,1,0)
        local direction = (targetPos - root.Position)
        local dist = direction.Magnitude

        if dist <= 4.5 then
            root.CFrame = CFrame.new(targetPos)

            workspace.CurrentCamera.CFrame = CFrame.new(
                workspace.CurrentCamera.CFrame.Position,
                workspace.CurrentCamera.CFrame.Position + Vector3.new(0,999,0)
            )

            if not holding then
                holding = true
                task.spawn(function()
                    while item and item.Parent and _G.autoFarm do
                        vim:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                        task.wait(prompt.HoldDuration + 0.2)
                        vim:SendKeyEvent(false, Enum.KeyCode.E, false, game)

                        if not item.Parent then
                            lastSuccess = tick()
                            break
                        end
                        task.wait(0.05)
                    end
                    holding = false
                end)
            end

            if tick() - lastSuccess > SKIP_DELAY then
                fastTravel(root)
                return
            end

        else
            root.CFrame = CFrame.new(root.Position + direction.Unit * math.min(20, dist))
        end

    else
        if tick() - lastFound > SKIP_DELAY then
            fastTravel(root)
            return
        end

        root.CFrame = root.CFrame + Vector3.new(0,0,6)
    end
end)

function eachBasePart(root, callback)
    if not root then return end
    for _, obj in ipairs(root:GetDescendants()) do
        if obj:IsA("BasePart") then
            callback(obj)
        end
    end
end

function getMapRoot()
    return workspace:FindFirstChild("Map") or workspace
end

function getPartsByBrickColor(name)
    local result = {}
    eachBasePart(getMapRoot(), function(obj)
        if obj.BrickColor == BrickColor.new(name) then
            table.insert(result, obj)
        end
    end)
    return result
end

function getPrisonBridgeObjects()
    return getPartsByBrickColor("Fossil")
end

function getRailingObjects()
    return getPartsByBrickColor("Concrete")
end

function getSidewalkCadetBlue()
    return getPartsByBrickColor("Cadet blue")
end

function getSidewalkBrickYellow()
    return getPartsByBrickColor("Brick yellow")
end

function getSidewalkStairsObjects()
    return getPartsByBrickColor("Cadet blue")
end

function getPrisonStairsObjects()
    return getPartsByBrickColor("Fossil")
end

function getPrisonFlooringObjects()
    return getPartsByBrickColor("Fossil")
end

function getRoadObjects()
    return getPartsByBrickColor("Earth blue")
end

function getParkingGarageObjects()
    return getPartsByBrickColor("Earth blue")
end

function getParkingRampObjects()
    return getPartsByBrickColor("Earth blue")
end

function updateMapTextures(enabled)
    function setColor(list, color)
        for _, obj in ipairs(list) do
            obj.Color = color
        end
    end

    function setBrick(list, colorName)
        for _, obj in ipairs(list) do
            obj.BrickColor = BrickColor.new(colorName)
        end
    end

    if enabled then
        setColor(getPrisonBridgeObjects(), Color3.fromRGB(185, 170, 142))
        setColor(getRailingObjects(), Color3.fromRGB(185, 170, 142))
        setColor(getSidewalkCadetBlue(), Color3.fromRGB(185, 170, 142))
        setBrick(getSidewalkBrickYellow(), "Burlap")
        setColor(getSidewalkStairsObjects(), Color3.fromRGB(185, 170, 142))
        setColor(getPrisonStairsObjects(), Color3.fromRGB(185, 170, 142))
        setColor(getPrisonFlooringObjects(), Color3.fromRGB(185, 170, 142))
        setBrick(getRoadObjects(), "Smoky grey")
        setColor(getParkingGarageObjects(), Color3.fromRGB(91, 93, 105))
        setColor(getParkingRampObjects(), Color3.fromRGB(91, 93, 105))
    else
        setBrick(getPrisonBridgeObjects(), "Fossil")
        setBrick(getRailingObjects(), "Concrete")
        setBrick(getSidewalkCadetBlue(), "Cadet blue")
        setBrick(getSidewalkBrickYellow(), "Brick yellow")
        setBrick(getSidewalkStairsObjects(), "Cadet blue")
        setBrick(getPrisonStairsObjects(), "Fossil")
        setBrick(getPrisonFlooringObjects(), "Fossil")
        setBrick(getRoadObjects(), "Earth blue")
        setBrick(getParkingGarageObjects(), "Earth blue")
        setBrick(getParkingRampObjects(), "Earth blue")
    end
end

function getOcean()
    local map = workspace:FindFirstChild("Map")
    local important = map and map:FindFirstChild("IMPORTANT")
    return important and important:FindFirstChild("Ocean")
end

function createWaterTexture()
    local ocean = getOcean()
    if not ocean or ocean:FindFirstChild("WaterTextMaterial") then return end
    local texture = Instance.new("Texture")
    texture.Name = "WaterTextMaterial"
    texture.Face = Enum.NormalId.Top
    texture.Texture = "rbxassetid://5192458915"
    texture.StudsPerTileU = 37
    texture.StudsPerTileV = 63
    texture.Transparency = 0.9
    texture.Color3 = Color3.new(0, 0, 0)
    texture.Parent = ocean
end

local poses = {
    ["Old SP"] = { player = "6048287469", stand = "6048287117" },
    ["Old KC"] = { player = "4490526328", stand = "6048281381" },
    ["GE"] = { player = "6048278851", stand = "6048278456" },
    ["SCR"] = { player = "4628343401", stand = "6048284655" },
    ["CDR"] = { player = "136034596499700", stand = "76634209056964" },
    ["CD"] = { player = "12779533595", stand = "12779535127" },
    ["SP"] = { player = "12798600038", stand = "12798600931" },
    ["TW"] = { player = "12779544362", stand = "12779545784" },
    ["TH"] = { player = "6048280610", stand = "6048280959" },
    ["KC"] = { player = "6048281381", stand = "6048281691" },
    ["KCR"] = { player = "12779538033", stand = "12779540110" },
    ["SP:TW"] = { player = "12779541357", stand = "12779542706" },
    ["TWOH"] = { player = "6105485353", stand = "6105485671" },
    ["TWAU"] = { player = "12779547515", stand = "12779548847" },
}

function setPose(pose)
    local data = poses[pose]
    if data then
        _G.poseAssetPlayer = data.player
        _G.poseAssetStand = data.stand
    end
end

local poseRunningConnection = nil
local standTrack = nil
local playerTrack = nil
local poseHumanoid = nil
local summonedConnection = nil
local standChildAddedConnection = nil
local currentStandMorph = nil

function livingModel()
    local living = workspace:FindFirstChild("Living")
    return living and living:FindFirstChild(Player.Name)
end

function isStandSummoned(playerModel)
    local summoned = playerModel and playerModel:FindFirstChild("SummonedStand")
    return summoned and summoned.Value == true
end

function clearPose()
    if poseRunningConnection then poseRunningConnection:Disconnect() poseRunningConnection = nil end
    if standTrack then standTrack:Stop() standTrack = nil end
    if playerTrack then playerTrack:Stop() playerTrack = nil end
end

function applyPose()
    if not _G.Config.poseEnabled or not currentStandMorph or not poseHumanoid then return end
    local playerModel = livingModel()
    if not isStandSummoned(playerModel) then
        clearPose()
        return
    end

    local controller = currentStandMorph:FindFirstChildOfClass("AnimationController")
    local standAnimator = controller and controller:FindFirstChildOfClass("Animator")
    local playerAnimator = poseHumanoid:FindFirstChildOfClass("Animator")
    if not standAnimator or not playerAnimator or not _G.poseAssetStand or not _G.poseAssetPlayer then return end

    clearPose()

    local standAnimation = Instance.new("Animation")
    standAnimation.AnimationId = "rbxassetid://" .. _G.poseAssetStand
    local idleAnimation = Instance.new("Animation")
    idleAnimation.AnimationId = "rbxassetid://" .. _G.poseAssetPlayer

    standTrack = standAnimator:LoadAnimation(standAnimation)
    playerTrack = playerAnimator:LoadAnimation(idleAnimation)
    standTrack.Looped = true
    playerTrack.Looped = true

    poseRunningConnection = poseHumanoid.Running:Connect(function(speed)
        if speed == 0 then
            if not playerTrack.IsPlaying then playerTrack:Play() end
        elseif playerTrack.IsPlaying then
            playerTrack:Stop()
        end
    end)

    standTrack:Play()
    if poseHumanoid.MoveDirection.Magnitude == 0 then
        playerTrack:Play()
    end
end

function setupCharacter(character)
    poseHumanoid = character:WaitForChild("Humanoid", 10)
    local playerModel = livingModel()
    if not poseHumanoid or not playerModel then return end

    if summonedConnection then summonedConnection:Disconnect() end
    if standChildAddedConnection then standChildAddedConnection:Disconnect() standChildAddedConnection = nil end
    local summoned = playerModel:FindFirstChild("SummonedStand")
    if summoned then
        summonedConnection = summoned.Changed:Connect(function()
            if summoned.Value == true then applyPose() else clearPose() end
        end)
    end

    local existing = playerModel:FindFirstChild("StandMorph")
    if existing then
        currentStandMorph = existing
        task.delay(0.5, applyPose)
    end

    standChildAddedConnection = playerModel.ChildAdded:Connect(function(child)
        if child.Name == "StandMorph" then
            currentStandMorph = child
            task.delay(0.5, applyPose)
        end
    end)
end

Player.CharacterAdded:Connect(function(character)
    setupCharacter(character)
end)
if Player.Character then
    pcall(function() setupCharacter(Player.Character) end)
end

function applyStandAura()
    if not _G.Config.standAuraEnabled then return end
    local model = livingModel()
    if not model then return end

    local color
    if _G.Config.standAuraRgb then
        color = Color3.fromHSV((tick() % 2) / 2, 1, 1)
    else
        color = Color3.fromRGB(_G.Config.standAuraR, _G.Config.standAuraG, _G.Config.standAuraB)
    end

    for _, obj in ipairs(model:GetDescendants()) do
        if obj:IsA("ParticleEmitter") and obj.Name:match("StandAura") then
            obj.Color = ColorSequence.new(color)
        end
    end
end

function getAllGloves()
    local result = {}
    local model = livingModel()
    local gloves = model and model:FindFirstChild("Boxing Gloves")
    local gloves2 = model and model:FindFirstChild("Boxing Claws")
    local gloves3 = model and model:FindFirstChild("Bone Gloves")
    local gloves4 = model and model:FindFirstChild("Festive Gloves")
    if gloves then
        table.insert(result, gloves)
    end
    if gloves2 then
        table.insert(result, gloves2)
    end
    if gloves3 then
        table.insert(result, gloves3)
    end
    if gloves4 then
        table.insert(result, gloves4)
    end
    return result
end

function findHand(partName)
    local char = livingModel()
    if not char then return nil end
    local hand = char:FindFirstChild(partName)
    if hand then return hand end
    for _, part in ipairs(char:GetDescendants()) do
        if part.Name == partName and part:IsA("BasePart") then
            return part
        end
    end
    return nil
end

function skinChanger(skinNameNi)
    if skinNameNi == "..." then return end
    for _, item in ipairs(getAllGloves()) do
        if (item.Name == "Boxing Gloves" or item.Name == "Bone Gloves" or item.Name == "Boxing Claws" or item.Name == "Festive Gloves") and skinNameNi == "Bone Gloves" then
            item.Name = skinNameNi
            local boxingGloves = item
            function setupGlove(gloveName, handName, meshId, textureId, weldC1, overlayMeshId, overlayTextureId, overlayOffset)
                local old = boxingGloves:FindFirstChild(gloveName)
                if old then old:Destroy() end
                local glove = Instance.new("Part")
                glove.Name = gloveName
                glove.Size = Vector3.new(1, 1, 1)
                glove.Anchored = false
                glove.CanCollide = false
                glove.Transparency = 1
                glove.Parent = boxingGloves
                local mesh = Instance.new("SpecialMesh")
                mesh.MeshId = meshId
                mesh.TextureId = textureId
                mesh.Parent = glove
                local hand = findHand(handName)
                if hand then
                    local weld = Instance.new("ManualWeld")
                    weld.Name = "Weld"
                    weld.Part0 = hand
                    weld.Part1 = glove
                    weld.C1 = weldC1
                    weld.Parent = glove
                end
                local overlay = Instance.new("Part")
                overlay.Name = "BoxingGlove"
                overlay.Size = Vector3.new(1, 1, 1)
                overlay.Anchored = false
                overlay.CanCollide = false
                overlay.Parent = glove
                local overlayMesh = Instance.new("SpecialMesh")
                overlayMesh.MeshId = overlayMeshId
                overlayMesh.TextureId = overlayTextureId
                overlayMesh.Parent = overlay
                local weld2 = Instance.new("ManualWeld")
                weld2.Name = "Weld2"
                weld2.Part0 = glove
                weld2.Part1 = overlay
                weld2.C1 = overlayOffset
                weld2.Parent = glove
            end
            setupGlove("LeftGlove", "LeftHand", "rbxassetid://7739766120", "rbxassetid://7739771177", CFrame.new(0.0603, 0.1250, 0.0349), "rbxassetid://11254762450", "rbxassetid://11254762232", CFrame.new(0.0933, 0.0885, 0.0250))
            setupGlove("RightGlove", "RightHand", "rbxassetid://7739768200", "rbxassetid://7739771177", CFrame.new(-0.0698, 0.1250, 0.0349), "rbxassetid://11254762583", "rbxassetid://11254762232", CFrame.new(-0.1918, 0.0885, 0.0250))
        elseif (item.Name == "Boxing Gloves" or item.Name == "Bone Gloves" or item.Name == "Boxing Claws" or item.Name == "Festive Gloves") and skinNameNi == "Festive Gloves" then
            item.Name = skinNameNi
            local boxingGloves = item
            function setupGlove(gloveName, handName, weldOffset, meshId, textureId)
                local old = boxingGloves:FindFirstChild(gloveName)
                if old then old:Destroy() end
                local glove = Instance.new("Part")
                glove.Name = gloveName
                glove.Size = Vector3.new(1, 1, 1)
                glove.Anchored = false
                glove.CanCollide = false
                glove.Parent = boxingGloves
                local mesh = Instance.new("SpecialMesh")
                mesh.MeshId = meshId
                mesh.TextureId = textureId
                mesh.Parent = glove
                local hand = findHand(handName)
                if hand then
                    local weld = Instance.new("ManualWeld")
                    weld.Name = "Weld"
                    weld.Part0 = hand
                    weld.Part1 = glove
                    if gloveName == "RightGlove" then
                        weld.C1 = CFrame.new(weldOffset.X, weldOffset.Y, weldOffset.Z)
                    end
                    weld.Parent = glove
                end
            end
            setupGlove("LeftGlove", "LeftHand", Vector3.new(0, 0, 0), "rbxassetid://8167805632", "rbxassetid://8167805151")
            setupGlove("RightGlove", "RightHand", Vector3.new(-0.07, 0.125, 0.035), "rbxassetid://8167805284", "rbxassetid://8167805151")
        elseif (item.Name == "Boxing Gloves" or item.Name == "Bone Gloves" or item.Name == "Boxing Claws" or item.Name == "Festive Gloves") and skinNameNi == "Boxing Claws" then
            item.Name = skinNameNi
            local box = item
            function addAura(parent)
                local aura = Instance.new("Attachment")
                aura.Name = "Aura"
                aura.Parent = parent
                local glow = Instance.new("ParticleEmitter")
                glow.Name = "GlowAura"
                glow.Texture = "rbxassetid://7548285739"
                glow.Rate = 10
                glow.Lifetime = NumberRange.new(1.25, 1.25)
                glow.Speed = NumberRange.new(0.1, 0.1)
                glow.Rotation = NumberRange.new(-360, 360)
                glow.RotSpeed = NumberRange.new(-200, 200)
                glow.SpreadAngle = Vector2.new(-360, 360)
                glow.Drag = 3.5
                glow.LockedToPart = true
                glow.LightEmission = 1
                glow.Color = ColorSequence.new(Color3.fromRGB(255, 162, 0))
                glow.Parent = aura
                local shine = Instance.new("ParticleEmitter")
                shine.Name = "Shine"
                shine.Texture = "rbxassetid://7103657950"
                shine.Rate = 3
                shine.Lifetime = NumberRange.new(2.25, 2.25)
                shine.Speed = NumberRange.new(0, 0)
                shine.LightEmission = 1
                shine.Color = ColorSequence.new(Color3.fromRGB(255, 106, 0))
                shine.Parent = aura
            end
            function createGlove(gloveName, handName, meshId, clawsMeshId, weldC1, clawsWeldC1)
                local old = box:FindFirstChild(gloveName)
                if old then old:Destroy() end
                local glove = Instance.new("Part")
                glove.Name = gloveName
                glove.Size = Vector3.new(1.302, 1.1049, 1.3359)
                glove.Anchored = false
                glove.CanCollide = false
                glove.Color = Color3.fromRGB(163, 162, 165)
                glove.Parent = box
                local mesh = Instance.new("SpecialMesh")
                mesh.MeshId = meshId
                mesh.TextureId = "rbxassetid://7739771177"
                mesh.Parent = glove
                local hand = findHand(handName)
                if hand then
                    local weld = Instance.new("ManualWeld")
                    weld.Name = "Weld"
                    weld.Part0 = hand
                    weld.Part1 = glove
                    weld.C1 = weldC1
                    weld.Parent = glove
                end
                local claws = Instance.new("Part")
                claws.Name = "Claws"
                claws.Size = Vector3.new(0.1045, 1.2284, 0.9352)
                claws.Anchored = false
                claws.CanCollide = false
                claws.Color = Color3.fromRGB(163, 162, 165)
                claws.Material = Enum.Material.Metal
                claws.Parent = glove
                local clawsMesh = Instance.new("SpecialMesh")
                clawsMesh.MeshId = clawsMeshId
                clawsMesh.TextureId = "rbxassetid://7739771177"
                clawsMesh.Parent = claws
                local weld2 = Instance.new("ManualWeld")
                weld2.Name = "Weld2"
                weld2.Part0 = glove
                weld2.Part1 = claws
                weld2.C1 = clawsWeldC1
                weld2.Parent = glove
                addAura(glove)
            end
            local leftWeldC1 = CFrame.new(0.0603485107, 0.1250119209, 0.0349082351)
            local leftClawsC1 = CFrame.new(0.5546178818, 0.3449656963, -0.0056009293)
            createGlove("LeftGlove", "LeftHand", "rbxassetid://7739766120", "rbxassetid://7739766906", leftWeldC1, leftClawsC1)
            createGlove("RightGlove", "RightHand", "rbxassetid://7739768200", "rbxassetid://7739767639", CFrame.new(-leftWeldC1.Position.X, leftWeldC1.Position.Y, leftWeldC1.Position.Z), CFrame.new(-leftClawsC1.Position.X, leftClawsC1.Position.Y, leftClawsC1.Position.Z))
        end
    end
end

-- nga
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Macro = {
    Recording = false,
    Replaying = false,
    Events = {},
    StartTime = 0,
    ReplayIndex = 1,
    CurrentFile = nil,
    KeyConnections = {},
    FirstInput = true,
    AllowedKeys = {
        ["Q"] = true, ["W"] = true, ["E"] = true, ["R"] = true, ["T"] = true,
        ["Y"] = true, ["U"] = true, ["I"] = true, ["O"] = true, ["P"] = true,
        ["A"] = true, ["S"] = true, ["D"] = true, ["F"] = true, ["G"] = true,
        ["H"] = true, ["J"] = true, ["K"] = true, ["L"] = true,
        ["Z"] = true, ["X"] = true, ["C"] = true, ["V"] = true, ["B"] = true,
        ["N"] = true, ["M"] = true,
        ["One"] = true, ["Two"] = true, ["Three"] = true, ["Four"] = true,
        ["Five"] = true, ["Six"] = true, ["Seven"] = true, ["Eight"] = true,
        ["Nine"] = true, ["Zero"] = true,
        ["LeftAlt"] = true, ["RightAlt"] = true,
        ["LeftShift"] = true, ["RightShift"] = true,
        ["Tab"] = true, ["CapsLock"] = true
    }
}

function Macro:GetFileName()
    local stats = LocalPlayer:FindFirstChild("PlayerStats")
    if not stats then return "rec1.json" end
    local stand = stats:FindFirstChild("Stand")
    local spec = stats:FindFirstChild("Spec")
    local standVal = stand and stand.Value or "0"
    local specVal = spec and spec.Value or "0"
    return standVal .. "_" .. specVal .. ".json"
end

function Macro:GetFileList()
    local files = {}
    local list = listfiles()
    for _, file in ipairs(list) do
        if file:match("^%d+_%d+%.json$") then
            table.insert(files, file)
        end
    end
    return files
end

function Macro:SimulateKeyDown(keyCode)
    VirtualInputManager:SendKeyEvent(true, keyCode, false, nil)
end

function Macro:SimulateKeyUp(keyCode)
    VirtualInputManager:SendKeyEvent(false, keyCode, false, nil)
end

function Macro:StartRecord()
    if self.Recording or self.Replaying then return end
    self.Events = {}
    self.StartTime = tick()
    self.Recording = true
    self.FirstInput = true
    self.KeyConnections = {}
    
    self.KeyConnections.InputBegan = UserInputService.InputBegan:Connect(function(input, gp)
        if gp or not self.Recording then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local key = input.KeyCode.Name
            if self.AllowedKeys[key] then
                local timestamp
                if self.FirstInput then
                    self.FirstInput = false
                    self.StartTime = tick()
                    timestamp = 0
                else
                    timestamp = tick() - self.StartTime
                end
                table.insert(self.Events, {
                    Type = "KeyDown",
                    Key = key,
                    Time = timestamp
                })
            end
        end
    end)
    
    self.KeyConnections.InputEnded = UserInputService.InputEnded:Connect(function(input, gp)
        if gp or not self.Recording then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local key = input.KeyCode.Name
            if self.AllowedKeys[key] then
                table.insert(self.Events, {
                    Type = "KeyUp",
                    Key = key,
                    Time = tick() - self.StartTime
                })
            end
        end
    end)
    
    print("Recording started! Press any allowed key to begin.")
    return true
end

function Macro:StopRecord()
    if not self.Recording then return end
    self.Recording = false
    for _, conn in pairs(self.KeyConnections) do
        conn:Disconnect()
    end
    self.KeyConnections = {}
    local filename = self:GetFileName()
    local data = {
        RecordedAt = os.date("%Y-%m-%d %H:%M:%S"),
        TotalTime = tick() - self.StartTime,
        Events = self.Events
    }
    writefile(filename, HttpService:JSONEncode(data))
    print("Record saved to: " .. filename .. " (" .. #self.Events .. " events)")
    return filename
end

function Macro:ReplayFile(filename)
    if self.Replaying or self.Recording then return false end
    if not isfile(filename) then
        warn("File not found: " .. filename)
        return false
    end
    local data = HttpService:JSONDecode(readfile(filename))
    if not data or not data.Events then
        warn("Invalid macro file")
        return false
    end
    self.Replaying = true
    self.ReplayIndex = 1
    self.Events = data.Events
    self.CurrentFile = filename
    print("Replaying: " .. filename .. " (" .. #self.Events .. " events)")
    self:ProcessReplay()
    return true
end

function Macro:ProcessReplay()
    if not self.Replaying then return end
    if self.ReplayIndex > #self.Events then
        self:StopReplay()
        return
    end
    local event = self.Events[self.ReplayIndex]
    local delay = event.Time - (self.ReplayIndex > 1 and self.Events[self.ReplayIndex - 1].Time or 0)
    if delay < 0 then delay = 0 end
    task.wait(delay)
    if not self.Replaying then return end
    if event.Type == "KeyDown" then
        local keyCode = Enum.KeyCode[event.Key]
        if keyCode then self:SimulateKeyDown(keyCode) end
    elseif event.Type == "KeyUp" then
        local keyCode = Enum.KeyCode[event.Key]
        if keyCode then self:SimulateKeyUp(keyCode) end
    end
    self.ReplayIndex = self.ReplayIndex + 1
    task.spawn(function() self:ProcessReplay() end)
end

function Macro:StopReplay()
    if not self.Replaying then return end
    self.Replaying = false
    self.ReplayIndex = 1
    for _, event in ipairs(self.Events) do
        if event.Type == "KeyDown" then
            local keyCode = Enum.KeyCode[event.Key]
            if keyCode then self:SimulateKeyUp(keyCode) end
        end
    end
    print("Replay stopped")
end

function record()
    return Macro:StartRecord()
end

function stop()
    return Macro:StopRecord()
end

function replay(filename)
    if not filename then
        print("Available files:")
        for _, f in ipairs(Macro:GetFileList()) do
            print("  - " .. f)
        end
        return
    end
    return Macro:ReplayFile(filename)
end

function stopreplay()
    Macro:StopReplay()
end

_G.zqqqq = UserInputService.InputBegan:Connect(function(inp, gp)
    if gp then return end
    if inp.KeyCode == Enum.KeyCode.F1 then
        Macro:StartRecord()
    end
    if inp.KeyCode == Enum.KeyCode.F2 then
        Macro:StopRecord()
    end
    if inp.KeyCode == Enum.KeyCode.F3 then
        local filename = Macro:GetFileName()
        Macro:ReplayFile(filename)
    end
end)


-- old shi
function toggleOldSpSummon(bool)
    if not bool then
        if _G.ggwpqqq then
            _G.ggwpqqq:Disconnect()
        end
        return
    end

    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local plr = Players.LocalPlayer
    local played = false
    function getRoot()
        local living = workspace:FindFirstChild("Living")
        if not living then return nil end
        local char = living:FindFirstChild(plr.Name)
        if not char then return nil end
        return char:FindFirstChild("HumanoidRootPart")
    end
    _G.ggwpqqq = RunService.RenderStepped:Connect(function()
        local stats = plr:FindFirstChild("PlayerStats")
        if not stats then return end
        local stand = stats:FindFirstChild("Stand")
        if not stand then return end
        local living = workspace:FindFirstChild("Living")
        if not living then return end
        local char = living:FindFirstChild(plr.Name)
        if not char then return end
        local summoned = char:FindFirstChild("SummonedStand")
        if stand.Value == "Star Platinum" and summoned and summoned.Value == true then
            if not played then
                played = true
                local root = getRoot()
                if not root then return end
                local sound = Instance.new("Sound")
                sound.SoundId = "rbxassetid://4080511682"
                sound.Volume = 1
                sound.RollOffMaxDistance = 60
                sound.Parent = root
                sound:Play()
                game:GetService("Debris"):AddItem(sound, 5)
            end
        elseif stand.Value == "The World Alternate Universe" and summoned and summoned.Value == true then
            if not played then
                played = true
                local root = getRoot()
                if not root then return end
                local sound = Instance.new("Sound")
                sound.SoundId = "rbxassetid://4080511682"
                sound.Volume = 1
                sound.RollOffMaxDistance = 60
                sound.Parent = root
                sound:Play()
                game:GetService("Debris"):AddItem(sound, 5)
            end
        elseif stand.Value == "The World" and summoned and summoned.Value == true then
            if not played then
                played = true
                local root = getRoot()
                if not root then return end
                local sound = Instance.new("Sound")
                sound.SoundId = "rbxassetid://4080511682"
                sound.Volume = 1
                sound.RollOffMaxDistance = 60
                sound.Parent = root
                sound:Play()
                game:GetService("Debris"):AddItem(sound, 5)
            end
        else
            played = false
        end
    end)
end
local poses = {
    ["Old SP"] = { player = "6048287469", stand = "6048287117" },
    ["Old KC"] = { player = "4490526328", stand = "6048281381" },
    ["GE"] = { player = "6048278851", stand = "6048278456" },
    ["SCR"] = { player = "4628343401", stand = "6048284655" },
    ["CDR"] = { player = "136034596499700", stand = "76634209056964" },
    ["CD"] = { player = "12779533595", stand = "12779535127" },
    ["SP"] = { player = "12798600038", stand = "12798600931" },
    ["TW"] = { player = "12779544362", stand = "12779545784" },
    ["TH"] = { player = "6048280610", stand = "6048280959" },
    ["KC"] = { player = "6048281381", stand = "6048281691" },
    ["KCR"] = { player = "12779538033", stand = "12779540110" },
    ["SP:TW"] = { player = "12779541357", stand = "12779542706" },
    ["TWOH"] = { player = "6105485353", stand = "6105485671" },
    ["TWAU"] = { player = "12779547515", stand = "12779548847" },
}

function setPose(pose)
    local data = poses[pose]
    if data then
        _G.poseAssetPlayer = data.stand
        _G.poseAssetStand = data.player
    end
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local living = workspace:WaitForChild("Living")

local runningConnection = nil
local standTrack = nil
local playerTrack = nil
local humanoid = nil
local playerAnimator = nil
local summonedConnection = nil
local currentStandMorph = nil

function isStandSummoned(playerModel)
    local summoned = playerModel:FindFirstChild("SummonedStand")
    return summoned and summoned.Value == true
end

function applyPose()
    if not currentStandMorph then return end
    if not humanoid then return end

    local playerModel = living:WaitForChild(player.Name)
    if not isStandSummoned(playerModel) then
        clearPose()
        return
    end

    local standAnimator = currentStandMorph.AnimationController:WaitForChild("Animator")
    playerAnimator = humanoid:WaitForChild("Animator")

    if runningConnection then runningConnection:Disconnect() end
    if standTrack then standTrack:Stop() end
    if playerTrack then playerTrack:Stop() end

    local standAnimation = Instance.new("Animation")
    standAnimation.AnimationId = "rbxassetid://" .. _G.poseAssetStand

    local idleAnimation = Instance.new("Animation")
    idleAnimation.AnimationId = "rbxassetid://" .. _G.poseAssetPlayer

    standTrack = standAnimator:LoadAnimation(standAnimation)
    playerTrack = playerAnimator:LoadAnimation(idleAnimation)

    standTrack.Looped = true
    playerTrack.Looped = true

    runningConnection = humanoid.Running:Connect(function(speed)
        if speed == 0 then
            if not playerTrack.IsPlaying then
                playerTrack:Play()
            end
        else
            if playerTrack.IsPlaying then
                playerTrack:Stop()
            end
        end
    end)

    standTrack:Play()
    if humanoid.MoveDirection.Magnitude == 0 then
        playerTrack:Play()
    end
end

function clearPose()
    if runningConnection then
        runningConnection:Disconnect()
        runningConnection = nil
    end
    if standTrack then
        standTrack:Stop()
        standTrack = nil
    end
    if playerTrack then
        playerTrack:Stop()
        playerTrack = nil
    end
end

function setupCharacter(character)
    if not _G.Config.oldAnimationsSp then return end
    local sss = game:GetService("Players").LocalPlayer.PlayerStats.Stand
    if sss and sss.Value == "Star Platinum" then 
        setPose("Old SP")
    end
    humanoid = character:WaitForChild("Humanoid")
    local playerModel = living:WaitForChild(player.Name)

    if summonedConnection then summonedConnection:Disconnect() end

    local summoned = playerModel:FindFirstChild("SummonedStand")
    if summoned then
        summonedConnection = summoned.Changed:Connect(function()
            if summoned.Value == true then
                applyPose()
            else
                clearPose()
            end
        end)
    end

    local existing = playerModel:FindFirstChild("StandMorph")
    if existing then
        currentStandMorph = existing
        task.wait(0.5)
        applyPose()
    end

    playerModel.ChildAdded:Connect(function(child)
        if child.Name == "StandMorph" then
            currentStandMorph = child
            task.wait(0.5)
            applyPose()
        end
    end)
end

player.CharacterAdded:Connect(setupCharacter)
if player.Character then
    local succ, err = pcall(function() setupCharacter(player.Character) end)
    if not succ then warn('[CUSTOM POSE] ' .. err) end
end


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local fadeOutDuration = 0.4
local flashCooldown = 2
local highlights = {}
local lastFlashTime = {}

function findAnimator(char)
    local hum = char:FindFirstChild("Humanoid")
    if hum then
        local animator = hum:FindFirstChild("Animator")
        if animator then return animator end
    end
    for _, child in ipairs(char:GetDescendants()) do
        if child:IsA("Animator") then return child end
    end
    return nil
end

function getHighlight(player)
    if not highlights[player] then
        local char = player.Character
        if not char then return nil end

        local highlight = Instance.new("Highlight")
        highlight.Name = "FlashHighlight"
        highlight.FillColor = Color3.new(1, 1, 1)
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.OutlineTransparency = 1
        highlight.FillTransparency = 1
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = char
        highlight.Adornee = char
        highlights[player] = {
            highlight = highlight,
            tween = nil
        }
    end

    local char = player.Character
    local data = highlights[player]
    if data.highlight.Parent ~= char then
        data.highlight.Parent = char
        data.highlight.Adornee = char
    end

    return data
end

function cancelTween(data)
    if data.tween and data.tween.PlaybackState == Enum.PlaybackState.Playing then
        data.tween:Cancel()
    end
end

function flashPlayer(player)
    local now = tick()
    local last = lastFlashTime[player] or 0
    if now - last < flashCooldown then return end
    lastFlashTime[player] = now

    local data = getHighlight(player)
    if not data then return end

    cancelTween(data)

    data.highlight.FillTransparency = 0

    task.delay(0.1, function()
        if not data.highlight.Parent then return end

        local tweenInfoOut = TweenInfo.new(fadeOutDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local goalOut = {FillTransparency = 1}
        data.tween = TweenService:Create(data.highlight, tweenInfoOut, goalOut)
        data.tween:Play()
    end)
end

function monitorAllPlayers()
    for _, player in ipairs(Players:GetPlayers()) do
        if player == Players.LocalPlayer then
            continue
        end

        local char = player.Character
        if not char then
            if highlights[player] then
                highlights[player].highlight:Destroy()
                highlights[player] = nil
                lastFlashTime[player] = nil
            end
            continue
        end

        local animator = findAnimator(char)
        if not animator then
            if highlights[player] then
                cancelTween(highlights[player])
                highlights[player].highlight.FillTransparency = 1
            end
            continue
        end

        local tracks = animator:GetPlayingAnimationTracks()

        for _, track in ipairs(tracks) do
            if track.IsPlaying then
                local anim = track.Animation
                if anim and (anim.AnimationId == "rbxassetid://4211804997" or anim.AnimationId == "rbxassetid://4095625816") then
                    flashPlayer(player)
                    break
                end
            end
        end
    end
end

function stopOldBox()
    if _G.conn4 then
        _G.conn4:Disconnect()
        _G.conn4 = nil
    end
    if _G.conn5 then
        _G.conn5:Disconnect()
        _G.conn5 = nil
    end

    for player, data in pairs(highlights) do
        if data.highlight then
            data.highlight:Destroy()
        end
        highlights[player] = nil
        lastFlashTime[player] = nil
    end
end

function oldBox()
    stopOldBox()

    _G.conn4 = Players.PlayerRemoving:Connect(function(player)
        if highlights[player] then
            highlights[player].highlight:Destroy()
            highlights[player] = nil
        end
        lastFlashTime[player] = nil
    end)

    _G.conn5 = RunService.RenderStepped:Connect(monitorAllPlayers)
end

function breakOofSound()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local living = workspace:WaitForChild("Living")
    local currentConnection
    function setupCharacter()
        local char = living:WaitForChild(player.Name)
        local root = char:WaitForChild("HumanoidRootPart")
        local diedSound = root:WaitForChild("Died", 10)
        if not diedSound then
            warn("no died sound")
            return
        end
        diedSound.SoundId = "rbxassetid://6193120200"
        diedSound.Volume = 10
        if currentConnection then
            currentConnection:Disconnect()
        end
        currentConnection = diedSound.Played:Connect(function()
            task.wait()
            diedSound.TimePosition = 0.5
        end)
        warn("death sound hooked")
    end
    setupCharacter()
    living.ChildAdded:Connect(function(obj)
        if obj.Name == player.Name then
            task.wait(1)
            setupCharacter()
        end
    end)
end

local succ,err = pcall(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local Camera = workspace.CurrentCamera

    local jumping = false
    local hasJumped = false
    local wasOnGround = false

    local function setupCharacter(character)
        local humanoid = character:WaitForChild("Humanoid")
        
        if _G.Config.enableMobileExploit then
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
            humanoid.JumpPower = 0
            humanoid.UseJumpPower = true
            humanoid.AutoRotate = false
        end
        
        hasJumped = false
        wasOnGround = false
    end

    LocalPlayer.CharacterAdded:Connect(setupCharacter)

    if LocalPlayer.Character then
        setupCharacter(LocalPlayer.Character)
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.Space then
            jumping = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Space then
            jumping = false
        end
    end)

    RunService.Heartbeat:Connect(function()
        if not LocalPlayer.Character then return end
        if not _G.Config.enableMobileExploit then return end
        
        local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        
        if not root or not humanoid or humanoid.Health <= 0 then return end
        
        humanoid.JumpPower = 0
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
        humanoid.AutoRotate = false
        
        local onGround = false
        local groundDistance = 3.1
        
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Blacklist
        params.FilterDescendantsInstances = {LocalPlayer.Character}
        
        local rayOrigin = root.Position
        local rayDirection = Vector3.new(0, -groundDistance, 0)
        local raycastResult = workspace:Raycast(rayOrigin, rayDirection, params)
        
        if raycastResult and raycastResult.Distance <= 3.0 then
            onGround = true
        end
        
        if not onGround then
            local offsets = {
                Vector3.new(1, 0, 1),
                Vector3.new(-1, 0, 1),
                Vector3.new(1, 0, -1),
                Vector3.new(-1, 0, -1)
            }
            
            local hitCount = 0
            for _, offset in ipairs(offsets) do
                local result = workspace:Raycast(root.Position + offset, Vector3.new(0, -groundDistance, 0), params)
                if result and result.Distance <= 3.0 then
                    hitCount = hitCount + 1
                end
            end
            
            if hitCount >= 2 then
                onGround = true
            end
        end
        
        local state = humanoid:GetState()
        if state == Enum.HumanoidStateType.Running then
            onGround = true
        end
        
        if onGround and (not wasOnGround or not jumping) then
            hasJumped = false
        end
        
        if jumping and onGround and not hasJumped then
            local jumpVelocity = _G.Config.meJumpPower or 50
            
            root.Velocity = Vector3.new(
                root.Velocity.X, 
                jumpVelocity, 
                root.Velocity.Z
            )
            
            hasJumped = true
        end
        
        wasOnGround = onGround
        
        -- Shift Lock
        local shiftLock = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or 
                         UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
        
        if shiftLock then
            humanoid.AutoRotate = false
            local camDirection = Camera.CFrame.LookVector * Vector3.new(1, 0, 1)
            if camDirection.Magnitude > 0.01 then
                root.CFrame = CFrame.new(root.Position, root.Position + camDirection.Unit)
            end
        else
            humanoid.AutoRotate = true
        end
        
        -- Air Strafe
        if not onGround then
            local moveDirection = Vector3.zero
            local isMoving = false
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then 
                moveDirection += Camera.CFrame.LookVector * Vector3.new(1, 0, 1)
                isMoving = true
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then 
                moveDirection -= Camera.CFrame.LookVector * Vector3.new(1, 0, 1)
                isMoving = true
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then 
                moveDirection -= Camera.CFrame.RightVector
                isMoving = true
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then 
                moveDirection += Camera.CFrame.RightVector
                isMoving = true
            end
            
            if isMoving and moveDirection.Magnitude > 0 then
                moveDirection = moveDirection.Unit
                local currentVel = root.Velocity * Vector3.new(1, 0, 1)
                local speed = math.max(currentVel.Magnitude, _G.Config.meStrafeSpeed or 16)
                
                local targetVel = moveDirection * speed
                local strafeStrength = _G.Config.meStrafeStrength or 0.15
                
                root.Velocity = Vector3.new(
                    currentVel.X + (targetVel.X - currentVel.X) * strafeStrength,
                    root.Velocity.Y,
                    currentVel.Z + (targetVel.Z - currentVel.Z) * strafeStrength
                )
            end
        end
    end)
end)
if not succ then warn('MOBILE EXPLOIT ERR: ' .. err) end


function makeHalloweenMap()
	local RunService = game:GetService("RunService")
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local Lighting = game:GetService("Lighting")

	local originalData = {
		parts = {},
		sky = nil,
		skyProperties = {},
		ocean = nil,
		oceanColor = nil,
	}

	local colorMap = {
		["Parsley green"] = "Bright orange",
		["Earth green"] = "Dark orange",
		["Sea green"] = "Bright orange",
		["Bright green"] = "Bright yellow",
		["Sage green"] = "Bright yellow",
		["Lime green"] = "Bright yellow",
		["Really green"] = "Dark orange",
		["Forest green"] = "Dark orange",
		["Dark green"] = "Dark orange",
		["Green"] = "Bright orange",
	}

	local function getOrangeColor(greenColorName)
		return colorMap[greenColorName] or "Bright orange"
	end

	local function isTargetPart(part)
		if not part:IsA("BasePart") and not part:IsA("MeshPart") and not part:IsA("Part") then
			return false
		end
		local name = part.Name:lower()
		return name:match("grass") or name:match("bush") or name:match("leaf") or name:match("leaves")
	end

	local function saveOriginalData()
		pcall(function()
			local function scanChildren(parent)
				for _, child in ipairs(parent:GetChildren()) do
					if isTargetPart(child) then
						table.insert(originalData.parts, {
							part = child,
							originalColor = child.BrickColor.Name
						})
					end
					scanChildren(child)
				end
			end
			scanChildren(workspace)
			
			local sky = Lighting:FindFirstChild("Sky")
			if sky then
				originalData.sky = sky
				originalData.skyProperties = {
					SkyboxBk = sky.SkyboxBk,
					SkyboxDn = sky.SkyboxDn,
					SkyboxFt = sky.SkyboxFt,
					SkyboxLf = sky.SkyboxLf,
					SkyboxRt = sky.SkyboxRt,
					SkyboxUp = sky.SkyboxUp,
					MoonAngularSize = sky.MoonAngularSize,
					MoonTextureId = sky.MoonTextureId,
					SunAngularSize = sky.SunAngularSize,
					SunTextureId = sky.SunTextureId,
					StarCount = sky.StarCount,
					CelestialBodiesShown = sky.CelestialBodiesShown,
				}
			end
			
			local ocean = workspace:FindFirstChild("Map")
			if ocean then
				ocean = ocean:FindFirstChild("IMPORTANT")
				if ocean then
					ocean = ocean:FindFirstChild("Ocean")
				end
			end
			if ocean then
				originalData.ocean = ocean
				originalData.oceanColor = ocean.Color
			end
		end)
	end

	local function applyFallColors()
		pcall(function()
			local function scanChildren(parent)
				for _, child in ipairs(parent:GetChildren()) do
					if isTargetPart(child) then
						local currentColor = child.BrickColor.Name
						local newColor = getOrangeColor(currentColor)
						child.BrickColor = BrickColor.new(newColor)
					end
					scanChildren(child)
				end
			end
			scanChildren(workspace)
		end)
	end

	local function doHalloween()
		local ocean = workspace:FindFirstChild("Map")
		if ocean then
			ocean = ocean:FindFirstChild("IMPORTANT")
			if ocean then
				ocean = ocean:FindFirstChild("Ocean")
			end
		end
		
		local sky = Lighting:FindFirstChild("Sky")
		
		if not sky or not ocean then
			return
		end
		
		ocean.Color = Color3.new(0.5, 0, 0)
		
		sky.SkyboxBk = "http://www.roblox.com/asset/?id=150939022"
		sky.SkyboxDn = "http://www.roblox.com/asset/?id=150939038"
		sky.SkyboxFt = "http://www.roblox.com/asset/?id=150939047"
		sky.SkyboxLf = "http://www.roblox.com/asset/?id=150939056"
		sky.SkyboxRt = "http://www.roblox.com/asset/?id=150939063"
		sky.SkyboxUp = "http://www.roblox.com/asset/?id=150939082"
		sky.MoonAngularSize = 11
		sky.MoonTextureId = "rbxasset://sky/moon.jpg"
		sky.SunAngularSize = 21
		sky.SunTextureId = "rbxasset://sky/sun.jpg"
		sky.StarCount = 3000
		sky.CelestialBodiesShown = true
	end

	local function restore()
		pcall(function()
			for _, data in ipairs(originalData.parts) do
				if data.part and data.part.Parent then
					data.part.BrickColor = BrickColor.new(data.originalColor)
				end
			end
			
			if originalData.sky and originalData.sky.Parent then
				local sky = originalData.sky
				local props = originalData.skyProperties
				sky.SkyboxBk = props.SkyboxBk
				sky.SkyboxDn = props.SkyboxDn
				sky.SkyboxFt = props.SkyboxFt
				sky.SkyboxLf = props.SkyboxLf
				sky.SkyboxRt = props.SkyboxRt
				sky.SkyboxUp = props.SkyboxUp
				sky.MoonAngularSize = props.MoonAngularSize
				sky.MoonTextureId = props.MoonTextureId
				sky.SunAngularSize = props.SunAngularSize
				sky.SunTextureId = props.SunTextureId
				sky.StarCount = props.StarCount
				sky.CelestialBodiesShown = props.CelestialBodiesShown
			end
			
			if originalData.ocean and originalData.ocean.Parent then
				originalData.ocean.Color = originalData.oceanColor
			end
		end)
	end

	saveOriginalData()
	applyFallColors()
	doHalloween()

	return {
		apply = function()
			applyFallColors()
			doHalloween()
		end,
		restore = restore
	}
end

function makeWinterMap()
	local RunService = game:GetService("RunService")
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local Lighting = game:GetService("Lighting")

	local originalData = {
		parts = {},
		sky = nil,
		skyProperties = {},
		ocean = nil,
		oceanColor = nil,
	}

	local colorMap = {
		["Parsley green"] = "Light grey",
		["Earth green"] = "Dark grey",
		["Sea green"] = "Light grey",
		["Bright green"] = "White",
		["Sage green"] = "White",
		["Lime green"] = "White",
		["Really green"] = "Dark grey",
		["Forest green"] = "Dark grey",
		["Dark green"] = "Dark grey",
		["Green"] = "Light grey",
	}

	local function getWinterColor(greenColorName)
		return colorMap[greenColorName] or "White"
	end

	local function isTargetPart(part)
		if not part:IsA("BasePart") and not part:IsA("MeshPart") and not part:IsA("Part") then
			return false
		end
		local name = part.Name:lower()
		return name:match("grass") or name:match("bush") or name:match("leaf") or name:match("leaves") or name:match("shrub")
	end

	local function saveOriginalData()
		pcall(function()
			local function scanChildren(parent)
				for _, child in ipairs(parent:GetChildren()) do
					if isTargetPart(child) then
						table.insert(originalData.parts, {
							part = child,
							originalColor = child.BrickColor.Name
						})
					end
					scanChildren(child)
				end
			end
			scanChildren(workspace)
			
			local sky = Lighting:FindFirstChild("Sky")
			if sky then
				originalData.sky = sky
				originalData.skyProperties = {
					SkyboxBk = sky.SkyboxBk,
					SkyboxDn = sky.SkyboxDn,
					SkyboxFt = sky.SkyboxFt,
					SkyboxLf = sky.SkyboxLf,
					SkyboxRt = sky.SkyboxRt,
					SkyboxUp = sky.SkyboxUp,
					MoonAngularSize = sky.MoonAngularSize,
					MoonTextureId = sky.MoonTextureId,
					SunAngularSize = sky.SunAngularSize,
					SunTextureId = sky.SunTextureId,
					StarCount = sky.StarCount,
					CelestialBodiesShown = sky.CelestialBodiesShown,
				}
			end
			
			local ocean = workspace:FindFirstChild("Map")
			if ocean then
				ocean = ocean:FindFirstChild("IMPORTANT")
				if ocean then
					ocean = ocean:FindFirstChild("Ocean")
				end
			end
			if ocean then
				originalData.ocean = ocean
				originalData.oceanColor = ocean.Color
			end
		end)
	end

	local function applyWinterColors()
		pcall(function()
			local function scanChildren(parent)
				for _, child in ipairs(parent:GetChildren()) do
					if isTargetPart(child) then
						local currentColor = child.BrickColor.Name
						local newColor = getWinterColor(currentColor)
						child.BrickColor = BrickColor.new(newColor)
					end
					scanChildren(child)
				end
			end
			scanChildren(workspace)
		end)
	end

	local function doWinter()
        local ocean = workspace:FindFirstChild("Map")
        if ocean then
            ocean = ocean:FindFirstChild("IMPORTANT")
            if ocean then
                ocean = ocean:FindFirstChild("Ocean")
            end
        end
        
        local sky = Lighting:FindFirstChild("Sky")
        
        if not sky or not ocean then
            return
        end
        
        ocean.Color = Color3.new(0.8, 0.9, 1)
        
        local skyTexture = "http://www.roblox.com/asset/?id=401683862"
        local skyTextureUp = "http://www.roblox.com/asset/?id=401683877"
        local skyTextureDown = "http://www.roblox.com/asset/?id=401683843"
        
        sky.SkyboxBk = skyTexture
        sky.SkyboxFt = skyTexture
        sky.SkyboxLf = skyTexture
        sky.SkyboxRt = skyTexture
        sky.SkyboxUp = skyTextureUp
        sky.SkyboxDn = skyTextureDown
        
        sky.MoonAngularSize = 11
        sky.MoonTextureId = "rbxasset://sky/moon.jpg"
        
        sky.SunAngularSize = 21
        sky.SunTextureId = "rbxasset://sky/sun.jpg"
        
        sky.StarCount = 5000
        sky.SkyboxOrientation = Vector3.new(0, 0, 0)
        sky.CelestialBodiesShown = true
        sky.Archivable = false
        sky.Name = "Sky"
    end

	local function restore()
		pcall(function()
			for _, data in ipairs(originalData.parts) do
				if data.part and data.part.Parent then
					data.part.BrickColor = BrickColor.new(data.originalColor)
				end
			end
			
			if originalData.sky and originalData.sky.Parent then
				local sky = originalData.sky
				local props = originalData.skyProperties
				sky.SkyboxBk = props.SkyboxBk
				sky.SkyboxDn = props.SkyboxDn
				sky.SkyboxFt = props.SkyboxFt
				sky.SkyboxLf = props.SkyboxLf
				sky.SkyboxRt = props.SkyboxRt
				sky.SkyboxUp = props.SkyboxUp
				sky.MoonAngularSize = props.MoonAngularSize
				sky.MoonTextureId = props.MoonTextureId
				sky.SunAngularSize = props.SunAngularSize
				sky.SunTextureId = props.SunTextureId
				sky.StarCount = props.StarCount
				sky.CelestialBodiesShown = props.CelestialBodiesShown
			end
			
			if originalData.ocean and originalData.ocean.Parent then
				originalData.ocean.Color = originalData.oceanColor
			end
		end)
	end

	saveOriginalData()
	applyWinterColors()
	doWinter()

	return {
		apply = function()
			applyWinterColors()
			doWinter()
		end,
		restore = restore
	}
end

local function deepMergeDefaults(target, defaults)
    target = type(target) == "table" and target or {}

    for key, defaultValue in pairs(defaults) do
        if type(defaultValue) == "table" then
            target[key] = deepMergeDefaults(
                target[key],
                defaultValue
            )
        elseif target[key] == nil then
            target[key] = defaultValue
        end
    end

    return target
end


local function getConfig()
    _G.Config = deepMergeDefaults(
        _G.Config,
        DEFAULT_CONFIG
    )

    return _G.Config
end


local function saveConfig()
    if type(SaveConfig) == "function" then
        task.spawn(SaveConfig)
    end
end


local function getRoot(model)
    if not model then
        return nil
    end

    return model:FindFirstChild("HumanoidRootPart")
        or model:FindFirstChild("UpperTorso")
        or model:FindFirstChild("Torso")
end


local function getPlayerPosition(player)
    if not player or not player.Character then
        return nil
    end

    local root = getRoot(player.Character)

    return root and root.Position or nil
end


local function findPlayerByModel(model)
    if not model or not model:IsA("Model") then
        return nil
    end

    local player =
        Players:GetPlayerFromCharacter(model)

    if player then
        return player
    end

    return Players:FindFirstChild(model.Name)
end


local function getPlayerFromOrigin(origin)
    if typeof(origin) ~= "Instance" then
        return nil
    end

    local current = origin
    local standMorph = nil

    while current do
        if current.Name == "StandMorph" then
            standMorph = current
        end

        if current:IsA("Model") then
            local player = findPlayerByModel(current)

            if player then
                return player
            end
        end

        current = current.Parent
    end

    if standMorph then
        current = standMorph.Parent

        while current do
            if current:IsA("Model") then
                local player = findPlayerByModel(current)

                if player then
                    return player
                end
            end

            current = current.Parent
        end
    end

    return nil
end


local function isOwnOrigin(origin)
    local character = LocalPlayer.Character

    if not character then
        return false
    end

    if typeof(origin) ~= "Instance" then
        return false
    end

    if origin == character
        or origin:IsDescendantOf(character) then
        return true
    end

    local ownStand =
        character:FindFirstChild("StandMorph")

    if ownStand then
        if origin == ownStand
            or origin:IsDescendantOf(ownStand) then
            return true
        end
    end

    return false
end


local function getAttackSet()
    local result = {}
    local attacks = getConfig().autoParryAttacks

    if type(attacks) ~= "table" then
        return result
    end

    for key, value in pairs(attacks) do
        if type(value) == "string" then
            result[value] = true
        elseif type(key) == "string" and value == true then
            result[key] = true
        end
    end

    return result
end


local function getRemoteEvent()
    local character = LocalPlayer.Character

    if not character then
        return nil
    end

    local remote =
        character:FindFirstChild("RemoteEvent")

    if remote and remote:IsA("RemoteEvent") then
        return remote
    end

    return nil
end


local function performBlock()
    local remote = getRemoteEvent()

    if not remote then
        return false
    end

    local sequence =
        getConfig().autoParryBlockSequence

    if type(sequence) ~= "table" then
        sequence =
            DEFAULT_CONFIG.autoParryBlockSequence
    end

    if sequence.releaseAttack ~= false then
        remote:FireServer("HoldAttack", {
            Bool = false,
            Type = sequence.attackType or "m1",
        })
    end

    if sequence.releaseInput then
        local input = sequence.releaseInput

        if type(input) == "string" then
            input = Enum.KeyCode[input]
        end

        remote:FireServer("InputEnded", {
            Input = input,
        })
    end

    remote:FireServer("StopBlocking", nil)

    task.wait(
        tonumber(sequence.beforeBlockDelay)
        or DEFAULT_CONFIG.autoParryBlockSequence.beforeBlockDelay
    )

    remote:FireServer("StartBlocking", nil)

    task.wait(
        tonumber(sequence.holdDuration)
        or DEFAULT_CONFIG.autoParryBlockSequence.holdDuration
    )

    remote:FireServer("StopBlocking", nil)

    return true
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character
local humanoidRootPart

local function updateCharacter(char)
    character = char
    humanoidRootPart = char:WaitForChild("HumanoidRootPart")
end

updateCharacter(player.Character or player.CharacterAdded:Wait())

player.CharacterAdded:Connect(updateCharacter)

local RADIUS = 100
local isCooldown = false
_G.zxcursed = true

local Living = workspace:FindFirstChild("Living")
if not Living then
    warn("no 'living'.")
    Living = workspace
end

function checkAnimation()
    while true do
        wait(0.01)
        if not _G.zxcursed then 
            warn('disabling...') 
            break 
        end
        if isCooldown then continue end
        
        local detected = false
        
        for _, model in ipairs(Living:GetChildren()) do
            if model:IsA("Model") and model ~= character then
                local szz = nil
                pcall(function()
                    szz = game:GetService("Players"):FindFirstChild(model.Name):FindFirstChild("PlayerStats"):FindFirstChild("Stand")
                end)

                if not szz then
                    continue
                end

                if not (
                    szz.Value:match("The World") or
                    szz.Value:match("Star Platinum")
                ) then
                    continue
                end

                local humanoid = model:FindFirstChild("Humanoid")
                local root = model:FindFirstChild("HumanoidRootPart")
                
                if humanoid and root then
                    local dist = (root.Position - humanoidRootPart.Position).Magnitude
                    
                    if dist <= RADIUS then
                        local animator = humanoid:FindFirstChild("Animator")
                        if animator then
                            local tracks = animator:GetPlayingAnimationTracks()
                            for _, track in ipairs(tracks) do
                                if track.IsPlaying and track.Animation and (track.Animation.AnimationId == "rbxassetid://4139325504" or track.Animation.AnimationId == "rbxassetid://100663149615662") then
                                    detected = true
                                    break
                                end
                            end
                        end
                    end
                end
            end
            if detected then break end
        end
        
        if detected then
            isCooldown = true
            
            wait(0.85)
            
            if _G.Config.antiTsType == "Under" then
                humanoidRootPart.Anchored = true
                for i = 1, 1 do
                    humanoidRootPart.CFrame = humanoidRootPart.CFrame - Vector3.new(0, 30, 0)
                    wait(0.01)
                end
                for i = 1, 1 do
                    humanoidRootPart.CFrame = humanoidRootPart.CFrame - Vector3.new(10, 0, 10)
                    wait(0.01)
                end
                wait(3)
                for i = 1, 1 do
                    humanoidRootPart.CFrame = humanoidRootPart.CFrame + Vector3.new(0, 35, 0)
                    wait(0.01)
                end
                humanoidRootPart.Anchored = false
            else
                humanoidRootPart.Anchored = true
                for i = 1, 2 do
                    humanoidRootPart.CFrame = humanoidRootPart.CFrame + Vector3.new(0, 25, 0)
                    wait(0.01)
                end
                wait(3)
                humanoidRootPart.Anchored = false
            end
            
            wait(2)
            isCooldown = false
        end
    end
end




-- oh shit
local RunService = game:GetService("RunService")
function timerTick(seconds)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromOffset(120, 30)
    label.Position = UDim2.fromScale(0.5, 0.8)
    label.AnchorPoint = Vector2.new(0.5, 0.5)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Parent = game:GetService("Players").LocalPlayer.PlayerGui.HUD

    local start = time()

    local con
    con = RunService.RenderStepped:Connect(function()
        local remaining = math.max(0, seconds - (time() - start))

        label.Text = ("%.2f"):format(remaining)

        if remaining <= 0 then
            con:Disconnect()
            label:Destroy()
        end
    end)
end

function makethis()
    local lpchar = game:GetService("Players").LocalPlayer.Character
    local stand = lpchar:FindFirstChild("StandMorph")
    if not stand then warn('no stand') return end
    
    local target = game:GetService("Players"):FindFirstChild(_G.Config.input_TargetSurvName)
    if not target then warn('no target') return end
    local targetChar = target.Character
    if not targetChar then warn('no target char') return end

    if _G.standConnection then
        _G.standConnection:Disconnect()
        _G.standConnection = nil
        
        local standRoot = stand:FindFirstChild("HumanoidRootPart")
        local lpRoot = lpchar:FindFirstChild("HumanoidRootPart")
        if standRoot and lpRoot then
            standRoot.CFrame = lpRoot.CFrame * CFrame.new(0, 0, 2)
        end
        
        local standAttach = stand.HumanoidRootPart:FindFirstChild("StandAttach")
        if standAttach then
            standAttach:Destroy()
        end
        
        return
    end
    
    timerTick(_G.Config.standOnlyTimeout)
    task.wait(_G.Config.standOnlyTimeout)

    local standAttach = stand.HumanoidRootPart:FindFirstChild("StandAttach")
    if standAttach then
        standAttach = standAttach:Clone()
        stand.HumanoidRootPart.StandAttach:Destroy()
    end

    local lastMoveDir = Vector3.new(0, 0, 1)

    _G.standConnection = RunService.RenderStepped:Connect(function()
        local success, err = pcall(function()
            local standRoot = stand:FindFirstChild("HumanoidRootPart")
            local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
            local lpRoot = lpchar:FindFirstChild("HumanoidRootPart")
            
            if not standRoot or not targetRoot or not lpRoot then return end

            local vel = targetRoot.AssemblyLinearVelocity
            local moveDir = Vector3.new(vel.X, 0, vel.Z)
            
            if moveDir.Magnitude > 0.5 then
                lastMoveDir = moveDir.Unit
            end
            
            local distance = 3
            if moveDir.Magnitude < 0.5 then
                distance = 0
            end
            
            local localOffset = targetRoot.CFrame:VectorToObjectSpace(lastMoveDir) * distance
            standRoot.CFrame = targetRoot.CFrame * CFrame.new(localOffset.X, 0, localOffset.Z)
        end)
        
        if not success then
            warn('stand follow error: ' .. tostring(err))
            if _G.standConnection then
                _G.standConnection:Disconnect()
                _G.standConnection = nil
            end
        end
    end)

    task.wait(_G.Config.standPilotWait)
    
    if _G.standConnection then
        _G.standConnection:Disconnect()
        _G.standConnection = nil
    end
    
    local standRoot = stand:FindFirstChild("HumanoidRootPart")
    local lpRoot = lpchar:FindFirstChild("HumanoidRootPart")
    if standRoot and lpRoot then
        standRoot.CFrame = lpRoot.CFrame * CFrame.new(0, 0, 2)
    end

    if standAttach then
        standAttach.Parent = stand.HumanoidRootPart
    end
end

-- binds

if _G.AD_FunctionsCleanup then
    pcall(_G.AD_FunctionsCleanup)
end
addFunctionConnection(UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end

    if input.KeyCode == getKey("selectTarget") then
        _G.Config.input_TargetSurvName = findTargetInCircle()
    elseif input.KeyCode == getKey("dash") then
        dash()
    elseif input.KeyCode == getKey("speedhack") then
        startSpeedhack()
    elseif input.KeyCode == getKey("fly") then
        toggleFly()
    elseif input.KeyCode == getKey("aimbot") then
        holdingAimbot = true
    elseif input.KeyCode == getKey("standPilot") and (standPilotActive or _G.Config.standPilotEnabled) then
        if _G.Config.pilotMode == "Stand Only" then
            makethis()
        else
            startStandPilot()
        end
	elseif input.KeyCode == getKey("tpToTrgt") then
		tpToSelectedTarget()
    elseif input.KeyCode == getKey("tpToDioOverHeaven") then
        tpToDioOH()
    end
end))

addFunctionConnection(UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == getKey("speedhack") then
        stopSpeedhack()
    elseif input.KeyCode == getKey("aimbot") then
        holdingAimbot = false
    end
end))

addFunctionConnection(RunService.RenderStepped:Connect(function()
    local cam = workspace.CurrentCamera
    local mouseLocation = UserInputService:GetMouseLocation()
    local inset = GuiService:GetGuiInset()
    if _G.q_circle then
        _G.q_circle.Position = Vector2.new(mouseLocation.X, mouseLocation.Y - inset.Y)
        _G.q_circle.Radius = _G.Config.circleRadius
        _G.q_circle.Visible = _G.Config.circle
    end

    if cam then
        Camera = cam
    end

    aimAtTarget()
end))

_G.AD_FunctionsCleanup = function()
    for _, conn in ipairs(functionsConnections) do
        conn:Disconnect()
    end
    functionsConnections = {}
    stopSpeedhack()
    stopFly()
    stopStandPilot()
    uninstallSilentAimbot()
    if summonedConnection then summonedConnection:Disconnect() summonedConnection = nil end
    if standChildAddedConnection then standChildAddedConnection:Disconnect() standChildAddedConnection = nil end
    clearPose()
    if _G.q_circle then
        _G.q_circle:Remove()
        _G.q_circle = nil
    end
end
end

do
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")

--------------------------------------
-- MENU START


local Library = {}
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local activeMainUI = nil
local subData = {}
local functionTabs = {}
local FUNCTION_TAB_WIDTH = 250
local FUNCTION_TAB_GAP = 10
local FUNCTION_TAB_COLUMNS = 2

_G.currentTab = nil
_G.currentIndicator = nil
_G.currentHoverFrame = nil
_G.canDrag = true
_G.currentOpenDropdown = nil

local THEMES = {
    Emerald = {
        background  = Color3.fromRGB(255, 255, 255),
        surface     = Color3.fromRGB(255, 255, 255),
        accent      = Color3.fromRGB(0, 204, 153),
        text        = Color3.fromRGB(30, 30, 30),
        textDim     = Color3.fromRGB(51, 51, 51),
        hover       = Color3.fromRGB(230, 230, 230),
        stroke      = Color3.fromRGB(210, 210, 210),
        sliderBack  = Color3.fromRGB(219, 219, 219),
        dropdownBg  = Color3.fromRGB(242, 242, 242),
        dropdownItem= Color3.fromRGB(242, 242, 242),
        scrollBar   = Color3.fromRGB(0, 204, 153),
        titleBg     = Color3.fromRGB(255, 255, 255),
        dragIcon    = Color3.fromRGB(180, 180, 180),
    },
    Violet = {
        background  = Color3.fromRGB(18, 18, 22),
        surface     = Color3.fromRGB(18, 18, 22),
        accent      = Color3.fromRGB(160, 80, 220),
        text        = Color3.fromRGB(220, 220, 225),
        textDim     = Color3.fromRGB(140, 140, 150),
        hover       = Color3.fromRGB(38, 38, 50),
        stroke      = Color3.fromRGB(55, 55, 72),
        sliderBack  = Color3.fromRGB(50, 50, 65),
        dropdownBg  = Color3.fromRGB(30, 30, 38),
        dropdownItem= Color3.fromRGB(35, 35, 45),
        scrollBar   = Color3.fromRGB(160, 80, 220),
        titleBg     = Color3.fromRGB(18, 18, 22),
        dragIcon    = Color3.fromRGB(90, 90, 110),
    },
    Crimson = {
        background  = Color3.fromRGB(26, 26, 26),
        surface     = Color3.fromRGB(26, 26, 26),
        accent      = Color3.fromRGB(164, 19, 60),
        text        = Color3.fromRGB(220, 220, 225),
        textDim     = Color3.fromRGB(140, 140, 150),
        hover       = Color3.fromRGB(164, 19, 60),
        stroke      = Color3.fromRGB(55, 55, 60),
        sliderBack  = Color3.fromRGB(45, 45, 50),
        dropdownBg  = Color3.fromRGB(30, 30, 35),
        dropdownItem= Color3.fromRGB(35, 35, 40),
        scrollBar   = Color3.fromRGB(164, 19, 60),
        titleBg     = Color3.fromRGB(26, 26, 26),
        dragIcon    = Color3.fromRGB(90, 90, 95),
    },
}

local currentThemeName = (_G.Config and THEMES[_G.Config.uiTheme]) and _G.Config.uiTheme or "Emerald"
if _G.Config then
    _G.Config.uiTheme = currentThemeName
end
local T = THEMES[currentThemeName]
local themeListeners = {}

local function fireTheme()
    for _, fn in ipairs(themeListeners) do
        pcall(fn, T)
    end
end

local function registerThemeListener(fn)
    table.insert(themeListeners, fn)
end

local ANIM_DURATION     = 0.38
local ANIM_SLIDE_OFFSET = 14
local ANIM_STYLE        = Enum.EasingStyle.Quart
local ANIM_DIR          = Enum.EasingDirection.Out

local function animateElementIn(element, delayTime)
    if not element or not element.Parent then return end
    delayTime = delayTime or 0
    local originalPos = element.Position
    element.Position = UDim2.new(
        originalPos.X.Scale, originalPos.X.Offset,
        originalPos.Y.Scale, originalPos.Y.Offset + ANIM_SLIDE_OFFSET
    )
    element.BackgroundTransparency = 1
    local textObjects = {}
    for _, child in ipairs(element:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
            child.TextTransparency = 1
            table.insert(textObjects, child)
        end
    end
    task.delay(delayTime, function()
        if not element or not element.Parent then return end
        TweenService:Create(element, TweenInfo.new(ANIM_DURATION, ANIM_STYLE, ANIM_DIR), {
            Position = originalPos,
            BackgroundTransparency = 0,
        }):Play()
        for _, obj in ipairs(textObjects) do
            if obj and obj.Parent then
                TweenService:Create(obj, TweenInfo.new(ANIM_DURATION * 0.85, ANIM_STYLE, ANIM_DIR), {
                    TextTransparency = 0,
                }):Play()
            end
        end
    end)
end

local function animateSliderFillIn(fill, targetScale, delayTime)
    delayTime = delayTime or 0
    fill.Size = UDim2.new(0, 0, 1, 0)
    task.delay(delayTime, function()
        if not fill or not fill.Parent then return end
        TweenService:Create(fill, TweenInfo.new(ANIM_DURATION + 0.1, ANIM_STYLE, ANIM_DIR), {
            Size = UDim2.new(targetScale, 0, 1, 0),
        }):Play()
    end)
end

local function animateTabElements(elementContainer, baseDelay)
    if not elementContainer then return end
    baseDelay = baseDelay or 0
    local frames = {}
    for _, child in ipairs(elementContainer:GetChildren()) do
        if child:IsA("Frame") then
            table.insert(frames, child)
        end
    end
    for i, el in ipairs(frames) do
        if not el or not el.Parent then continue end
        local delay = baseDelay + (i - 1) * 0.045
        animateElementIn(el, delay)
        local hitbox = el:FindFirstChild("SliderHitbox")
        if hitbox then
            local sBack = hitbox:FindFirstChild("SliderBack")
            if sBack then
                local fillFrame = sBack:FindFirstChild("Fill")
                if fillFrame then
                    local savedScale = fillFrame:GetAttribute("TargetScale") or fillFrame.Size.X.Scale
                    animateSliderFillIn(fillFrame, savedScale, delay + 0.06)
                end
            end
        end
    end
end

function Library:CreateMainUI()
    if activeMainUI then return nil end
    for _, gui in ipairs(CoreGui:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Name == "MainFrameGUI" then
            pcall(function() gui:Destroy() end)
        end
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MainFrameGUI"
    screenGui.Parent = CoreGui
    screenGui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 700, 0, 450)
    frame.Position = UDim2.new(0.5, -350, 0.5, -225)
    frame.BackgroundColor3 = T.background
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = false
    frame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = frame

    local frameStroke = Instance.new("UIStroke")
    frameStroke.Color = T.stroke
    frameStroke.Thickness = 1
    frameStroke.Parent = frame

    local dragBar = Instance.new("Frame")
    dragBar.Name = "DragBar"
    dragBar.Size = UDim2.new(0, 160, 0, 30)
    dragBar.Position = UDim2.new(0, 0, 0, 0)
    dragBar.BackgroundTransparency = 1
    dragBar.BorderSizePixel = 0
    dragBar.ZIndex = 10
    dragBar.Active = true
    dragBar.Parent = frame

    local dragIcon = Instance.new("TextLabel")
    dragIcon.Name = "DragIcon"
    dragIcon.Size = UDim2.new(0, 20, 0, 20)
    dragIcon.Position = UDim2.new(0, 138, 0, 5)
    dragIcon.BackgroundTransparency = 1
    dragIcon.Text = "+"
    dragIcon.TextColor3 = T.dragIcon
    dragIcon.TextSize = 16
    dragIcon.Font = Enum.Font.SourceSansBold
    dragIcon.ZIndex = 11
    dragIcon.Parent = frame

    local dragging = false
    local dragStartPos = nil
    local frameStartPos = nil

    dragBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStartPos = input.Position
            frameStartPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStartPos
            frame.Position = UDim2.new(
                frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X,
                frameStartPos.Y.Scale, frameStartPos.Y.Offset + delta.Y
            )
        end
    end)

    local welcomeFrame = Instance.new("ScrollingFrame")
    welcomeFrame.Name = "WelcomeFrame"
    welcomeFrame.Size = UDim2.new(0, 530, 0, 416)
    welcomeFrame.Position = UDim2.new(0, 170, 0, 22)
    welcomeFrame.BackgroundColor3 = T.background
    welcomeFrame.BorderSizePixel = 0
    welcomeFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    welcomeFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    welcomeFrame.ScrollBarThickness = 5
    welcomeFrame.ScrollBarImageColor3 = T.scrollBar
    welcomeFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    welcomeFrame.Parent = frame

    local themeFrame = Instance.new("Frame")
    themeFrame.Name = "ThemeSelector"
    themeFrame.Size = UDim2.new(0, 148, 0, 20)
    themeFrame.Position = UDim2.new(0, 11, 1, -26)
    themeFrame.BackgroundColor3 = T.hover
    themeFrame.BorderSizePixel = 0
    themeFrame.ZIndex = 200
    themeFrame.ClipsDescendants = false
    themeFrame.Parent = frame

    local themeFrameCorner = Instance.new("UICorner")
    themeFrameCorner.CornerRadius = UDim.new(0, 6)
    themeFrameCorner.Parent = themeFrame

    local themeLabel = Instance.new("TextLabel")
    themeLabel.Size = UDim2.new(1, -8, 1, 0)
    themeLabel.Position = UDim2.new(0, 8, 0, 0)
    themeLabel.BackgroundTransparency = 1
    themeLabel.Text = "Theme: " .. currentThemeName
    themeLabel.TextColor3 = T.textDim
    themeLabel.TextSize = 11
    themeLabel.TextXAlignment = Enum.TextXAlignment.Left
    themeLabel.Font = Enum.Font.SourceSansBold
    themeLabel.ZIndex = 201
    themeLabel.Parent = themeFrame

    local themeList = Instance.new("Frame")
    themeList.Size = UDim2.new(1, 0, 0, 0)
    themeList.Position = UDim2.new(0, 0, 1, 2)
    themeList.BackgroundColor3 = T.hover
    themeList.BackgroundTransparency = 0.5
    themeList.BorderSizePixel = 0
    themeList.ClipsDescendants = true
    themeList.ZIndex = 202
    themeList.Parent = themeFrame

    local themeListCorner = Instance.new("UICorner")
    themeListCorner.CornerRadius = UDim.new(0, 6)
    themeListCorner.Parent = themeList

    local themeListLayout = Instance.new("UIListLayout")
    themeListLayout.Padding = UDim.new(0, 2)
    themeListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    themeListLayout.Parent = themeList

    local themeOpen = false
    local themeTween = nil
    local themeNames = {"Emerald", "Violet", "Crimson"}

    local function buildThemeButtons()
        for _, c in ipairs(themeList:GetChildren()) do
            if not c:IsA("UIListLayout") then c:Destroy() end
        end
        for _, name in ipairs(themeNames) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -4, 0, 20)
            btn.BackgroundColor3 = T.dropdownItem
            btn.BackgroundTransparency = 0
            btn.BorderSizePixel = 0
            btn.Text = name
            btn.TextColor3 = name == currentThemeName and T.accent or T.textDim
            btn.TextSize = 11
            btn.Font = name == currentThemeName and Enum.Font.SourceSansBold or Enum.Font.SourceSans
            btn.ZIndex = 203
            btn.Parent = themeList

            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 5)
            btnCorner.Parent = btn

            btn.MouseButton1Click:Connect(function()
                currentThemeName = name
                T = THEMES[name]
                if _G.Config then
                    _G.Config.uiTheme = name
                    if SaveConfig then SaveConfig() end
                end
                themeLabel.Text = "Theme: " .. name
                themeOpen = false
                if themeTween then themeTween:Cancel() end
                themeTween = TweenService:Create(themeList, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2.new(1, 0, 0, 0)
                })
                themeTween:Play()
                fireTheme()
                buildThemeButtons()
            end)
        end
    end

    buildThemeButtons()

    themeFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            themeOpen = not themeOpen
            if themeTween then themeTween:Cancel() end
            if themeOpen then
                themeTween = TweenService:Create(themeList, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2.new(1, 0, 0, #themeNames * 22 + 4)
                })
            else
                themeTween = TweenService:Create(themeList, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2.new(1, 0, 0, 0)
                })
            end
            themeTween:Play()
        end
    end)

    registerThemeListener(function(theme)
        frame.BackgroundColor3 = theme.background
        frameStroke.Color = theme.stroke
        welcomeFrame.BackgroundColor3 = theme.background
        welcomeFrame.ScrollBarImageColor3 = theme.scrollBar
        themeFrame.BackgroundColor3 = theme.hover
        themeLabel.TextColor3 = theme.textDim
        themeList.BackgroundColor3 = theme.hover
        themeList.BackgroundTransparency = 0.5
        dragIcon.TextColor3 = theme.dragIcon
        buildThemeButtons()
    end)

    activeMainUI = {
        ScreenGui = screenGui,
        Frame = frame,
        WelcomeFrame = welcomeFrame,
    }

    subData = {}
    functionTabs = {}

    return activeMainUI
end

function Library:UpdateSubPositions()
    local yOffset = 35
    for i, subInfo in ipairs(subData) do
        subInfo.Frame.Position = UDim2.new(0, 10, 0, yOffset)
        yOffset = yOffset + subInfo.Height + 6
    end
end

function Library:LayoutFunctionTabs(classLabel)
    if not activeMainUI or not activeMainUI.WelcomeFrame then return end

    local columnHeights = {}
    for i = 1, FUNCTION_TAB_COLUMNS do
        columnHeights[i] = 0
    end

    for _, tabData in ipairs(functionTabs) do
        if not tabData or not tabData.frame then continue end
        if tabData.classLabel == classLabel then
            if tabData.fullWidth then
                local yOffset = math.max(columnHeights[1], columnHeights[2])
                tabData.frame.Position = UDim2.new(0, 0, 0, yOffset)
                local nextY = yOffset + tabData.frame.Size.Y.Offset + FUNCTION_TAB_GAP
                for i = 1, FUNCTION_TAB_COLUMNS do
                    columnHeights[i] = nextY
                end
                continue
            end

            local shortestColumn = 1
            for i = 2, FUNCTION_TAB_COLUMNS do
                if columnHeights[i] < columnHeights[shortestColumn] then
                    shortestColumn = i
                end
            end

            local xOffset = (shortestColumn - 1) * (FUNCTION_TAB_WIDTH + FUNCTION_TAB_GAP)
            local yOffset = columnHeights[shortestColumn]
            tabData.frame.Position = UDim2.new(0, xOffset, 0, yOffset)
            columnHeights[shortestColumn] = yOffset + tabData.frame.Size.Y.Offset + FUNCTION_TAB_GAP
        end
    end

    local maxHeight = 0
    for _, height in ipairs(columnHeights) do
        maxHeight = math.max(maxHeight, height)
    end

    activeMainUI.WelcomeFrame.CanvasSize = UDim2.new(0, 0, 0, math.max(maxHeight + 8, activeMainUI.WelcomeFrame.AbsoluteSize.Y))
end

function Library:CreateSub(text)
    if not activeMainUI then return nil end

    local subFrame = Instance.new("Frame")
    subFrame.Name = "SubFrame"
    subFrame.Size = UDim2.new(0, 150, 0, 20)
    subFrame.Position = UDim2.new(0, 10, 0, 35 + #subData * 10)
    subFrame.BackgroundColor3 = T.surface
    subFrame.BackgroundTransparency = 0
    subFrame.BorderSizePixel = 0
    subFrame.Parent = activeMainUI.Frame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = subFrame

    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "SubText"
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Position = UDim2.new(0, 10, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = T.text
    textLabel.TextSize = 14
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.Parent = subFrame

    local subInfo = {
        Frame = subFrame,
        Height = 20,
        Classes = {}
    }

    table.insert(subData, subInfo)
    Library:UpdateSubPositions()

    registerThemeListener(function(theme)
        subFrame.BackgroundColor3 = theme.surface
        textLabel.TextColor3 = theme.text
    end)

    return subFrame
end

function Library:CreateClass(text)
    if not activeMainUI then return nil end
    if #subData == 0 then return nil end

    local currentSub = subData[#subData]
    local classIndex = #currentSub.Classes + 1

    currentSub.Height = currentSub.Height + 18
    currentSub.Frame.Size = UDim2.new(0, 150, 0, currentSub.Height)

    local classLabel = Instance.new("TextLabel")
    classLabel.Name = "ClassText"
    classLabel.Size = UDim2.new(1, -20, 0, 18)
    classLabel.Position = UDim2.new(0, 10, 0, 18 + (classIndex - 1) * 21)
    classLabel.BackgroundTransparency = 1
    classLabel.Text = text
    classLabel.TextColor3 = T.textDim
    classLabel.TextSize = 16
    classLabel.TextXAlignment = Enum.TextXAlignment.Center
    classLabel.TextYAlignment = Enum.TextYAlignment.Top
    classLabel.Font = Enum.Font.SourceSans
    classLabel.ZIndex = 2
    classLabel.Parent = currentSub.Frame

    local hoverFrame = Instance.new("Frame")
    hoverFrame.Name = "HoverFrame"
    hoverFrame.Size = UDim2.new(0, 130, 0, 18)
    hoverFrame.Position = UDim2.new(0, 10, 0, classLabel.Position.Y.Offset)
    hoverFrame.BackgroundColor3 = T.hover
    hoverFrame.BackgroundTransparency = 1
    hoverFrame.BorderSizePixel = 0
    hoverFrame.ZIndex = 1
    hoverFrame.Parent = currentSub.Frame

    local hoverCorner = Instance.new("UICorner")
    hoverCorner.CornerRadius = UDim.new(0, 6)
    hoverCorner.Parent = hoverFrame

    local clickButton = Instance.new("TextButton")
    clickButton.Name = "ClickButton"
    clickButton.Size = UDim2.new(1, 0, 1, 0)
    clickButton.Position = UDim2.new(0, 0, 0, 0)
    clickButton.BackgroundTransparency = 1
    clickButton.Text = ""
    clickButton.ZIndex = 1
    clickButton.Parent = hoverFrame

    local indicator = Instance.new("Frame")
    indicator.Name = "Indicator"
    indicator.Size = UDim2.new(0, 3, 0, 0)
    indicator.Position = UDim2.new(1, -3, 0.5, 0)
    indicator.AnchorPoint = Vector2.new(1, 0.5)
    indicator.BackgroundColor3 = T.accent
    indicator.BackgroundTransparency = 0
    indicator.BorderSizePixel = 0
    indicator.ZIndex = 3
    indicator.Visible = false
    indicator.Parent = classLabel

    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(0, 2)
    indicatorCorner.Parent = indicator

    local hoverTween = nil

    local function onHover()
        if _G.currentTab ~= classLabel then
            if hoverTween then hoverTween:Cancel() end
            hoverTween = TweenService:Create(hoverFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0.5
            })
            hoverTween:Play()
        end
    end

    local function onLeave()
        if _G.currentTab ~= classLabel then
            if hoverTween then hoverTween:Cancel() end
            hoverTween = TweenService:Create(hoverFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            })
            hoverTween:Play()
        end
    end

    local function onClick()
        if activeMainUI.WelcomeFrame then
            activeMainUI.WelcomeFrame.Visible = true
            activeMainUI.WelcomeFrame.CanvasPosition = Vector2.new(0, 0)
        end

        if _G.currentHoverFrame and _G.currentHoverFrame ~= hoverFrame then
            if _G.currentHoverTween then _G.currentHoverTween:Cancel() end
            _G.currentHoverTween = TweenService:Create(_G.currentHoverFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            })
            _G.currentHoverTween:Play()
        end

        if _G.currentIndicator and _G.currentIndicator ~= indicator then
            local oldIndicator = _G.currentIndicator
            local oldTween = oldIndicator:FindFirstChild("TweenInfo")
            if oldTween then oldTween:Destroy() end
            local tweenOut = TweenService:Create(oldIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 3, 0, 0)
            })
            tweenOut:Play()
            tweenOut.Completed:Connect(function()
                oldIndicator.Visible = false
            end)
        end

        indicator.Visible = true
        indicator.Size = UDim2.new(0, 3, 0, 0)
        TweenService:Create(indicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 3, 0, 12)
        }):Play()

        _G.currentIndicator = indicator
        _G.currentTab = classLabel
        _G.currentHoverFrame = hoverFrame
        _G.currentClassLabel = classLabel

        if hoverTween then hoverTween:Cancel() end
        _G.currentHoverTween = TweenService:Create(hoverFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0.5
        })
        _G.currentHoverTween:Play()

        for _, tabData in ipairs(functionTabs) do
            if not tabData or not tabData.frame then continue end
            if tabData.classLabel == classLabel then
                tabData.frame.Visible = true
                if tabData.elementContainer then
                    animateTabElements(tabData.elementContainer, 0)
                end
            else
                tabData.frame.Visible = false
            end
        end

        Library:LayoutFunctionTabs(classLabel)
    end

    classLabel.MouseEnter:Connect(onHover)
    classLabel.MouseLeave:Connect(onLeave)
    clickButton.MouseButton1Click:Connect(onClick)

    table.insert(currentSub.Classes, classLabel)
    Library:UpdateSubPositions()

    registerThemeListener(function(theme)
        hoverFrame.BackgroundColor3 = theme.hover
        indicator.BackgroundColor3 = theme.accent
        classLabel.TextColor3 = theme.textDim
    end)

    return classLabel
end

function Library:CreateFunctionTab(classLabel, title)
    if not activeMainUI or not classLabel then return nil end

    local functionFrame = Instance.new("Frame")
    functionFrame.Name = "FunctionTab_" .. title
    functionFrame.Size = UDim2.new(0, FUNCTION_TAB_WIDTH, 0, 100)
    functionFrame.Position = UDim2.new(0, 0, 0, 0)
    functionFrame.BackgroundColor3 = T.surface
    functionFrame.BackgroundTransparency = 0
    functionFrame.BorderSizePixel = 0
    functionFrame.Visible = false
    functionFrame.Parent = activeMainUI.WelcomeFrame

    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.BackgroundColor3 = T.surface
    contentFrame.Size = UDim2.new(1, -24, 0, 76)
    contentFrame.Position = UDim2.new(0, 12, 0, 12)
    contentFrame.BorderSizePixel = 0
    contentFrame.Parent = functionFrame

    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 10)
    contentCorner.Parent = contentFrame

    local contentStroke = Instance.new("UIStroke")
    contentStroke.Color = T.stroke
    contentStroke.Transparency = 0.5
    contentStroke.Parent = contentFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.BorderSizePixel = 0
    titleLabel.BackgroundColor3 = T.titleBg
    titleLabel.Size = UDim2.new(0, 0, 0, 14)
    titleLabel.Position = UDim2.new(0, 12, 0, -7)
    titleLabel.ZIndex = 2
    titleLabel.Text = title or "Functions"
    titleLabel.TextColor3 = T.text
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    titleLabel.AutomaticSize = Enum.AutomaticSize.X
    titleLabel.Parent = contentFrame

    local elementContainer = Instance.new("Frame")
    elementContainer.Name = "ElementContainer"
    elementContainer.Size = UDim2.new(1, -32, 0, 0)
    elementContainer.Position = UDim2.new(0, 16, 0, 25)
    elementContainer.BackgroundTransparency = 1
    elementContainer.Parent = functionFrame

    local elementLayout = Instance.new("UIListLayout")
    elementLayout.Padding = UDim.new(0, 6)
    elementLayout.SortOrder = Enum.SortOrder.LayoutOrder
    elementLayout.Parent = elementContainer

    local function updateSizes()
        local contentHeight = elementLayout.AbsoluteContentSize.Y + 38
        local newHeight = math.max(76, contentHeight)
        contentFrame.Size = UDim2.new(1, -24, 0, newHeight)
        functionFrame.Size = UDim2.new(0, FUNCTION_TAB_WIDTH, 0, newHeight + 24)
        Library:LayoutFunctionTabs(classLabel)
    end

    elementLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSizes)

    local tabData = {
        frame = functionFrame,
        contentFrame = contentFrame,
        elementContainer = elementContainer,
        layout = elementLayout,
        classLabel = classLabel,
        elements = {}
    }

    table.insert(functionTabs, tabData)

    registerThemeListener(function(theme)
        functionFrame.BackgroundColor3 = theme.surface
        contentFrame.BackgroundColor3 = theme.surface
        contentStroke.Color = theme.stroke
        titleLabel.BackgroundColor3 = theme.titleBg
        titleLabel.TextColor3 = theme.text
    end)

    return tabData
end

function Library:CreateDropdown(tabData, labelText, items, defaultItem, multiSelect, callback, preferNonNoneDefault)
    if not tabData or not tabData.elementContainer then return nil end

    items = items or {}
    multiSelect = multiSelect or false
    local selectedItems = {}

    local function hasItem(list, value)
        for _, item in ipairs(list) do
            if item == value then return true end
        end
        return false
    end

    local function getFirstSelectableItem()
        for _, item in ipairs(items) do
            if item ~= "None" then return item end
        end
        return items[1] or "None"
    end

    local function getDefaultItem()
        if preferNonNoneDefault then return getFirstSelectableItem() end
        return items[1] or "None"
    end

    if multiSelect then
        if type(defaultItem) == "table" then
            for _, item in ipairs(defaultItem) do
                if hasItem(items, item) then table.insert(selectedItems, item) end
            end
        end
        if #selectedItems == 0 and #items > 0 then table.insert(selectedItems, items[1]) end
    else
        if defaultItem and hasItem(items, defaultItem) then
            selectedItems = {defaultItem}
        else
            selectedItems = {getDefaultItem()}
        end
    end

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 22)
    frame.BackgroundColor3 = T.surface
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = false
    frame.ZIndex = 1
    frame.Parent = tabData.elementContainer

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.34, -4, 1, 0)
    label.Position = UDim2.new(0, 4, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText or ""
    label.TextColor3 = T.text
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Font = Enum.Font.SourceSans
    label.ZIndex = 1
    label.Parent = frame

    local dropdownMain = Instance.new("Frame")
    dropdownMain.Size = UDim2.new(0.63, -4, 1, 0)
    dropdownMain.Position = UDim2.new(0.37, 0, 0.5, 0)
    dropdownMain.AnchorPoint = Vector2.new(0, 0.5)
    dropdownMain.BackgroundColor3 = T.dropdownBg
    dropdownMain.BackgroundTransparency = 0
    dropdownMain.BorderSizePixel = 0
    dropdownMain.ZIndex = 1
    dropdownMain.Parent = frame

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 4)
    mainCorner.Parent = dropdownMain

    local dropdownText = Instance.new("TextLabel")
    dropdownText.Size = UDim2.new(1, -8, 1, 0)
    dropdownText.Position = UDim2.new(0, 8, 0, 0)
    dropdownText.BackgroundTransparency = 1
    dropdownText.TextColor3 = T.text
    dropdownText.TextSize = 11
    dropdownText.TextXAlignment = Enum.TextXAlignment.Left
    dropdownText.TextYAlignment = Enum.TextYAlignment.Center
    dropdownText.Font = Enum.Font.SourceSans
    dropdownText.ZIndex = 1
    dropdownText.Parent = dropdownMain

    local function formatDisplayText()
        local text
        if multiSelect then
            text = #selectedItems > 0 and table.concat(selectedItems, ", ") or "None"
        else
            text = selectedItems[1] or "None"
        end
        if #text > 18 then text = string.sub(text, 1, 18) .. "..." end
        return text
    end

    dropdownText.Text = formatDisplayText()

    local dropdownList = Instance.new("Frame")
    dropdownList.Size = UDim2.new(1, 0, 0, 0)
    dropdownList.Position = UDim2.new(0, 0, 1, 2)
    dropdownList.BackgroundColor3 = T.dropdownBg
    dropdownList.BackgroundTransparency = 0
    dropdownList.BorderSizePixel = 0
    dropdownList.ClipsDescendants = true
    dropdownList.ZIndex = 99
    dropdownList.Parent = dropdownMain

    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 4)
    listCorner.Parent = dropdownList

    local listScrolling = Instance.new("ScrollingFrame")
    listScrolling.Size = UDim2.new(1, 0, 1, 0)
    listScrolling.BackgroundTransparency = 1
    listScrolling.ScrollBarThickness = 0
    listScrolling.ScrollBarImageTransparency = 1
    listScrolling.ScrollingDirection = Enum.ScrollingDirection.Y
    listScrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
    listScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
    listScrolling.ZIndex = 99
    listScrolling.Parent = dropdownList

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 1)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = listScrolling

    local isOpen = false
    local listTween = nil
    local updateListHeight

    updateListHeight = function(open)
        if open then
            local itemCount = #items + 1
            local totalHeight = itemCount * 20 + 4
            local maxHeight = 120
            local newHeight = math.min(totalHeight, maxHeight)
            if listTween then listTween:Cancel() end
            listTween = TweenService:Create(dropdownList, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(1, 0, 0, newHeight)
            })
            listTween:Play()
            dropdownMain.ZIndex = 100
            dropdownList.ZIndex = 100
            frame.ZIndex = 100
            label.ZIndex = 100
            dropdownText.ZIndex = 100
        else
            if listTween then listTween:Cancel() end
            listTween = TweenService:Create(dropdownList, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(1, 0, 0, 0)
            })
            listTween:Play()
            dropdownMain.ZIndex = 1
            dropdownList.ZIndex = 99
            frame.ZIndex = 1
            label.ZIndex = 1
            dropdownText.ZIndex = 1
        end
    end

    local function closeDropdown()
        isOpen = false
        updateListHeight(false)
    end

    local function updateDisplayText()
        dropdownText.Text = formatDisplayText()
        dropdownText.TextColor3 = T.text
    end

    local function toggleItem(itemText)
        local found = false
        for i, v in ipairs(selectedItems) do
            if v == itemText then
                table.remove(selectedItems, i)
                found = true
                break
            end
        end
        if not found and multiSelect then
            table.insert(selectedItems, itemText)
        elseif not found and not multiSelect then
            selectedItems = {itemText}
        end
        updateDisplayText()
        if callback then callback(multiSelect and selectedItems or selectedItems[1]) end
    end

    local function populateList()
        for _, child in ipairs(listScrolling:GetChildren()) do
            if not child:IsA("UIListLayout") then child:Destroy() end
        end

        local function createItem(text)
            local isSelected = false
            for _, v in ipairs(selectedItems) do
                if v == text then isSelected = true break end
            end

            local item = Instance.new("TextButton")
            item.Size = UDim2.new(1, -4, 0, 20)
            item.BackgroundColor3 = T.dropdownItem
            item.BackgroundTransparency = 0
            item.BorderSizePixel = 0
            item.Text = text
            item.TextColor3 = isSelected and T.accent or T.text
            item.TextSize = 11
            item.TextXAlignment = Enum.TextXAlignment.Left
            item.TextYAlignment = Enum.TextYAlignment.Center
            item.Font = Enum.Font.SourceSans
            item.ZIndex = 100
            item.Parent = listScrolling

            local itemCorner = Instance.new("UICorner")
            itemCorner.CornerRadius = UDim.new(0, 4)
            itemCorner.Parent = item

            item.MouseButton1Click:Connect(function()
                toggleItem(text)
                for _, childItem in ipairs(listScrolling:GetChildren()) do
                    if childItem:IsA("TextButton") then
                        local selected = false
                        for _, v in ipairs(selectedItems) do
                            if v == childItem.Text then selected = true break end
                        end
                        childItem.TextColor3 = selected and T.accent or T.text
                    end
                end
                if not multiSelect then
                    isOpen = false
                    updateListHeight(false)
                    _G.currentOpenDropdown = nil
                end
            end)

            return item
        end

        createItem("None")
        for _, itemText in ipairs(items) do createItem(itemText) end
        listScrolling.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 4)
    end

    populateList()
    updateDisplayText()

    local succ, err = pcall(function()
        if callback then callback(multiSelect and selectedItems or selectedItems[1]) end
    end)
    if not succ then warn('[MENU API] Dropdown Error: ' .. err) end

    dropdownMain.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if _G.currentOpenDropdown and _G.currentOpenDropdown.main ~= dropdownMain then
                local oldDropdown = _G.currentOpenDropdown
                oldDropdown.close()
            end
            isOpen = not isOpen
            if isOpen then
                dropdownList.Size = UDim2.new(1, 0, 0, 0)
                populateList()
                updateListHeight(true)
                _G.currentOpenDropdown = { main = dropdownMain, close = closeDropdown }
            else
                updateListHeight(false)
                _G.currentOpenDropdown = nil
            end
        end
    end)

    table.insert(tabData.elements, frame)

    registerThemeListener(function(theme)
        frame.BackgroundColor3 = theme.surface
        label.TextColor3 = theme.text
        dropdownMain.BackgroundColor3 = theme.dropdownBg
        dropdownText.TextColor3 = theme.text
        dropdownList.BackgroundColor3 = theme.dropdownBg
        populateList()
    end)

    local function updateItems(newItems)
        items = newItems or {}
        local oldSelectedItems = selectedItems
        selectedItems = {}
        if multiSelect then
            for _, oldItem in ipairs(oldSelectedItems) do
                if hasItem(items, oldItem) then table.insert(selectedItems, oldItem) end
            end
            if #selectedItems == 0 and #items > 0 then table.insert(selectedItems, getDefaultItem()) end
        else
            local oldItem = oldSelectedItems[1]
            selectedItems = {hasItem(items, oldItem) and oldItem or getDefaultItem()}
        end
        populateList()
        updateDisplayText()
    end

    return {
        SetValue = function(newValue)
            if multiSelect then
                selectedItems = {}
                if type(newValue) == "table" then
                    for _, v in ipairs(newValue) do
                        if hasItem(items, v) then table.insert(selectedItems, v) end
                    end
                else
                    if hasItem(items, newValue) then table.insert(selectedItems, newValue) end
                end
            else
                if newValue and hasItem(items, newValue) then
                    selectedItems = {newValue}
                else
                    selectedItems = {getDefaultItem()}
                end
            end
            updateDisplayText()
            populateList()
            if callback then callback(multiSelect and selectedItems or selectedItems[1]) end
        end,
        GetValue = function()
            return multiSelect and selectedItems or selectedItems[1]
        end,
        GetSelected = function()
            return selectedItems
        end,
        Update = updateItems,
        SetItems = updateItems
    }
end

function Library:CreateSlider(tabData, labelText, currentValue, min, max, callback)
    if not tabData or not tabData.elementContainer then return nil end

    local function formatSliderValue(value)
        return string.format("%.2f", tonumber(value) or 0)
    end

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 42)
    frame.BackgroundColor3 = T.surface
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.Parent = tabData.elementContainer

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.72, -4, 0, 18)
    label.Position = UDim2.new(0, 4, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = T.text
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Font = Enum.Font.SourceSans
    label.Parent = frame

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.28, -4, 0, 18)
    valueLabel.Position = UDim2.new(0.72, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = formatSliderValue(currentValue or min)
    valueLabel.TextColor3 = T.text
    valueLabel.TextSize = 12
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.TextYAlignment = Enum.TextYAlignment.Center
    valueLabel.Font = Enum.Font.SourceSans
    valueLabel.Parent = frame

    local sliderHitbox = Instance.new("Frame")
    sliderHitbox.Name = "SliderHitbox"
    sliderHitbox.Size = UDim2.new(1, -8, 0, 20)
    sliderHitbox.Position = UDim2.new(0, 4, 0, 20)
    sliderHitbox.BackgroundTransparency = 1
    sliderHitbox.Active = true
    sliderHitbox.Parent = frame

    local sliderBack = Instance.new("Frame")
    sliderBack.Name = "SliderBack"
    sliderBack.Size = UDim2.new(1, 0, 0, 4)
    sliderBack.Position = UDim2.new(0, 0, 0.5, -2)
    sliderBack.BackgroundColor3 = T.sliderBack
    sliderBack.BackgroundTransparency = 0
    sliderBack.BorderSizePixel = 0
    sliderBack.Parent = sliderHitbox

    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 2)
    sliderCorner.Parent = sliderBack

    local targetScale = math.clamp(((currentValue or min) - min) / (max - min), 0, 1)

    local fill = Instance.new("Frame")
    fill.Name = "Fill"
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = T.accent
    fill.BackgroundTransparency = 0
    fill.BorderSizePixel = 0
    fill.Parent = sliderBack

    fill:SetAttribute("TargetScale", targetScale)

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 2)
    fillCorner.Parent = fill

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 12, 0, 12)
    knob.Position = UDim2.new(1, -6, 0.5, -6)
    knob.BackgroundColor3 = T.accent
    knob.BackgroundTransparency = 0
    knob.BorderSizePixel = 0
    knob.Parent = fill

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 6)
    knobCorner.Parent = knob

    local dragging = false
    local ctrlPressed = false

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
            ctrlPressed = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
            ctrlPressed = false
        end
    end)

    local function updateSlider(inputX)
        local rel = math.clamp((inputX - sliderHitbox.AbsolutePosition.X) / sliderHitbox.AbsoluteSize.X, 0, 1)
        local value = min + (max - min) * rel
        if ctrlPressed then value = math.floor(value + 0.5) end
        value = math.max(min, math.min(max, value))
        local newRel = (value - min) / (max - min)
        fill.Size = UDim2.new(newRel, 0, 1, 0)
        fill:SetAttribute("TargetScale", newRel)
        valueLabel.Text = formatSliderValue(value)
        if callback then callback(value) end
    end

    local succ, err = pcall(function()
        if callback then callback(currentValue or min) end
    end)
    if not succ then warn("[MENU API] Slider Error: " .. err) end

    sliderHitbox.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            _G.canDrag = false
            updateSlider(input.Position.X)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    _G.canDrag = true
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input.Position.X)
        end
    end)

    table.insert(tabData.elements, frame)

    registerThemeListener(function(theme)
        frame.BackgroundColor3 = theme.surface
        label.TextColor3 = theme.text
        valueLabel.TextColor3 = theme.text
        sliderBack.BackgroundColor3 = theme.sliderBack
        fill.BackgroundColor3 = theme.accent
        knob.BackgroundColor3 = theme.accent
    end)

    return {
        SetValue = function(newValue)
            local clamped = math.clamp(newValue, min, max)
            local rel = (clamped - min) / (max - min)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            fill:SetAttribute("TargetScale", rel)
            valueLabel.Text = formatSliderValue(clamped)
            if callback then callback(clamped) end
        end,
        GetValue = function()
            local rel = fill.Size.X.Scale
            return min + (max - min) * rel
        end
    }
end

function Library:CreateToggle(tabData, text, currentValue, callback)
    if not tabData or not tabData.elementContainer then return nil end

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 26)
    frame.BackgroundColor3 = T.surface
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.Parent = tabData.elementContainer

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -8, 1, 0)
    label.Position = UDim2.new(0, 4, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = T.text
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Font = Enum.Font.SourceSans
    label.Parent = frame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.Position = UDim2.new(0, 0, 0, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = frame

    local state = currentValue == true
    local colorTween = nil

    local function updateColor(animate)
        local targetColor = state and T.accent or T.text
        if animate then
            if colorTween then colorTween:Cancel() end
            colorTween = TweenService:Create(label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextColor3 = targetColor
            })
            colorTween:Play()
        else
            label.TextColor3 = targetColor
        end
    end

    updateColor(false)

    local succ, err = pcall(function()
        if callback then callback(state) end
    end)
    if not succ then warn('[MENU API] Toggle Error: ' .. err) end

    button.MouseButton1Click:Connect(function()
        state = not state
        updateColor(true)
        if callback then callback(state) end
    end)

    table.insert(tabData.elements, frame)

    registerThemeListener(function(theme)
        frame.BackgroundColor3 = theme.surface
        label.TextColor3 = state and theme.accent or theme.text
    end)

    return {
        SetState = function(newState)
            state = newState
            updateColor(true)
        end,
        GetState = function()
            return state
        end
    }
end

function Library:CreateKeybind(tabData, action, displayName)
    if not tabData or not tabData.elementContainer then return nil end

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 32)
    frame.BackgroundColor3 = T.surface
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.Parent = tabData.elementContainer

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.48, -4, 1, 0)
    label.Position = UDim2.new(0, 4, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = displayName or action
    label.TextColor3 = T.text
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Font = Enum.Font.SourceSans
    label.Parent = frame

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(0.31, -4, 0, 24)
    input.Position = UDim2.new(0.48, 0, 0.5, -12)
    input.BackgroundColor3 = T.dropdownBg
    input.BorderSizePixel = 0
    input.ClearTextOnFocus = false
    input.Text = tostring(_G.Keybinds and _G.Keybinds[action] or "")
    input.PlaceholderText = "Key"
    input.TextColor3 = T.text
    input.TextSize = 12
    input.Font = Enum.Font.SourceSans
    input.Parent = frame

    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 4)
    inputCorner.Parent = input

    local setButton = Instance.new("TextButton")
    setButton.Size = UDim2.new(0.21, -4, 0, 24)
    setButton.Position = UDim2.new(0.79, 0, 0.5, -12)
    setButton.BackgroundColor3 = T.dropdownBg
    setButton.BorderSizePixel = 0
    setButton.Text = "Set"
    setButton.TextColor3 = T.text
    setButton.TextSize = 12
    setButton.Font = Enum.Font.SourceSansBold
    setButton.Parent = frame

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = setButton

    local captureConn = nil

    local function applyKey(keyName)
        if not keyName or keyName == "" or not Enum.KeyCode[keyName] then
            input.Text = tostring(_G.Keybinds and _G.Keybinds[action] or "")
            return false
        end
        if _G.Keybinds then _G.Keybinds[action] = keyName end
        input.Text = keyName
        if SaveKeybinds then SaveKeybinds() end
        return true
    end

    input.FocusLost:Connect(function()
        applyKey(input.Text)
    end)

    setButton.MouseButton1Click:Connect(function()
        setButton.Text = "..."
        if captureConn then captureConn:Disconnect() end
        captureConn = UserInputService.InputBegan:Connect(function(inputObject, gameProcessed)
            if gameProcessed or inputObject.UserInputType ~= Enum.UserInputType.Keyboard then return end
            applyKey(inputObject.KeyCode.Name)
            setButton.Text = "Set"
            captureConn:Disconnect()
            captureConn = nil
        end)
    end)

    table.insert(tabData.elements, frame)

    registerThemeListener(function(theme)
        frame.BackgroundColor3 = theme.surface
        label.TextColor3 = theme.text
        input.BackgroundColor3 = theme.dropdownBg
        input.TextColor3 = theme.text
        setButton.BackgroundColor3 = theme.dropdownBg
        setButton.TextColor3 = theme.text
    end)

    return {
        SetKey = applyKey,
        GetKey = function()
            return _G.Keybinds and _G.Keybinds[action]
        end
    }
end

function Library:CreateStandTab(classLabel, title, entries, callback)
    if not activeMainUI or not classLabel then return nil end

    entries = entries or {}

    for _, existingTab in ipairs(functionTabs) do
        if existingTab.classLabel == classLabel then
            warn("[MENU API] CreateStandTab can only be used in an empty class tab.")
            return nil
        end
    end

    local frame = Instance.new("Frame")
    frame.Name = "StandTab_" .. tostring(title or "Stands")
    frame.Size = UDim2.new(0, FUNCTION_TAB_WIDTH * 2 + FUNCTION_TAB_GAP, 0, 120)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    frame.Parent = activeMainUI.WelcomeFrame

    local selectedValue = nil
    local selectedStand = nil
    local currentEntries = entries
    local history = {}

    local tabData = {
        frame = frame,
        classLabel = classLabel,
        fullWidth = true,
        elements = {}
    }
    table.insert(functionTabs, tabData)

    local function normalizeEntry(entry)
        if type(entry) == "table" then
            return entry.Text or entry.Name or entry.Title or tostring(entry[1] or "Item"),
                   entry.Items or entry.Skins or entry.Children or entry[2],
                   entry.Value or entry.Id or entry.Text or entry.Name or entry.Title or tostring(entry[1] or "Item")
        end
        return tostring(entry), nil, tostring(entry)
    end

    local function clearCards()
        for _, child in ipairs(frame:GetChildren()) do child:Destroy() end
    end

    local function renderCards(list, showBack)
        clearCards()

        local cardWidth = 146
        local cardHeight = 78
        local gap = 10
        local startY = showBack and 34 or 0

        if showBack then
            local back = Instance.new("TextButton")
            back.Size = UDim2.new(0, 72, 0, 24)
            back.Position = UDim2.new(0, 0, 0, 0)
            back.BackgroundColor3 = T.dropdownBg
            back.BorderSizePixel = 0
            back.Text = "Back"
            back.TextSize = 12
            back.TextColor3 = T.text
            back.Font = Enum.Font.SourceSansBold
            back.Parent = frame
            local backCorner = Instance.new("UICorner")
            backCorner.CornerRadius = UDim.new(0, 6)
            backCorner.Parent = back
            back.MouseButton1Click:Connect(function()
                currentEntries = table.remove(history) or entries
                if #history == 0 then selectedStand = nil end
                renderCards(currentEntries, #history > 0)
            end)
        end

        for index, entry in ipairs(list) do
            local text, children, value = normalizeEntry(entry)
            local row = math.floor((index - 1) / 3)
            local col = (index - 1) % 3

            local card = Instance.new("TextButton")
            card.Size = UDim2.new(0, cardWidth, 0, cardHeight)
            card.Position = UDim2.new(0, col * (cardWidth + gap), 0, startY + row * (cardHeight + gap))
            card.BackgroundColor3 = T.surface
            card.BorderSizePixel = 0
            card.Text = ""
            card.AutoButtonColor = true
            card.Parent = frame

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = card

            local stroke = Instance.new("UIStroke")
            stroke.Transparency = selectedValue == value and 0 or 0.82
            stroke.Thickness = selectedValue == value and 2 or 1
            stroke.Color = selectedValue == value and T.accent or T.stroke
            stroke.Parent = card

            local cardText = Instance.new("TextLabel")
            cardText.Size = UDim2.new(1, -14, 0, 18)
            cardText.Position = UDim2.new(0, 8, 1, -24)
            cardText.BackgroundTransparency = 1
            cardText.Text = text
            cardText.TextColor3 = T.text
            cardText.TextSize = 12
            cardText.TextXAlignment = Enum.TextXAlignment.Left
            cardText.TextYAlignment = Enum.TextYAlignment.Center
            cardText.Font = Enum.Font.SourceSansBold
            cardText.Parent = card

            card.MouseButton1Click:Connect(function()
                if children and #children > 0 then
                    selectedStand = value
                    table.insert(history, currentEntries)
                    currentEntries = children
                    renderCards(currentEntries, true)
                    return
                end
                selectedValue = value
                if callback then callback(selectedStand, value) end
                renderCards(currentEntries, #history > 0)
            end)
        end

        local rows = math.max(1, math.ceil(#list / 3))
        frame.Size = UDim2.new(0, FUNCTION_TAB_WIDTH * 2 + FUNCTION_TAB_GAP, 0,
            startY + rows * cardHeight + math.max(0, rows - 1) * gap)
        Library:LayoutFunctionTabs(classLabel)
    end

    renderCards(entries, false)

    return {
        SetItems = function(newEntries)
            entries = newEntries or {}
            currentEntries = entries
            history = {}
            selectedStand = nil
            renderCards(entries, false)
        end,
        GetSelected = function() return selectedValue end,
        SetSelected = function(value)
            selectedValue = value
            renderCards(currentEntries, #history > 0)
        end
    }
end

function Library:DestroyUI()
    if activeMainUI then
        activeMainUI.ScreenGui:Destroy()
        activeMainUI = nil
        subData = {}
        functionTabs = {}
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if not activeMainUI or not activeMainUI.Frame then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

    local openMenuKey = getKey and getKey("OpenMenu") or Enum.KeyCode.Delete
    if input.KeyCode == openMenuKey then
        activeMainUI.Frame.Visible = not activeMainUI.Frame.Visible
    end
end)

local function updateDropdownItems(dropdown, items)
    if not dropdown then return false end
    if type(dropdown.Update) == "function" then
        dropdown.Update(items)
        return true
    end
    if type(dropdown.SetItems) == "function" then
        dropdown.SetItems(items)
        return true
    end
    return false
end

-- MENU END
-----------------------------------------------

Library:CreateMainUI()

_G.q_circle = Drawing.new("Circle")
_G.q_circle.Thickness = 1
_G.q_circle.NumSides = 80
_G.q_circle.Filled = false
_G.q_circle.Transparency = 1
_G.q_circle.Color = Color3.fromRGB(255, 255, 255)
_G.q_circle.Visible = false
_G.q_circle.Radius = _G.Config.circleRadius

-- ESP TAB
Library:CreateSub("Cheeze")
local tab_esp = Library:CreateClass("ESP")
local basicSettingsSection = Library:CreateFunctionTab(tab_esp, "Basic Settings")
Library:CreateToggle(basicSettingsSection, "Show Box", _G.Config.showBox, function(v)
    _G.Config.showBox = v
    SaveConfig()
end)
Library:CreateToggle(basicSettingsSection, "Show Name", _G.Config.showName, function(v)
    _G.Config.showName = v
    SaveConfig()
end)
Library:CreateToggle(basicSettingsSection, "Show Distance", _G.Config.showDistance, function(v)
    _G.Config.showDistance = v
    SaveConfig()
end)
Library:CreateToggle(basicSettingsSection, "Show Skeleton", _G.Config.showSkeleton, function(v)
    _G.Config.showSkeleton = v
    SaveConfig()
end)
Library:CreateToggle(basicSettingsSection, "Show Health Bar", _G.Config.showHealthBar, function(v)
    _G.Config.showHealthBar = v
    SaveConfig()
end)
-- Library:CreateToggle(basicSettingsSection, "Show Health Text", _G.Config.showHealthText, function(v)
--     _G.Config.showHealthText = v
--     SaveConfig()
-- end)
Library:CreateToggle(basicSettingsSection, "Show Tracers", _G.Config.showTracers, function(v)
    _G.Config.showTracers = v
    SaveConfig()
end)
Library:CreateToggle(basicSettingsSection, "Show Block Capacity", _G.Config.showBlockCapacity, function(v)
    _G.Config.showBlockCapacity = v
    SaveConfig()
end)
Library:CreateToggle(basicSettingsSection, "Tracer To Near Player", _G.Config.tracerToNearPlayer, function(v)
    _G.Config.tracerToNearPlayer = v
    SaveConfig()
end)
Library:CreateToggle(basicSettingsSection, "Show Selected Tag", _G.Config.showSelectedTag, function(v)
    _G.Config.showSelectedTag = v
    SaveConfig()
end)
function dwnld(fileName)
    local success, data = pcall(function()
        return game:HttpGet(_G.nga_link .. "?s=" .. fileName)
    end)

    if not success then
        warn("Failed to download file:", fileName)
        return false
    end

    writefile("ad/" .. fileName, data)

    return true
end
local assetstable = {
    "aerosmith",
    "anubis",
    "beachboy",
    "boxing",
    "chariotrequiem",
    "cmoon",
    "crazydiamond",
    "crazydiamondrequiem",
    "cream",
    "d4c",
    "d4clovetrain",
    "diverdown",
    "goldexperience",
    "goldexperiencerequiem",
    "hamon",
    "hermitpurple",
    "hierophantgreen",
    "killerqueen",
    "killerqueenbitesthedust",
    "kingcrimson",
    "kingcrimsonrequiem",
    "madeinheaven",
    "mrpresident",
    "swordstyle",
    "purplehaze",
    "redhotchilipepper",
    "redhotchilipepperalternativeuniverse",
    "scarymonsters",
    "shadowtheworld",
    "silverchariot",
    "spin",
    "starplatinum",
    "starplatinumtheworld",
    "stonefree",
    "thehand",
    "theworld",
    "theworldalternateuniverse",
    "theworldoverheaven",
    "tuskact1",
    "tuskact2",
    "tuskact3",
    "tuskact4",
    "vampirism",
    "whitealbum",
    "whitesnake",
    "weatherreport",
}

local function checkAssets()
    for _, name in ipairs(assetstable) do
        local path = "ad/" .. name .. ".png"
        if not isfile(path) then
            if dwnld then
                dwnld(name .. ".png")
            end
        end
    end
end
Library:CreateToggle(basicSettingsSection, "Show Stand & Spec", _G.Config.showStandNspec, function(v)
    _G.Config.showStandNspec = v
    SaveConfig()
    if v then
        checkAssets()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer
        local Camera = workspace.CurrentCamera
        local ScreenGui = Instance.new("ScreenGui")
        function delbradar()
            local oldGui = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("SpecESP")
            if oldGui then
                oldGui:Destroy()
            end
        end
        repeat delbradar() until not LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("SpecESP")
        ScreenGui.Name = "SpecESP"
        ScreenGui.ResetOnSpawn = false
        ScreenGui.IgnoreGuiInset = true
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

        _G.SPECESP_ENABLED = true

        local MAX_DISTANCE = 80
        local OFFSET_X = 60
        local OFFSET_Y = -32
        local LEFT_OFFSET_X = -120
        local IMAGE_SIZE = 64

        local specFolder = "ad/"
        local standFolder = "ad/"

        local espLabels = {}
        local standLabels = {}

        local function worldToScreen(pos)
            local vec, onScreen = Camera:WorldToScreenPoint(pos)
            if not onScreen then return nil end
            return Vector2.new(vec.X, vec.Y)
        end

        local function getValue(player, statName)
            local stats = player:FindFirstChild("PlayerStats")
            if not stats then return nil end
            local value = stats:FindFirstChild(statName)
            if not value then return nil end
            return value.Value
        end

        local function normalize(str)
            if not str then return nil end
            local s = str:lower()
            s = s:gsub("%s+", "")
            s = s:gsub("%-", "")
            s = s:gsub(":", "")
            s = s:gsub("%.", "")
            s = s:gsub(",", "")
            s = s:gsub("'", "")
            s = s:gsub('"', "")
            s = s:gsub("!", "")
            s = s:gsub("%?", "")
            s = s:gsub("_", "")
            s = s:gsub("/", "")
            s = s:gsub("\\", "")
            return s
        end

        local cachedFiles = {}

        local function refreshFileCache()
            cachedFiles = {}
            local ok, files = pcall(listfiles, "ad")
            if not ok or not files then return end
            for _, fullPath in ipairs(files) do
                local name = fullPath:match("([^/\\]+)%.png$")
                if name then
                    cachedFiles[#cachedFiles + 1] = name:lower()
                end
            end
            table.sort(cachedFiles, function(a, b)
                return #a > #b
            end)
        end

        refreshFileCache()

        local function getAssetPath(folder, value)
            if not value then return nil end
            local normalized = normalize(value)
            if not normalized or normalized == "" then return nil end

            for _, fileName in ipairs(cachedFiles) do
                if normalized:find(fileName, 1, true) then
                    return folder .. fileName .. ".png"
                end
            end

            return folder .. normalized .. ".png"
        end

        local function cleanupLabel(container, player)
            if container[player] then
                container[player]:Destroy()
                container[player] = nil
            end
        end

        local function createLabel(container, player)
            cleanupLabel(container, player)
            local label = Instance.new("ImageLabel")
            label.Size = UDim2.fromOffset(IMAGE_SIZE, IMAGE_SIZE)
            label.BackgroundTransparency = 1
            label.Visible = false
            label.ScaleType = Enum.ScaleType.Fit
            label.Parent = ScreenGui
            container[player] = label
        end

        local function updateEZP()
            if not _G.SPECESP_ENABLED then
                for _, label in pairs(espLabels) do
                    label.Visible = false
                end
                for _, label in pairs(standLabels) do
                    label.Visible = false
                end
                return
            end

            local myChar = LocalPlayer.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")

            for _, player in ipairs(Players:GetPlayers()) do
                if player == LocalPlayer then continue end

                if not espLabels[player] then
                    createLabel(espLabels, player)
                end
                if not standLabels[player] then
                    createLabel(standLabels, player)
                end

                local specLabel = espLabels[player]
                local standLabel = standLabels[player]

                local character = player.Character
                if not character then
                    specLabel.Visible = false
                    standLabel.Visible = false
                    continue
                end

                local root = character:FindFirstChild("HumanoidRootPart")
                if not root then
                    specLabel.Visible = false
                    standLabel.Visible = false
                    continue
                end

                if myRoot then
                    local dist = (root.Position - myRoot.Position).Magnitude
                    if dist > MAX_DISTANCE then
                        specLabel.Visible = false
                        standLabel.Visible = false
                        continue
                    end
                end

                local screenPos = worldToScreen(root.Position)
                if not screenPos then
                    specLabel.Visible = false
                    standLabel.Visible = false
                    continue
                end

                local specValue = getValue(player, "Spec")
                local specPath = getAssetPath(specFolder, specValue)
                if specPath and isfile(specPath) then
                    specLabel.Image = getcustomasset(specPath)
                    specLabel.Size = UDim2.fromOffset(IMAGE_SIZE, IMAGE_SIZE)
                    specLabel.Position = UDim2.fromOffset(screenPos.X + OFFSET_X, screenPos.Y + OFFSET_Y)
                    specLabel.Visible = true
                else
                    specLabel.Visible = false
                end

                local standValue = getValue(player, "Stand")
                local standPath = getAssetPath(standFolder, standValue)
                if standPath and isfile(standPath) then
                    standLabel.Image = getcustomasset(standPath)
                    standLabel.Size = UDim2.fromOffset(IMAGE_SIZE, IMAGE_SIZE)
                    standLabel.Position = UDim2.fromOffset(screenPos.X + LEFT_OFFSET_X, screenPos.Y + OFFSET_Y)
                    standLabel.Visible = true
                else
                    standLabel.Visible = false
                end
            end
        end

        _G.SPECESP_CLEAR = function()
            for _, label in pairs(espLabels) do
                label:Destroy()
            end
            for _, label in pairs(standLabels) do
                label:Destroy()
            end
            espLabels = {}
            standLabels = {}
        end

        if _G.rqrqr1 then
            _G.rqrqr1:Disconnect()
            _G.SPECESP_CLEAR()
        end
        if _G.rqrqr2 then
            _G.rqrqr2:Disconnect()
            _G.SPECESP_CLEAR()
        end
        _G.rqrqr1 = Players.PlayerRemoving:Connect(function(player)
            cleanupLabel(espLabels, player)
            cleanupLabel(standLabels, player)
        end)

        _G.rqrqr2 = RunService.RenderStepped:Connect(updateEZP)
    else
        if _G.rqrqr1 then
            _G.rqrqr1:Disconnect()
            if _G.SPECESP_CLEAR then _G.SPECESP_CLEAR() end
        end
        if _G.rqrqr2 then
            _G.rqrqr2:Disconnect()
            if _G.SPECESP_CLEAR then _G.SPECESP_CLEAR() end
        end
    end
end)
Library:CreateToggle(basicSettingsSection, "Show Attacks", _G.Config.showAttacks, function(v)
    _G.Config.showAttacks = v
    SaveConfig()

    if v then
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local LocalPlayer = Players.LocalPlayer
        local Camera = workspace.CurrentCamera
        _G.FXESP_ENABLED = true
        local playerFX = {}
        local IGNORED_FX = {
            ["Sound"] = true,
            ["HitEffect"] = true,
            ["Damage Indicator"] = true,
            ["Stand Fade"] = true,
            ["Cycle Slash Hit"] = true,
            ["Finisher"] = true
        }
        local function isSoundFX(fxName)
            if type(fxName) ~= "string" then return true end
            local lower = fxName:lower()
            for key, _ in pairs(IGNORED_FX) do
                if lower:find(key:lower(), 1, true) then
                    return true
                end
            end
            if lower:find("sound") or lower:find("audio") or lower:find("music") then
                return true
            end
            return false
        end
        if _G.bigcock1 then
            _G.bigcock1:Disconnect()
        end
        if _G.bigcock2 then
            _G.bigcock2:Disconnect()
        end
        if _G.bigcock3 then
            _G.bigcock3:Disconnect()
        end
        local ClientFX = ReplicatedStorage:WaitForChild("ClientFX", 10)
        if ClientFX then
            _G.bigcock1 = ClientFX.OnClientEvent:Connect(function(fxName, data)
                if isSoundFX(fxName) then return end
                if type(fxName) ~= "string" then return end
                local sourcePlayer = nil
                if data and type(data) == "table" then
                    local origin = data.Origin
                    if origin then
                        local character = origin:FindFirstAncestorOfClass("Model")
                        if character then
                            local player = Players:GetPlayerFromCharacter(character)
                            if player then
                                sourcePlayer = player
                            end
                        end
                    end
                    if not sourcePlayer and data.Player then
                        if typeof(data.Player) == "Instance" and data.Player:IsA("Player") then
                            sourcePlayer = data.Player
                        end
                    end
                end
                if not sourcePlayer then return end
                if sourcePlayer == LocalPlayer then return end
                playerFX[sourcePlayer] = {
                    name = fxName,
                    time = tick(),
                }
            end)
        end
        _G.bigcock2 = Players.PlayerRemoving:Connect(function(player)
            playerFX[player] = nil
        end)
        local espObjects = {}
        local function clearESP()
            for _, obj in pairs(espObjects) do
                obj:Remove()
            end
            espObjects = {}
        end
        local function worldToScreen(pos)
            local vec, onScreen = Camera:WorldToScreenPoint(pos)
            if not onScreen then return nil end
            return Vector2.new(vec.X, vec.Y)
        end
        local function drawESP()
            clearESP()
            if not _G.FXESP_ENABLED then return end
            local now = tick()
            for player, fxData in pairs(playerFX) do
                if now - fxData.time > 1 then
                    playerFX[player] = nil
                    continue
                end
                if not player.Character then continue end
                local root = player.Character:FindFirstChild("HumanoidRootPart")
                if not root then continue end
                local feetPos = root.Position - Vector3.new(0, 3, 0)
                local screenPos = worldToScreen(feetPos)
                if not screenPos then continue end
                local text = Drawing.new("Text")
                text.Text = fxData.name
                text.Position = Vector2.new(screenPos.X, screenPos.Y + 90)
                text.Color = Color3.fromRGB(_G.Config.saR,_G.Config.saG,_G.Config.saB)
                text.Size = 16
                text.Center = true
                text.Outline = true
                text.OutlineColor = Color3.fromRGB(0, 0, 0)
                text.Visible = true
                table.insert(espObjects, text)
            end
        end
        _G.bigcock3 = RunService.RenderStepped:Connect(drawESP)
        _G.FXESP_CLEAR = function() playerFX = {} end
    else
        if _G.bigcock1 then
            _G.bigcock1:Disconnect()
        end
        if _G.bigcock2 then
            _G.bigcock2:Disconnect()
        end
        if _G.bigcock3 then
            _G.bigcock3:Disconnect()
        end
    end
end)
local advancedSettingsSection = Library:CreateFunctionTab(tab_esp, "Advanced Settings")
-- Library:CreateToggle(advancedSettingsSection, "ESP Fade By Distance", _G.Config.espFadeByDistance, function(v)
--     _G.Config.espFadeByDistance = v
--     SaveConfig()
-- end)
-- Library:CreateToggle(advancedSettingsSection, "ESP Filled Box", _G.Config.espFilledBox, function(v)
--     _G.Config.espFilledBox = v
--     SaveConfig()
-- end)
-- Library:CreateToggle(advancedSettingsSection, "ESP Full Box", _G.Config.espFullBox, function(v)
--     _G.Config.espFullBox = v
--     SaveConfig()
-- end)
-- Library:CreateToggle(advancedSettingsSection, "ESP Corner Box", _G.Config.espCornerBox, function(v)
--     _G.Config.espCornerBox = v
--     SaveConfig()
-- end)
-- Library:CreateToggle(advancedSettingsSection, "ESP Animated Gradient", _G.Config.espAnimatedGradient, function(v)
--     _G.Config.espAnimatedGradient = v
--     SaveConfig()
-- end)
Library:CreateToggle(advancedSettingsSection, "Change Box Color", _G.Config.changeBoxColor, function(v)
    _G.Config.changeBoxColor = v
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Box, R", _G.Config.boxR, 0, 255, function(v)
    _G.Config.boxR = math.floor(v)
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Box, G", _G.Config.boxG, 0, 255, function(v)
    _G.Config.boxG = math.floor(v)
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Box, B", _G.Config.boxB, 0, 255, function(v)
    _G.Config.boxB = math.floor(v)
    SaveConfig()
end)
Library:CreateToggle(advancedSettingsSection, "Change Name Color", _G.Config.changeNameColor, function(v)
    _G.Config.changeNameColor = v
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Name, R", _G.Config.nameR, 0, 255, function(v)
    _G.Config.nameR = math.floor(v)
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Name, G", _G.Config.nameG, 0, 255, function(v)
    _G.Config.nameG = math.floor(v)
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Name, B", _G.Config.nameB, 0, 255, function(v)
    _G.Config.nameB = math.floor(v)
    SaveConfig()
end)
Library:CreateToggle(advancedSettingsSection, "Change Distance Color", _G.Config.changeDistanceColor, function(v)
    _G.Config.changeDistanceColor = v
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Distance, R", _G.Config.distanceR, 0, 255, function(v)
    _G.Config.distanceR = math.floor(v)
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Distance, G", _G.Config.distanceG, 0, 255, function(v)
    _G.Config.distanceG = math.floor(v)
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Distance, B", _G.Config.distanceB, 0, 255, function(v)
    _G.Config.distanceB = math.floor(v)
    SaveConfig()
end)
Library:CreateToggle(advancedSettingsSection, "Change Skeleton Color", _G.Config.changeSkeletonColor, function(v)
    _G.Config.changeSkeletonColor = v
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Skeleton, R", _G.Config.skeletonR, 0, 255, function(v)
    _G.Config.skeletonR = math.floor(v)
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Skeleton, G", _G.Config.skeletonG, 0, 255, function(v)
    _G.Config.skeletonG = math.floor(v)
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Skeleton, B", _G.Config.skeletonB, 0, 255, function(v)
    _G.Config.skeletonB = math.floor(v)
    SaveConfig()
end)
Library:CreateToggle(advancedSettingsSection, "Change Tracer Color", _G.Config.changeTracerColor, function(v)
    _G.Config.changeTracerColor = v
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Tracer, R", _G.Config.tracerR, 0, 255, function(v)
    _G.Config.tracerR = math.floor(v)
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Tracer, G", _G.Config.tracerG, 0, 255, function(v)
    _G.Config.tracerG = math.floor(v)
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Tracer, B", _G.Config.tracerB, 0, 255, function(v)
    _G.Config.tracerB = math.floor(v)
    SaveConfig()
end)
Library:CreateToggle(advancedSettingsSection, "Change Selected Tag Color", _G.Config.changeSelectedTagColor, function(v)
    _G.Config.changeSelectedTagColor = v
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Selected Tag, R", _G.Config.selectedTagR, 0, 255, function(v)
    _G.Config.selectedTagR = math.floor(v)
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Selected Tag, G", _G.Config.selectedTagG, 0, 255, function(v)
    _G.Config.selectedTagG = math.floor(v)
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Selected Tag, B", _G.Config.selectedTagB, 0, 255, function(v)
    _G.Config.selectedTagB = math.floor(v)
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Show Attacks, R", _G.Config.saR, 0, 255, function(v)
    _G.Config.saR = math.floor(v)
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Show Attacks, G", _G.Config.saG, 0, 255, function(v)
    _G.Config.saG = math.floor(v)
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Show Attacks, B", _G.Config.saB, 0, 255, function(v)
    _G.Config.saB = math.floor(v)
    SaveConfig()
end)
Library:CreateToggle(advancedSettingsSection, "Change Max Visibility Distance", _G.Config.changeMaxVisibilityDistance, function(v)
    _G.Config.changeMaxVisibilityDistance = v
    SaveConfig()
end)
Library:CreateSlider(advancedSettingsSection, "Distance", _G.Config.maxVisibilityDistance, 10, 5000, function(v)
    _G.Config.maxVisibilityDistance = math.floor(v)
    SaveConfig()
end)

-- FUNCTIONS TAB
local tab_functions = Library:CreateClass("Functions")
local movementSection = Library:CreateFunctionTab(tab_functions, "Movement")
Library:CreateToggle(movementSection, "Enable Dash", _G.Config.enableDash, function(v)
    _G.Config.enableDash = v
    SaveConfig()
end)
Library:CreateSlider(movementSection, "Dash Distance", _G.Config.dashDistance, 1, 70, function(v)
    _G.Config.dashDistance = math.floor(v)
    SaveConfig()
end)
Library:CreateToggle(movementSection, "Enable Speedhack", _G.Config.enableSpeedhack, function(v)
    _G.Config.enableSpeedhack = v
    if not v then stopSpeedhack() end
    SaveConfig()
end)
Library:CreateSlider(movementSection, "Speedhack Value", _G.Config.speedhackValue, 0, 5, function(v)
    _G.Config.speedhackValue = v
    SaveConfig()
end)
Library:CreateToggle(movementSection, "Enable Fly", _G.Config.enableFly, function(v)
    _G.Config.enableFly = v
    if not v then stopFly() end
    SaveConfig()
end)
Library:CreateSlider(movementSection, "Fly Speed", _G.Config.flySpeed, 10, 500, function(v)
    _G.Config.flySpeed = math.floor(v)
    SaveConfig()
end)
Library:CreateToggle(movementSection, "Speed Exploits", _G.Config.enableSpeedExploits, function(val)
    _G.Config.enableSpeedExploits = val

    if _G.Config.enableSpeedExploits then
        pcall(function()
            if _G.qwe then _G.qwe:Disconnect() end
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local LocalPlayer = Players.LocalPlayer
            local lastPosition = nil
            _G.qwe = RunService.RenderStepped:Connect(function(dt)
                local char = workspace.Living:FindFirstChild(LocalPlayer.Name)
                if not char then
                    lastPosition = nil
                    return
                end

                local hrp = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChild("Humanoid")
                if not hrp or not hum then
                    lastPosition = nil
                    return
                end

                local ws = hum.WalkSpeed
                local moveDir = hum.MoveDirection

                local targetSpeed = nil
                if ws == 10 then
                    targetSpeed = _G.Config.speedExploitsVal
                elseif ws == 12 then
                    targetSpeed = _G.Config.speedExploitsVal
                elseif ws == 6 then
                    targetSpeed = _G.Config.speedExploitsVal
                elseif ws == 8 then
                    targetSpeed = _G.Config.speedExploitsVal
                elseif ws == 2 then
                    targetSpeed = _G.Config.speedExploitsVal
                end

                if targetSpeed and moveDir.Magnitude > 0 and lastPosition then
                    local gameMove = hrp.Position - lastPosition
                    local horizontalMove = Vector3.new(gameMove.X, 0, gameMove.Z)
                    local moveMagnitude = horizontalMove.Magnitude

                    local maxLegitMove = ws * dt * 1.5

                    if moveMagnitude <= maxLegitMove then
                        hrp.CFrame = hrp.CFrame - horizontalMove

                        local direction = Vector3.new(moveDir.X, 0, moveDir.Z).Unit
                        local moveDistance = targetSpeed * dt
                        hrp.CFrame = hrp.CFrame + direction * moveDistance
                    end
                end

                lastPosition = hrp.Position
            end)
        end)
    else
        if _G.qwe then _G.qwe:Disconnect() end
    end
    SaveConfig()
end)
Library:CreateSlider(movementSection, "Speed Exploits: Speed Value", _G.Config.speedExploitsVal, 1, 50, function(val)
    _G.Config.speedExploitsVal = val
    SaveConfig()
end)
Library:CreateToggle(movementSection, "Mobile Exploit", _G.Config.enableMobileExploit, function(state)
    _G.Config.enableMobileExploit = state
    SaveConfig()
end)
Library:CreateSlider(movementSection, "Mobile Exploit: Strafe Speed", _G.Config.meStrafeSpeed, 1, 100, function(val)
    _G.Config.meStrafeSpeed = val
    SaveConfig()
end)
Library:CreateSlider(movementSection, "Mobile Exploit: Jump Power", _G.Config.meJumpPower, 1, 100, function(val)
    _G.Config.meJumpPower = val
    SaveConfig()
end)

Library:CreateToggle(movementSection, "Anti Time Stop", _G.Config.enableAntiTS, function(state)
    _G.Config.enableAntiTS = state
    if state then
        _G.zxcursed = true
        task.spawn(checkAnimation)
    else
        _G.zxcursed = false
    end
    SaveConfig()
end)
Library:CreateDropdown(movementSection, "Anti Time Stop Type", { "Under", "Up" }, _G.Config.antiTsType, false, function(v)
    _G.Config.antiTsType = v
    SaveConfig()
end)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer



local ClientFX = ReplicatedStorage:FindFirstChild("ClientFX")
if not ClientFX then
    warn("5702 -> ClientFX not found")
    return
end
local function getLookDirection()
    local cam = Workspace.CurrentCamera
    if not cam then return nil end

    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
        return cam.CFrame.LookVector
    else
        local mouse = LocalPlayer:GetMouse()
        if mouse then
            local screenPos = Vector2.new(mouse.X, mouse.Y)
            local unitRay = cam:ScreenPointToRay(screenPos.X, screenPos.Y, 1)
            local mousePos = cam.CFrame.Position + unitRay.Direction * 10000
            return (mousePos - cam.CFrame.Position).Unit
        end
        return cam.CFrame.LookVector
    end
end
local function teleportUp()
    if not _G.Config.unlockTimeSkip then return end
    local char = LocalPlayer.Character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    local lookDir = getLookDirection()
    if not lookDir then return end

    local verticalAngle = math.asin(math.clamp(lookDir.Y, -1, 1))

    if verticalAngle > _G.Config.timeSkipAngle then
        local finalPos = hrp.Position + Vector3.new(0, 40, 0)

        hum:ChangeState(Enum.HumanoidStateType.Jumping)
        task.wait(0.08)

        hrp.CFrame = CFrame.new(finalPos)
        print("[TimeSkip TP] Teleported UP!")
    else
        print("[TimeSkip TP] Camera not aimed up - ignored")
    end
end

_G.ezzz = ClientFX.OnClientEvent:Connect(function(markerType, data)
    if not markerType or not markerType:match("Time Skip") then
        return
    end
    if type(data) ~= "table" then return end

    local origin = data.Origin
    if not origin then return end

    local char = LocalPlayer.Character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if origin == hrp or origin:IsDescendantOf(char) then
        task.spawn(teleportUp)
    end
end)
Library:CreateToggle(movementSection, "Unlock Time Skip", _G.Config.unlockTimeSkip, function(state)
    _G.Config.unlockTimeSkip = state
    SaveConfig()
end)
Library:CreateSlider(movementSection, "Time Skip React Angle", _G.Config.timeSkipAngle, 0, 1, function(val)
    _G.Config.timeSkipAngle = val
    SaveConfig()
end)

Library:CreateToggle(movementSection, "Boxing Shuffle Modificator", _G.Config.enableBoxModify, function(state)
    _G.Config.enableBoxModify = state
    SaveConfig()
end)
Library:CreateSlider(movementSection, "Shuffle Cooldown", _G.Config.shuffleCd, 0, 8, function(val)
    _G.Config.shuffleCd = val
    SaveConfig()
end)
Library:CreateSlider(movementSection, "Shuffle Distance", _G.Config.shuffleDist, 0, 10, function(val)
    _G.Config.shuffleDist = val
    SaveConfig()
end)

local autoParrySection = Library:CreateFunctionTab(tab_functions, "Auto Parry")
local function updateAutoParry(methodName, ...)
    local autoParry = _G.AutoParry
    if autoParry and type(autoParry[methodName]) == "function" then
        pcall(autoParry[methodName], ...)
    end
end

-- auto parry

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local ClientFX = ReplicatedStorage:FindFirstChild("ClientFX")
local ClientVFX = ReplicatedStorage:FindFirstChild("ClientVFX")

if not ClientFX and not ClientVFX then
    warn("[AutoParry] ClientFX and ClientVFX not found")
    return
end

local PARRY_CONFIG = {
    enabled = true,
    radius = 15,
    cooldown = 1,
    attacks = {
        "HeavyMarker",
        "Reality Overwriting Punch",
    },
    blockSeq = {
        releaseAttack = true,
        releaseInput = "E",
        beforeBlockDelay = 0.1,
        holdDuration = 0.3,
        waitBfBlock = 0.3,
    },
}

local FINISHER_SOUNDS = {
    "Purple Haze Finisher",
    "Red Hot Chili Pepper Finisher",
    "Scary Monsters Finisher",
    "Silver Chariot Finisher",
    "Six Pistols Finisher",
    "Soft & Wet Finisher",
    "Soft & Wet: Go Beyond Finisher",
    "Star Platinum Finisher",
    "Star Platinum: The World Finisher",
    "Sticky Fingers Finisher",
    "Stone Free Finisher",
    "The World Alternate Universe Finisher",
    "The World Finisher",
    "The World Finisher2",
    "The World Over Heaven Finisher",
    "Tusk ACT 4 Finisher",
    "Tusk ACT 4 Finisher2",
    "Weather Report Finisher",
    "White Album Finisher",
    "Whitesnake Finisher",
    "OLD Stone Free Finisher",
    "Gold Experience Finisher",
    "Gold Experience Finisher2",
    "Gold Experience Requiem Finisher",
    "Hermit Purple Finisher",
    "Hierophant Green Finisher",
    "Killer Queen Finisher",
    "Killer Queen: Bites the Dust Finisher",
    "King Crimson Finisher",
    "King Crimson Requiem Finisher",
    "Made in Heaven Finisher",
    "D4C Love Train Finisher",
    "C-Moon Finisher",
    "Chariot Requiem Finisher",
    "Chili Pepper Alternate Universe Finisher",
    "Crazy Diamond Finisher",
    "Cream Finisher",
    "D4C Finisher",
    "Propeller Charge Voiceline",
    "Star Platinum Platinum Slam Voiceline",
    "Star Platinum: The World Platinum Slam Voiceline",
    "Ice Swipe",
    "Uppercut to The Moon",
    "KC Impale Voiceline",
    "Kidnap SFX",
    "Skull Crusher2",
    "Soft & Wet_Bubble Prison_Start",
    "Star Finger Voiceline",
    "KQ Impale Voiceline",
    "Vampirism_Vaporization Freezing Strike_Windup",
    "While Album_Ice Punch_Start",
    "While Album_Ice Swipe_Start",
    "Shinei Voiceline",
    "Crazy Diamond_Crazy Beatdown_Startup",
    "Sticky Fingers_Arrivederci Beatdown_Voiceline_1",
    "Scary Monsters_Dino Barrage_FF_StartVoice",
    "Shadow The World_Stand Combo_Windup",
    "Shadow The World_Punishment_WindupVoiceline",
    "Shadow The World_Punishment_WindupVoiceline",
    "Shadow The World_Heavy Chop_Voiceline",
    "Gold Experience Summon Tree Voiceline",
    "Erasure_Voiceline",
    "Erasure",
    "Erasure_Hit",
    "HeavyIndicator",
    "Life Shot Voiceline",
    "Surface Inversion Punch Voiceline",

}

local function isFinisherSound(soundName)
    for _, name in ipairs(FINISHER_SOUNDS) do
        if soundName == name then
            return true
        end
    end
    return false
end

local AutoParry = {}
AutoParry._connection = nil
AutoParry._connectionVFX = nil
AutoParry._lastBlockTime = 0
AutoParry._active = false
AutoParry._soundDebounce = {}

local function getSoundName(soundValue)
    if type(soundValue) == "string" then
        return soundValue
    end

    if typeof(soundValue) ~= "Instance" or not soundValue:IsA("Sound") then
        return nil
    end

    local name = soundValue.Name

    if name == "Start" or name == "Finisher" or name == "Sound" or name == "Swing" then
        local parent = soundValue.Parent
        if parent then
            local parentName = parent.Name
            if parentName ~= "Sounds" and parentName ~= "Stands" and parentName ~= "ReplicatedStorage" then
                return parentName .. "_" .. name
            end
            local grandparent = parent.Parent
            if grandparent and grandparent.Name ~= "Sounds" and grandparent.Name ~= "Stands" then
                return grandparent.Name .. "_" .. parentName .. "_" .. name
            end
        end
        return nil
    end

    return name
end

local function isOwnOrigin(origin)
    local char = LocalPlayer.Character
    if not char or typeof(origin) ~= "Instance" then return false end
    if origin == char or origin:IsDescendantOf(char) then return true end
    local stand = char:FindFirstChild("StandMorph")
    if stand and (origin == stand or origin:IsDescendantOf(stand)) then
        return true
    end
    return false
end

local function getRoot(model)
    if not model then return nil end
    return model:FindFirstChild("HumanoidRootPart")
        or model:FindFirstChild("UpperTorso")
        or model:FindFirstChild("Torso")
end

local function getPlayerFromOrigin(origin)
    if typeof(origin) ~= "Instance" then return nil end
    local current = origin
    while current do
        if current:IsA("Model") then
            local plr = Players:GetPlayerFromCharacter(current) or Players:FindFirstChild(current.Name)
            if plr then return plr end
        end
        current = current.Parent
    end
    return nil
end

local function performBlock()
    local char = LocalPlayer.Character
    if not char then return false end

    local remote = char:FindFirstChild("RemoteEvent")
    if not remote then return false end

    local seq = PARRY_CONFIG.blockSeq

    if seq.releaseAttack ~= false then
        remote:FireServer("HoldAttack", {
            Bool = false,
            Type = seq.attackType or "m1",
        })
    end

    if seq.releaseInput then
        local input = seq.releaseInput
        if type(input) == "string" then
            input = Enum.KeyCode[input]
        end
        remote:FireServer("InputEnded", {
            Input = input,
        })
    end

    remote:FireServer("StopBlocking", nil)

    local delay = seq.beforeBlockDelay or 0.45
    task.wait(delay)

    remote:FireServer("StartBlocking", nil)

    local hold = seq.holdDuration or 0.3
    task.wait(hold)

    remote:FireServer("StopBlocking", nil)

    return true
end

local function handleClientFX(markerType, data)
    if not PARRY_CONFIG.enabled then return end

    local cooldown = PARRY_CONFIG.cooldown
    if os.clock() - AutoParry._lastBlockTime < cooldown then return end

    local origin = nil
    local soundName = nil

    if markerType == "PlaySound" and type(data) == "table" then
        local soundValue = data.Sound
        soundName = getSoundName(soundValue)

        if soundName and isFinisherSound(soundName) then
            origin = data.Origin
            print("[AutoParry] Sound detected: " .. soundName)
        end
    elseif type(data) == "table" and data.Origin then
        for _, name in ipairs(PARRY_CONFIG.attacks) do
            if markerType == name then
                origin = data.Origin
                print("[AutoParry] Attack detected: " .. markerType)
                break
            end
        end
    end

    if not origin then return end
    if isOwnOrigin(origin) then return end

    local attacker = getPlayerFromOrigin(origin)
    if not attacker or attacker == LocalPlayer then return end

    local myChar = LocalPlayer.Character
    local attChar = attacker.Character
    if not myChar or not attChar then return end

    local myRoot = getRoot(myChar)
    local attRoot = getRoot(attChar)
    if not myRoot or not attRoot then return end

    local radius = PARRY_CONFIG.radius
    local distance = (myRoot.Position - attRoot.Position).Magnitude
    if distance > radius then return end

    if soundName then
        local debounceKey = soundName .. "_" .. attacker.Name
        if AutoParry._soundDebounce[debounceKey] then
            return
        end
        AutoParry._soundDebounce[debounceKey] = true
        task.delay(0.5, function()
            AutoParry._soundDebounce[debounceKey] = nil
        end)
    end

    local seq = PARRY_CONFIG.blockSeq
    local waitBeforeBlock
    if soundName == "Shinei Voiceline" then
        waitBeforeBlock = 0.1
    else
        waitBeforeBlock = seq.waitBfBlock
    end

    print(string.format("[AutoParry] Parrying in %.2fs (Distance: %.1f | Attacker: %s)", waitBeforeBlock, distance, attacker.Name))

    AutoParry._lastBlockTime = os.clock()

    task.spawn(function()
        task.wait(waitBeforeBlock)
        performBlock()
    end)
end

function AutoParry.Start()
    if AutoParry._active then return true end

    AutoParry._active = true

    if ClientFX then
        AutoParry._connection = ClientFX.OnClientEvent:Connect(handleClientFX)
    end

    if ClientVFX then
        AutoParry._connectionVFX = ClientVFX.OnClientEvent:Connect(handleClientFX)
    end

    print("[AutoParry] Started")
    return true
end

function AutoParry.Stop()
    AutoParry._active = false
    if AutoParry._connection then
        AutoParry._connection:Disconnect()
        AutoParry._connection = nil
    end
    if AutoParry._connectionVFX then
        AutoParry._connectionVFX:Disconnect()
        AutoParry._connectionVFX = nil
    end
    print("[AutoParry] Stopped")
end

function AutoParry.Destroy()
    AutoParry.Stop()
    if _G.AutoParry == AutoParry then
        _G.AutoParry = nil
    end
end

if _G.AutoParry and type(_G.AutoParry.Destroy) == "function" then
    _G.AutoParry.Destroy()
end

_G.AutoParry = AutoParry


Library:CreateToggle(autoParrySection, "Enable Auto Parry(F)", _G.Config.autoParryEnabled, function(state)
    _G.Config.autoParryEnabled = state
    SaveConfig()
    if state then
        _G.AutoParry.Start()
    else
        _G.AutoParry.Stop()
    end
end)
Library:CreateSlider(autoParrySection, "Parry Radius", _G.Config.autoParryRadius, 1, 50, function(val)
    _G.Config.autoParryRadius = math.floor(val)
    PARRY_CONFIG.radius = _G.Config.autoParryRadius
    SaveConfig()
end)
_G.barrageButton = Enum.KeyCode.E
Library:CreateToggle(autoParrySection, "Enable Instant Barrage(E)", _G.Config.instantBarrage, function(state)
    _G.Config.instantBarrage = state
    if state then
        local Players = game:GetService("Players")
        local RS = game:GetService("ReplicatedStorage")
        local VIM = game:GetService("VirtualInputManager")
        local LP = Players.LocalPlayer
        local event = RS:WaitForChild("ClientFX")
        local function getPlayerFromPart(part)
            if not part then return nil end
            local obj = part
            while obj and obj ~= workspace do
                local plr = Players:GetPlayerFromCharacter(obj)
                if plr then return plr end
                if obj.Parent == workspace:FindFirstChild("Living") then
                    local byName = Players:FindFirstChild(obj.Name)
                    if byName then return byName end
                end
                obj = obj.Parent
            end
            return nil
        end
        local function getNearbyPlayers(radius)
            local nearby = {}
            local myChar = LP.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if not myRoot then return nearby end

            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character then
                    local root = plr.Character:FindFirstChild("HumanoidRootPart")
                    if root and (root.Position - myRoot.Position).Magnitude <= radius then
                        nearby[plr] = true
                    end
                end
            end
            return nearby
        end
        local blocking = false
        if _G.imgay then
            _G.imgay:Disconnect()
        end
        _G.imgay = event.OnClientEvent:Connect(function(action, data)
            if type(action) ~= "string" then return end
            if not action:match("Stand Barrage") then return end
            if type(data) ~= "table" or not data.Origin then return end

            local originPlayer = getPlayerFromPart(data.Origin)
            if not originPlayer then
                return
            end

            if not getNearbyPlayers(20)[originPlayer] then return end
            if blocking then return end

            blocking = true
            VIM:SendKeyEvent(true, _G.barrageButton, false, game)
            task.wait(tonumber(_G.Config.instantBarrageHoldDuration))
            VIM:SendKeyEvent(false, _G.barrageButton, false, game)
            blocking = false
        end)
    else
         if _G.imgay then
            _G.imgay:Disconnect()
        end
    end
end)
Library:CreateToggle(autoParrySection, "Use R instead of E", _G.Config.instantBarrageR, function(state)
    _G.Config.instantBarrageR = state
    if state then
        _G.barrageButton = Enum.KeyCode.R
    else
        _G.barrageButton = Enum.KeyCode.E
    end
end)
Library:CreateSlider(autoParrySection, "Instant Barrage Hold Duration", _G.Config.instantBarrageHoldDuration, 1, 6, function(val)
    _G.Config.instantBarrageHoldDuration = math.floor(val)
    SaveConfig()
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
function events()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    local Event1 = game:GetService("ReplicatedStorage").ClientFX
    local Event2 = LocalPlayer.Character.RemoteEvent

    firesignal(Event1.OnClientEvent, 
        "Boxing Shuffle",
        {
            Windup_Speed = 1,
            ExtraDashPower = _G.Config.shuffleDist,
            Windup_Duration = 0.3,
            Origin = HumanoidRootPart
        }
    )
    firesignal(Event2.OnClientEvent, 
        "AddCD",
        {
            Name = "CRACKED SHUFFLE",
            Cooldown = _G.Config.shuffleCd
        }
    )
end
function pidoras_ebaniy()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	for _, pidor in pairs(Character:GetChildren()) do
		if pidor.Name:match("Boxing") or pidor.Name:match("Gloves") then
			return true
		end
	end
	return false
end
_G.crackeSandwichCD = true
game:GetService("UserInputService").InputBegan:Connect(function(inp, gp)
    if gp then return end
    if not _G.Config.enableBoxModify then return end
    if not pidoras_ebaniy() then return end
	if inp.KeyCode == Enum.KeyCode.C and _G.crackeSandwichCD then
		_G.crackeSandwichCD = false
        events()
        task.wait(_G.Config.shuffleCd)
        _G.crackeSandwichCD = true
	end
end)
hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if (method == "FireServer" or method == "InvokeServer") then
        if self:IsA("RemoteEvent") or self:IsA("RemoteFunction") then
            local cmd = args[1]
            local data = args[2]

            if cmd == "InputBegan" and type(data) == "table" and data.Input == Enum.KeyCode.C and _G.Config.enableBoxModify and pidoras_ebaniy() then
                return  
            end
        end
    end
    return self[method](self, ...)
end)

local miscSection = Library:CreateFunctionTab(tab_functions, "Misc")
Library:CreateToggle(miscSection, "Enable Aimbot", _G.Config.enableAimbot, function(v)
    _G.Config.enableAimbot = v
    if not v then
        _G.Config.SilentAimbotEnabled = false
    elseif v and _G.Config.aimbotMode == "Silent" then
        _G.Config.SilentAimbotEnabled = true
    end
    SaveConfig()
end)
Library:CreateDropdown(miscSection, "Aimbot Mode", { "Target Lock", "Silent" }, _G.Config.aimbotMode, false, function(v)
    _G.Config.aimbotMode = v
    if _G.Config.enableAimbot and v == "Silent" then
        _G.Config.SilentAimbotEnabled = true
    else 
        _G.Config.SilentAimbotEnabled = false
    end
    SaveConfig()
end)
Library:CreateSlider(miscSection, "Prediction", _G.Config.prediction, 0.01, 1.00, function(v)
    _G.Config.prediction = v
    _G.Config.SilentAimbotPrediction = v
    SaveConfig()
end)
Library:CreateToggle(miscSection, "Silent Aim: Show Bullet Tracer", _G.Config.SilentAimbotShowTracer, function(v)
    _G.Config.SilentAimbotShowTracer = v
    SaveConfig()
end)
Library:CreateSlider(miscSection, "Silent Aim: Bullet Delay", _G.Config.SilentAimbotBulletDelay, 0, 10, function(v)
    _G.Config.SilentAimbotBulletDelay = v
    SaveConfig()
end)
Library:CreateSlider(miscSection, "Silent Aim: FOV", _G.Config.SilentAimbotFOV, 0, 999, function(v)
    _G.Config.SilentAimbotFOV = v
    SaveConfig()
end)
Library:CreateToggle(miscSection, "Enable Stand Pilot", _G.Config.standPilotEnabled, function(v)
    _G.Config.standPilotEnabled = v
    if not v then stopStandPilot() end
    SaveConfig()
end)
Library:CreateDropdown(miscSection, "Pilot Mode", { "Free", "Target Lock", "Stand Only" }, _G.Config.pilotMode, false, function(v)
    _G.Config.pilotMode = v
    SaveConfig()
end)
Library:CreateSlider(miscSection, "Stand Pilot Speed", _G.Config.standPilotSpeed, 1, 500, function(v)
    _G.Config.standPilotSpeed = v
    SaveConfig()
end)
Library:CreateSlider(miscSection, "Stand Pilot Distance", _G.Config.standPilotYPos, 1, 20, function(v)
    _G.Config.standPilotYPos = v
    SaveConfig()
end)
Library:CreateSlider(miscSection, "Stand Pilot Player Distance", _G.Config.standPilotUnderground, 1, 50, function(v)
    _G.Config.standPilotUnderground = v
    SaveConfig()
end)
Library:CreateSlider(miscSection, "Target Lock: Prediction", _G.Config.targetLockPredict, 0, 20, function(v)
    _G.Config.targetLockPredict = v
    SaveConfig()
end)
Library:CreateSlider(miscSection, "Stand Only: Timeout", _G.Config.standOnlyTimeout, 0, 5, function(v)
    _G.Config.standOnlyTimeout = v
    SaveConfig()
end)
Library:CreateSlider(miscSection, "Stand Only: Lock Time", _G.Config.standPilotWait, 0, 30, function(v)
    _G.Config.standPilotWait = v
    SaveConfig()
end)


local autoFarmSection = Library:CreateFunctionTab(tab_functions, "Auto Farm")
Library:CreateToggle(autoFarmSection, "Enable Auto Farm", _G.Config.autofarm_farm, function(state)
    _G.Config.autofarm_farm = state
    _G.autoFarm = state
    SaveConfig()
end)
Library:CreateToggle(autoFarmSection, "Enable Auto Sell", _G.Config.autofarm_sell, function(state)
    _G.Config.autofarm_sell = state
    toggleAutoSell(state)
    SaveConfig()
end)

-- MISC TAB
local camera = workspace.CurrentCamera
local tab_misc = Library:CreateClass("Misc")
local visualsSection = Library:CreateFunctionTab(tab_misc, "Visuals")
local removalsSection = Library:CreateFunctionTab(tab_misc, "Removals")
local oldSection = Library:CreateFunctionTab(tab_misc, "Old YBA")
function applyFov()
    local camera = workspace.CurrentCamera
    if camera then
        camera.FieldOfView = _G.Config.fovValue
    end
end

Library:CreateToggle(visualsSection, "Enable FOV Changer", _G.Config.enableFovChanger, function(val)
    _G.Config.enableFovChanger = val
    SaveConfig()
    local camera = workspace.CurrentCamera
    if not val then
        if _G.fov_value_conn then
            _G.fov_value_conn:Disconnect()
            _G.fov_value_conn = nil
        end
    else
        camera = workspace.CurrentCamera
        if camera then
            _G.fov_value_conn = camera:GetPropertyChangedSignal("FieldOfView"):Connect(applyFov)
        end
        applyFov()
    end
end)
Library:CreateSlider(visualsSection, "FOV Value", _G.Config.fovValue, 60, 120, function(v)
    _G.Config.fovValue = v
    applyFov()
    SaveConfig()
end)

local Lighting = game:GetService("Lighting")
local weathers = {"...", "Sunny", "Rainy", "Snowy", "Foggy", "Blizzard", "Sandstorm", "HALLOWEEN", "ReturntoZero", "BitestheDust", "D4CDimension", "ErasedTime", "RagingDemon", "TheBox", "UnlimitedBladeWorks", "Weatherless"}

local halloween = nil
local winter = nil
Library:CreateSlider(visualsSection, "Clock Time", _G.Config.clocktime, 1, 24, function(val)
    _G.Config.clocktime = val
    SaveConfig()
end)
Library:CreateToggle(visualsSection, "Change Map With Lighting", _G.Config.changeMap, function(val)
    _G.Config.changeMap = val
end)
Library:CreateDropdown(visualsSection, "Change Lighting", weathers, _G.Config.leghtink, false, function(val)
    _G.Config.leghtink = val
    if _G.Config.changeMap then
        if val == "HALLOWEEN" then
            if halloween then
                halloween.restore()
                wait(0.1)
            end
            if winter then
                winter.restore()
                wait(0.1)
            end
            halloween = makeHalloweenMap()
        elseif val == "Snowy" then
            if halloween then
                halloween.restore()
                wait(0.1)
            end
            if winter then
                winter.restore()
                wait(0.1)
            end
            winter = makeWinterMap()
        end
    else
        if halloween then
            halloween.restore()
            wait(0.1)
        end
        if winter then
            winter.restore()
            wait(0.1)
        end
    end
    SaveConfig()
end)
Library:CreateToggle(visualsSection, "Remove Stand's Barrage", _G.Config.removeBarrage, function(val)
    _G.Config.removeBarrage = val
    if _G.z then
        _G.z:Disconnect()
    end
    if val then
        _G.z = game:GetService("RunService").RenderStepped:Connect(function()
            for _, child in ipairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                if child.ClassName == "Model" and child.Name == "Model" then
                    child:Destroy()
                end
            end
        end)
    end
    SaveConfig()
end)
Library:CreateToggle(removalsSection, "Mobile UI", _G.Config.mobileUi, function(val)
    _G.Config.mobileUi = val
    if _G.mbbbz then _G.mbbbz:Disconnect() end
    if val then
    _G.mbbbz = game:GetService("RunService").RenderStepped:Connect(function()
        game:GetService("Players").LocalPlayer.PlayerGui.HUD.Main.MobileSupport.Visible = true
    end)
    else
        game:GetService("Players").LocalPlayer.PlayerGui.HUD.Main.MobileSupport.Visible = false
    end
    SaveConfig()
end)
Library:CreateToggle(removalsSection, "Hide UI", _G.Config.hideUi, function(val)
    _G.Config.hideUi = val
    if _G.mbbbz1 then _G.mbbbz1:Disconnect() end
    if val then
    _G.mbbbz1 = game:GetService("RunService").RenderStepped:Connect(function()
        game:GetService("Players").LocalPlayer.PlayerGui.HUD.Main.Visible = false
    end)
    else
        game:GetService("Players").LocalPlayer.PlayerGui.HUD.Main.Visible = true
    end
    SaveConfig()
end)
Library:CreateToggle(removalsSection, "Hide Playerlist", _G.Config.hidePlayerlist, function(val)
    _G.Config.hidePlayerlist = val
    if _G.mbbbz2 then _G.mbbbz2:Disconnect() end
    if val then
    _G.mbbbz2 = game:GetService("RunService").RenderStepped:Connect(function()
        game:GetService("Players").LocalPlayer.PlayerGui.HUD.Playerlist.Visible = false
    end)
    else
        game:GetService("Players").LocalPlayer.PlayerGui.HUD.Playerlist.Visible = true
    end
    SaveConfig()
end)
Library:CreateToggle(removalsSection, "Hide Attack's Blur", _G.Config.hideBlur, function(val)
    _G.Config.hideBlur = val
    if _G.mbbbz3 then _G.mbbbz3:Disconnect() end
    if val then
    _G.mbbbz3 = game:GetService("RunService").RenderStepped:Connect(function()
    pcall(function() game:GetService("Players").LocalPlayer.PlayerGui.HurtGui:Destroy() end)
    pcall(function() game:GetService("Lighting").EyeGougeHit:Destroy() end)
    pcall(function() game:GetService("Lighting").Bloom:Destroy() end)
    end)
    end
    SaveConfig()
end)
Library:CreateToggle(oldSection, "Old Water Texture", _G.Config.OldWaterTexture, function(val)
    _G.Config.OldWaterTexture = val
    local succ, err = pcall(function()
        local ocean = getOcean()
        if not ocean then return end
        local hasTexture = ocean:FindFirstChild("WaterTextMaterial") ~= nil
        if val then
            ocean.BrickColor = BrickColor.new("Bright blue")
            if hasTexture then ocean:FindFirstChild("WaterTextMaterial"):Destroy() end
        else
            ocean.BrickColor = BrickColor.new("Royal blue")
            if not hasTexture then createWaterTexture() end
        end
    end)
    if not succ then warn("[OLD WATER TEXTURE] " .. err) end
    SaveConfig()
end)
Library:CreateToggle(oldSection, "Old Map Textures", _G.Config.OldMapTextures, function(val)
    _G.Config.OldMapTextures = val
    local succ, err = pcall(function()
        updateMapTextures(val)
    end)
    if not succ then warn("[OLD MAP TEXTURES] " .. err) end
    SaveConfig()
end)
Library:CreateToggle(oldSection, "Old Cooldowns", _G.Config.oldCooldowns, function(state)
    _G.oldstate = _G.Config.oldCooldowns
    _G.Config.oldCooldowns = state
    if state then
        -- old cd
        _G.colorRn = Color3.fromRGB(255,255,255)
        if _G.haha then _G.haha:Disconnect() end
        if _G.coolConn then _G.coolConn:Disconnect() end
        _G.haha = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
            wait(1)
            local function sameColor(a, b)
                if not a or not b then return false end
                return a.R == b.R and a.G == b.G and a.B == b.B
            end
            local defColors = {
                Color3.fromRGB(255, 170, 255),
                Color3.fromRGB(85, 255, 255),
                Color3.fromRGB(0, 185, 127),
                Color3.fromRGB(255, 170, 0),
                Color3.fromRGB(0, 102, 152),
                Color3.fromRGB(170, 255, 0),
            }
            local cooldowns = game:GetService("Players").LocalPlayer.PlayerGui.HUD.Cooldowns
            if cooldowns then
            local template = cooldowns.Template
            if template then
                local indframe = template.IndicatorFrame
                local ind = indframe.Indicator
                local indUIgrad = ind.UIGradient
                local indshadow = template.IndicatorShadow
                local cdtext = template.CooldownText
                local skillname = template.SkillName

                template.Size = UDim2.new(0.06, 0, 0.09, 0)
                template.Position= UDim2.new(0.925,0,0.75,0) 
                skillname.Size = UDim2.new(0.7, 0, 0.8, 0)
                skillname.Position = UDim2.new(0.5,0,0.1,0)
                skillname.TextXAlignment = "Center"
                skillname.TextYAlignment = "Center"
                skillname.Font = Enum.Font.Oswald
                skillname.ZIndex = 5
                skillname.TextColor3 = _G.colorRn

                ind.Image = ""
                ind.BackgroundColor3 = Color3.new(1,1,1)
                ind.BackgroundTransparency = 0.6
                ind.Position = UDim2.new(0,0,-3.2,0)
                ind.Size = UDim2.new(1,0,5.2,0)
                indUIgrad.Enabled = false
                indshadow.Visible = false

                cdtext.Visible = false

                end 
            end

            _G.coolConn = cooldowns.Frame.ChildAdded:Connect(function(child)
                if not child:IsA("GuiObject") then return end
                local newColor
                repeat
                    newColor = defColors[math.random(1, #defColors)]
                until not sameColor(newColor, _G.colorRn)
                _G.colorRn = newColor
                local skillname = cooldowns.Template.SkillName
                if skillname then
                    skillname.TextColor3 = _G.colorRn
                end

                _G.colorRn = Color3.fromRGB(255,255,255)
            end)
        end)
    else
        if _G.coolConn then _G.coolConn:Disconnect() end
        if _G.haha then _G.haha:Disconnect() end
    end
    SaveConfig()
end)
Library:CreateToggle(oldSection, "Old Sounds", _G.Config.oldSounds, function(val)
    if not val and _G.Config.oldSounds then
        warn("rejoin may required")
    end
    _G.Config.oldSounds = val
    SaveConfig()
    if val then
        local a,b=pcall(function()
        local rs = game:GetService("ReplicatedStorage")
        local obj = rs:FindFirstChild("Objects")
        local rtz = obj and obj:FindFirstChild("Return to Zero")
        local rtzSound = rtz and rtz:FindFirstChild("Sound")
        if rtzSound then
            rtzSound.SoundId = "rbxassetid://6029007816"
            rtzSound.Volume = 2
        end
        for _, itm in pairs(rs.Sounds:GetChildren()) do
            if itm.Name:match("SwordSwing") then
                itm.SoundId = "rbxassetid://4096810926"
                itm.PlaybackSpeed = 0.9
                itm.Volume = 1
            end
        end
        local jawbreaker = rs:FindFirstChild("Sounds"):FindFirstChild("Boxing"):FindFirstChild("Jawbreaker")
        if jawbreaker then
            local finish = jawbreaker:FindFirstChild("Finish")
            local start = jawbreaker:FindFirstChild("Start") 
            if finish and start then
                finish.Volume = 0
                start.Volume = 1
                start.SoundId = "rbxassetid://231731980"
                start.PlaybackSpeed = 0.52
            end 
        end
        local livershot = rs:FindFirstChild("Sounds"):FindFirstChild("Boxing"):FindFirstChild("Liver Shot")
        if livershot then
            livershot.Volume = 0
        end
            local crazy = rs:FindFirstChild("Sounds") and rs.Sounds:FindFirstChild("Crazy Diamond")
        if crazy and crazy:FindFirstChild("HitSounds") then
            local hit = crazy.HitSounds:FindFirstChild("StandHit2")
            if hit then
                hit.SoundId = "rbxassetid://4134502335"
            end
        end

        local finger = rs:FindFirstChild("Sounds") and rs.Sounds:FindFirstChild("Star Finger Voiceline")
        if finger then
            finger.Volume = 0
        end

        local stands = rs:FindFirstChild("Stands")
        local sp = stands and stands:FindFirstChild("Star Platinum")
        if sp and sp:FindFirstChild("SummonSounds") then
            local s = sp.SummonSounds:FindFirstChild("Sound")
            if s then
                s.SoundId = "rbxassetid://6938423915"
            end
        end

        local twau = stands and stands:FindFirstChild("The World Alternate Universe")
        if twau and twau:FindFirstChild("SummonSounds") then
            local s = twau.SummonSounds:FindFirstChild("Sound")
            if s then
                s.SoundId = "rbxassetid://6938424506"
            end
        end

        local tw = stands and stands:FindFirstChild("The World")
        if tw and tw:FindFirstChild("SummonSounds") then
            local s = tw.SummonSounds:FindFirstChild("Sound")
            if s then
                s.SoundId = "rbxassetid://6938424364"
            end
        end

        local sounds = rs:FindFirstChild("Sounds")
        if sounds then
            for _, damn in pairs(sounds:GetChildren()) do
                if damn.Name:match("Blade_Hit") then
                    damn.SoundId = "rbxassetid://4134502335"
                end
            end
        end
        end)
        if not a then warn("[OLD SOUNDS] " .. tostring(b)) end
    end
end)

Library:CreateToggle(oldSection, "Old SP Stand", _G.Config.oldAnimationsSp, function(val)
    if not val and _G.Config.oldAnimationsSp then
        warn("rejoin may required")
    end

    _G.Config.oldAnimationsSp = val
    SaveConfig()
    if val then
        local a,b=pcall(function()
        toggleOldSpSummon(val)
        end)
        if not a then warn("[OLD SP STAND] " .. tostring(b)) end
    else
        toggleOldSpSummon(false)
    end
end)

Library:CreateToggle(oldSection, "Old Boxing", _G.Config.oldAnimationsBox, function(val)
    if not val and _G.Config.oldAnimationsBox then
        warn("rejoin may required")
    end

    _G.Config.oldAnimationsBox = val
    SaveConfig()


    if not val then
        if stopOldBox then stopOldBox() end
        return
    end 

    local a, b = pcall(function()

    local rs = game:GetService("ReplicatedStorage")

    local jawbreaker2 = rs:FindFirstChild("Anims"):FindFirstChild("Boxing"):FindFirstChild("Jawbreaker")
    if jawbreaker2 then
        jawbreaker2.AnimationId = "rbxassetid://4211804997"
    end

    local livershot = rs:FindFirstChild("Anims"):FindFirstChild("Boxing"):FindFirstChild("Liver Shot")
    if livershot then
        livershot.AnimationId = "rbxassetid://4095625816"
    end

    for _, item in pairs(rs:FindFirstChild("Objects"):FindFirstChild("Boxing"):FindFirstChild("Jawbreaker"):GetChildren()) do
        item:Destroy()
    end
    for _, item in pairs(rs:FindFirstChild("Objects"):FindFirstChild("Boxing"):FindFirstChild("Liver Shot"):GetChildren()) do
        item:Destroy()
    end

    oldBox()
    end)
    if not a then warn("[OLD BOXING] " .. tostring(b)) end
end)
Library:CreateToggle(visualsSection, "Enable Custom Death Sound", _G.Config.enableCustomDeathSound, function(state)
    local rs = game:GetService("ReplicatedStorage")

    local death = rs:FindFirstChild("Sounds") and rs.Sounds:FindFirstChild("Knocked_Unconscious")
    if not death then return end

    if not _G.death then
        _G.death = death.SoundId
    end

    _G.Config.enableCustomDeathSound = state
    SaveConfig()
end)
local dsl = {"Re:Zero - Return By Death"}
Library:CreateDropdown(visualsSection, "Death Sound List", dsl, _G.Config.customDeathSound, false, function(v)
    if not _G.Config.enableCustomDeathSound then return end

    local rs = game:GetService("ReplicatedStorage")
    local death = rs:FindFirstChild("Sounds") and rs.Sounds:FindFirstChild("Knocked_Unconscious")
    if not death then return end
    if not _G.death then
        _G.death = death.SoundId
    end

    _G.Config.customDeathSound = v

    if v == dsl[1] then
        death.SoundId = "rbxassetid://6268259128"
        death.TimePosition = 1.33
        death.Volume = 5
    else
        death.SoundId = _G.death
        death.TimePosition = 0.5
        death.Volume = 1
    end
    SaveConfig()
end)
Library:CreateToggle(visualsSection, "'The Tallest Peak' Exploit", _G.Config.ttpExploit, function(state)
    _G.Config.ttpExploit = state
    if state then
        pcall(function()
            if _G.ttpConn then
                _G.ttpConn:Disconnect()
            end

            local ez = workspace.Living:FindFirstChild(game:GetService("Players").LocalPlayer.Name):FindFirstChild("Location")
            _G.ttpConn = ez:GetPropertyChangedSignal("Value"):Connect(function()
                ez.Value = workspace.Locations["The Tallest Peak"]
            end)
            ez.Value = workspace.Locations["The Tallest Peak"]
        end)
    else
        if _G.ttpConn then
            _G.ttpConn:Disconnect()
        end
    end
    SaveConfig()
end)
Library:CreateToggle(visualsSection, "Enable Stand Aura Changer", _G.Config.standAuraEnabled, function(state)
    _G.Config.standAuraEnabled = state
    SaveConfig()
end)
Library:CreateToggle(visualsSection, "RGB Mode", _G.Config.standAuraRgb, function(state)
    _G.Config.standAuraRgb = state
    SaveConfig()
end)
Library:CreateSlider(visualsSection, "Aura, R", _G.Config.standAuraR, 0, 255, function(val)
    _G.Config.standAuraR = math.floor(val)
    SaveConfig()
end)
Library:CreateSlider(visualsSection, "Aura, G", _G.Config.standAuraG, 0, 255, function(val)
    _G.Config.standAuraG = math.floor(val)
    SaveConfig()
end)
Library:CreateSlider(visualsSection, "Aura, B", _G.Config.standAuraB, 0, 255, function(val)
    _G.Config.standAuraB = math.floor(val)
    SaveConfig()
end)


local Event = game:GetService("ReplicatedStorage").ClientFX
local LocalPlayer = game:GetService("Players").LocalPlayer
repeat task.wait() until LocalPlayer.Character
local bypass = false
Event.OnClientEvent:Connect(function(signal, data)
    if bypass then return end
    if type(signal) == "string" and signal:find("Finisher") and data then
        if data.User == LocalPlayer.Character then
            bypass = true
            firesignal(Event.OnClientEvent, 
                "Finisher: " .. _G.Config.Finisher,
                {
                    Duration = data.Duration,
                    Origin = data.Origin,
                    User = data.User
                }
            )
            
            bypass = false
        end
    end
end)

local skinChangerSection = Library:CreateFunctionTab(tab_misc, "Skin Changer")
local finishersList = {"Tom", "Huh", "Huh #2", "GET OUT", "Bruh Moment", "God's Lightning", "Pillarman", "Sub-Zero", "Wither", "Lineage Wipe", "Minecraft", "Killer Queen Detonate", "Shiza", "Gate of Babylon", "Aincrad", "Announcer", "Hyperlaser", "Vampire Ripple", "Disintegrate"}
Library:CreateDropdown(skinChangerSection, "Finishers", finishersList, _G.Config.Finisher, false, function(val)
    _G.Config.Finisher = val
    SaveConfig()
end)
local itemSkinsList = {"...", "Bone Gloves", "Festive Gloves", "Boxing Claws"}
Library:CreateDropdown(skinChangerSection, "Gloves Skin", itemSkinsList, _G.Config.itemSkinGloves, false, function(val)
    _G.Config.itemSkinGloves = val
    if val ~= "..." then
        local succ, err = pcall(function()
            skinChanger(_G.Config.itemSkinGloves)
        end)
        if not succ then warn("[SKIN CHANGER.ITEM] " .. err) end
    end
    SaveConfig()
end)


if _G.miscVisualConn then
    _G.miscVisualConn:Disconnect()
end
_G.miscVisualConn = RunService.RenderStepped:Connect(function()
    Lighting.ClockTime = _G.Config.clocktime
    if _G.Config.leghtink and _G.Config.leghtink ~= "..." then
        pcall(function()
            local workWeather = workspace:FindFirstChild("Weather")
            if workWeather then
                workWeather.Value = _G.Config.leghtink
            end
        end)
    end
    applyStandAura()
end)

-- PLAYERS INFO TAB
local tab_playersInfo = Library:CreateClass("Players Info")
local infoSection = Library:CreateFunctionTab(tab_playersInfo, "Information")

-- main info
local playerlist_player = nil
local playersOnServer = {} -- all players
local playerPrestigeList = {}
local playerLvlList = {}
local playerGangList = {}
local playerStandsList = {} -- all his stands(equipped, 1, 2, 3 etc)
local playerSpecsList = {} -- all his specs(equipped, 1, 2 etc)
local playerBackpackList = {}
local playerMoneyList = {}

-- show information
local playerMoney = Library:CreateDropdown(infoSection, "Money", playerMoneyList, playerMoneyList[1], false, function(val)
end, true)
local playerPrestige = Library:CreateDropdown(infoSection, "Prestige", playerPrestigeList, playerPrestigeList[1], false, function(val)
end, true)
local playerLvl = Library:CreateDropdown(infoSection, "Level", playerLvlList, playerLvlList[1], false, function(val)
end, true)
local playerGang = Library:CreateDropdown(infoSection, "Gang", playerGangList, playerGangList[1], false, function(val)
end, true)
local playerStands = Library:CreateDropdown(infoSection, "Stands", playerStandsList, playerStandsList[1], false, function(val)
end, true)
local playerSpecs = Library:CreateDropdown(infoSection, "Fighting Styles", playerSpecsList, playerSpecsList[1], false, function(val)
end, true)
local playerBackpack = Library:CreateDropdown(infoSection, "Backpack", playerBackpackList, playerBackpackList[1], false, function(val)
end, true)

local playersSection = Library:CreateFunctionTab(tab_playersInfo, "Players")
local playerList = Library:CreateDropdown(playersSection, "Player", playersOnServer, playersOnServer[1], false, function(val)
    if not val or val == "None" then
        return
    end
    if val:match("(selected)") then
        val = val:gsub("%s*%(selected%)%s*", ""):match("^%s*(.-)%s*$")
    end
    playerlist_player = val
end)
Library:CreateToggle(playersSection, "Selected Only", _G.Config.playersInfo_selectedOnly, function(v)
    _G.Config.playersInfo_selectedOnly = v
    SaveConfig()
end)

task.spawn(function()
    local function getPlayerStatText(playerStats, statName)
        local stat = playerStats:FindFirstChild(statName)
        return stat and tostring(stat.Value) or "None"
    end

    while true do
        local succ, err = pcall(function()
            local player = playerlist_player and game:GetService("Players"):FindFirstChild(playerlist_player) or nil
            if player then
                local playerStats = player:FindFirstChild("PlayerStats")
                if playerStats then
                    playerPrestigeList = {getPlayerStatText(playerStats, "Prestige")}
                    playerLvlList = {getPlayerStatText(playerStats, "Level")}
                    playerGangList = {getPlayerStatText(playerStats, "Gang")}
                    playerMoneyList = {getPlayerStatText(playerStats, "Money")}
                    -- stands
                    playerStandsList = {getPlayerStatText(playerStats, "Stand") .. " (equipped)"}
                    for _, item in ipairs(playerStats:GetChildren()) do
                        if item.Name:match("Slot") and not item.Name:match("StyleSlot") then
                            table.insert(playerStandsList, item.Value)
                        end
                    end
                    -- specs
                    playerSpecsList = {getPlayerStatText(playerStats, "Spec") .. " (equipped)"}
                    for _, item in ipairs(playerStats:GetChildren()) do
                        if item.Name:match("StyleSlot") then
                            table.insert(playerSpecsList, item.Value)
                        end
                    end
                end
            end

            local plr = playerlist_player and game:GetService("Players"):FindFirstChild(playerlist_player) or nil
            if plr then
                local backpack = plr:FindFirstChild("Backpack")
                if backpack then
                    local counts = {}
                    playerBackpackList = {}
                    for _, item in ipairs(backpack:GetChildren()) do
                        local name = item.Name
                        counts[name] = (counts[name] or 0) + 1
                    end
                    for name, count in pairs(counts) do
                        table.insert(playerBackpackList, name .. " x" .. count)
                    end
                end
            end

            updateDropdownItems(playerMoney, playerMoneyList)
            updateDropdownItems(playerPrestige, playerPrestigeList)
            updateDropdownItems(playerLvl, playerLvlList)
            updateDropdownItems(playerGang, playerGangList)
            updateDropdownItems(playerStands, playerStandsList)
            updateDropdownItems(playerSpecs, playerSpecsList)
            updateDropdownItems(playerBackpack, playerBackpackList)

            playersOnServer = {}
            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                if player.Name == _G.Config.input_TargetSurvName then    
                    if #playersOnServer >= 1 then
                        table.insert(playersOnServer, 2, player.Name .. " (selected)")
                    else
                        table.insert(playersOnServer, player.Name .. " (selected)")
                    end
                    if _G.Config.playersInfo_selectedOnly then
                        playerlist_player = player.Name
                    end
                else
                    table.insert(playersOnServer, player.Name)
                end
            end
            if (not playerlist_player or not game:GetService("Players"):FindFirstChild(playerlist_player)) and #playersOnServer > 0 then
                playerlist_player = playersOnServer[1]:gsub("%s*%(selected%)%s*", ""):match("^%s*(.-)%s*$")
            end
            updateDropdownItems(playerList, playersOnServer)
        end)
        if not succ then warn("[player list] " .. err) end
        task.wait(1)
    end
end)

-- KEYBINDS
local keybindLabels = {
    OpenMenu = "Open Menu Bind",
    selectTarget = "Select Target Bind",
    dash = "Dash Bind",
    speedhack = "Speedhack Bind",
    fly = "Fly Bind",
    aimbot = "Aimbot Bind",
    standPilot = "Stand Pilot Bind",
    tpToTrgt = "TP To Target Bind",
    tpToDioOverHeaven = "TP To Dio OH Bind"
}

local keybindOrder = {
    "OpenMenu",
    "selectTarget",
    "dash",
    "speedhack",
    "fly",
    "aimbot",
    "standPilot",
    "tpToTrgt",
    "tpToDioOverHeaven"
}

local function containsKeybindAction(actionName)
    for _, action in ipairs(keybindOrder) do
        if action == actionName then
            return true
        end
    end
    return false
end

local tab_keybinds = Library:CreateClass("Keybinds")
local keybindSection = Library:CreateFunctionTab(tab_keybinds, "Keybinds")
for _, action in ipairs(keybindOrder) do
    if _G.Keybinds[action] ~= nil then
        Library:CreateKeybind(keybindSection, action, keybindLabels[action] or action)
    end
end
for action in pairs(_G.Keybinds) do
    if not containsKeybindAction(action) then
        Library:CreateKeybind(keybindSection, action, keybindLabels[action] or action)
    end
end

-- stand skin changer(shit btw)
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local bodyParts = {
    "Head", "LeftFoot", "LeftHand", "LeftLowerArm", "LeftLowerLeg",
    "LeftUpperArm", "LeftUpperLeg", "LowerTorso",
    "RightFoot", "RightHand", "RightLowerArm", "RightLowerLeg",
    "RightUpperArm", "RightUpperLeg", "UpperTorso",
    "Horse"
}

local allSaveParts = {
    "Head", "LeftFoot", "LeftHand", "LeftLowerArm", "LeftLowerLeg",
    "LeftUpperArm", "LeftUpperLeg", "LowerTorso",
    "RightFoot", "RightHand", "RightLowerArm", "RightLowerLeg",
    "RightUpperArm", "RightUpperLeg", "UpperTorso",
    "HumanoidRootPart",
    "Horse"
}

local visualClasses = {
    MeshPart = true, Decal = true, SurfaceAppearance = true,
    Beam = true, ParticleEmitter = true, Bone = true,
    Model = true, Attachment = true, Trail = true,
    PointLight = true, Texture = true, Highlight = true,
    Weld = true, WeldConstraint = true
}

local attachmentCache = {}
local function generateKey()
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local key = {}
    for i = 1, 32 do
        local pos = math.random(1, #chars)
        key[i] = chars:sub(pos, pos)
    end
    return table.concat(key)
end

local function xorCipher(data, key)
    local result = {}
    for i = 1, #data do
        local dataByte = string.byte(data, i)
        local keyByte = string.byte(key, ((i - 1) % #key) + 1)
        result[i] = string.char(bit32.bxor(dataByte, keyByte))
    end
    return table.concat(result)
end

local function encodeData(json)
    local key = generateKey()
    local encrypted = xorCipher(json, key)
    return key .. encrypted
end

local function decodeData(raw)
    local key = raw:sub(1, 32)
    local encrypted = raw:sub(33)
    local json = xorCipher(encrypted, key)
    return json
end

local function getStandMorph1()
    local char = workspace:FindFirstChild("Living")
    if not char then return nil end
    for _, player in pairs(char:GetChildren()) do
        if player.Name:lower():find(_G.ADMINDEBUG_name:lower(), 1, true) then
            return player:FindFirstChild("StandMorph")
        end
    end
    return nil
end
local function getStandMorph2()
    local char = workspace:FindFirstChild("Living")
    if not char then return nil end
    local player = char:FindFirstChild(LocalPlayer.Name)
    return player and player:FindFirstChild("StandMorph")
end

local function saveProp(value)
    local t = typeof(value)

    if t == "Vector3" then
        return {__t = "Vector3", v = {value.X, value.Y, value.Z}}
    elseif t == "Vector2" then
        return {__t = "Vector2", v = {value.X, value.Y}}
    elseif t == "Color3" then
        return {__t = "Color3", v = {value.R, value.G, value.B}}
    elseif t == "CFrame" then
        return {__t = "CFrame", v = {value:GetComponents()}}
    elseif t == "NumberRange" then
        return {__t = "NumberRange", v = {value.Min, value.Max}}
    elseif t == "NumberSequence" then
        local points = {}
        for _, p in ipairs(value.Keypoints) do
            table.insert(points, {
                Time = p.Time,
                Value = p.Value,
                Envelope = p.Envelope
            })
        end
        return {__t = "NumberSequence", v = points}
    elseif t == "ColorSequence" then
        local points = {}
        for _, p in ipairs(value.Keypoints) do
            table.insert(points, {
                Time = p.Time,
                Color = {p.Value.R, p.Value.G, p.Value.B}
            })
        end
        return {__t = "ColorSequence", v = points}
    elseif t == "BrickColor" then
        return {__t = "BrickColor", v = value.Number}
    elseif t == "EnumItem" then
        return {__t = "Enum", v = tostring(value)}
    elseif t == "string" or t == "number" or t == "boolean" then
        return value
    end
    return nil
end

local function hasParticleEmitterInside(attachment)
    for _, child in ipairs(attachment:GetDescendants()) do
        if child:IsA("ParticleEmitter") then
            return true
        end
    end
    return false
end

local function ensureAttachmentID(attachment)
    local id = attachment:GetAttribute("SaveID")
    if not id then
        id = HttpService:GenerateGUID(false)
        attachment:SetAttribute("SaveID", id)
    end
    return id
end

local function saveInstance(inst, parentPart)
    local data = {ClassName = inst.ClassName, Name = inst.Name, Properties = {}, Children = {}}

    if inst:IsA("MeshPart") then
        local props = {
            "MeshId", "TextureID", "Material", "BrickColor", "Color", "Transparency", "Reflectance",
            "CastShadow", "Visible", "Locked", "Anchored", "CanCollide", "Massless",
            "PivotOffset", "CollisionFidelity", "RenderFidelity", "DoubleSided"
        }
        pcall(function()
            if parentPart then
                local relativeCF = parentPart.CFrame:Inverse() * inst.CFrame
                data.Properties["RelativeCFrame"] = {__t = "CFrame", v = {relativeCF:GetComponents()}}
            end
        end)

        for _, prop in ipairs(props) do
            local ok, val = pcall(function() return inst[prop] end)
            if ok and val ~= nil then local s = saveProp(val); if s ~= nil then data.Properties[prop] = s end end
        end

        data.Properties.SizeOrig = saveProp(inst.Size)

        for _, child in ipairs(inst:GetChildren()) do
            if visualClasses[child.ClassName] then
                table.insert(data.Children, saveInstance(child, inst))
            end
        end

    elseif inst:IsA("Model") then
        if parentPart then
            local relativeCF = parentPart.CFrame:Inverse() * inst:GetPivot()
            data.Properties["RelativeCFrame"] = {__t = "CFrame", v = {relativeCF:GetComponents()}}
        end
        for _, child in ipairs(inst:GetChildren()) do
            if visualClasses[child.ClassName] then
                table.insert(data.Children, saveInstance(child, inst))
            end
        end

    elseif inst:IsA("Attachment") then
        local id = ensureAttachmentID(inst)
        data.Properties.AttachmentID = id

        if parentPart then
            local parentCF = parentPart:IsA("Model") and parentPart:GetPivot() or parentPart.CFrame
            local relativeCF = parentCF:Inverse() * inst.WorldCFrame
            data.Properties["RelativeCFrame"] = {__t = "CFrame", v = {relativeCF:GetComponents()}}
        end

        data.Properties.Position = saveProp(inst.Position)
        data.Properties.Orientation = saveProp(inst.Orientation)

        for _, child in ipairs(inst:GetChildren()) do
            if visualClasses[child.ClassName] then
                table.insert(data.Children, saveInstance(child, inst))
            end
        end

    elseif inst:IsA("Decal") then
        local props = {"Texture", "Face", "Transparency", "Color3", "StudsPerTileU", "StudsPerTileV"}
        for _, prop in ipairs(props) do
            local ok, val = pcall(function() return inst[prop] end)
            if ok and val ~= nil then local s = saveProp(val); if s ~= nil then data.Properties[prop] = s end end
        end
        if parentPart and parentPart:IsA("BasePart") then
            local relativeCF = parentPart.CFrame:Inverse() * inst.Parent.CFrame
            data.Properties["RelativeCFrame"] = {__t = "CFrame", v = {relativeCF:GetComponents()}}
        end

    elseif inst:IsA("Texture") then
        local props = {"Texture", "Face", "Transparency", "Color3", "StudsPerTileU", "StudsPerTileV"}
        for _, prop in ipairs(props) do
            local ok, val = pcall(function() return inst[prop] end)
            if ok and val ~= nil then local s = saveProp(val); if s ~= nil then data.Properties[prop] = s end end
        end

    elseif inst:IsA("SurfaceAppearance") then
        local props = {"AlphaMode", "ColorMap", "MetalnessMap", "NormalMap", "RoughnessMap", "TexturePack"}
        for _, prop in ipairs(props) do
            local ok, val = pcall(function() return inst[prop] end)
            if ok and val ~= nil then local s = saveProp(val); if s ~= nil then data.Properties[prop] = s end end
        end

    elseif inst:IsA("Highlight") then
        local props = {
            "FillColor", "FillTransparency", "OutlineColor", "OutlineTransparency",
            "DepthMode", "Enabled"
        }
        for _, prop in ipairs(props) do
            local ok, val = pcall(function() return inst[prop] end)
            if ok and val ~= nil then local s = saveProp(val); if s ~= nil then data.Properties[prop] = s end end
        end

    elseif inst:IsA("PointLight") then
        local props = {
            "Brightness", "Color", "Enabled", "Range", "Shadows",
            "Transparency", "Visible"
        }
        pcall(function()
            if parentPart then
                local relativeCF = parentPart.CFrame:Inverse() * inst.CFrame
                data.Properties["RelativeCFrame"] = {__t = "CFrame", v = {relativeCF:GetComponents()}}
            end
        end)
        for _, prop in ipairs(props) do
            local ok, val = pcall(function() return inst[prop] end)
            if ok and val ~= nil then local s = saveProp(val); if s ~= nil then data.Properties[prop] = s end end
        end

    elseif inst:IsA("Weld") or inst:IsA("WeldConstraint") then
        if inst.Part0 then data.Properties.Part0Name = inst.Part0.Name end
        if inst.Part1 then data.Properties.Part1Name = inst.Part1.Name end
        pcall(function() data.Properties.C0 = saveProp(inst.C0) end)
        pcall(function() data.Properties.C1 = saveProp(inst.C1) end)
        pcall(function() data.Properties.Enabled = inst.Enabled end)

    elseif inst:IsA("Beam") then
        if inst.Attachment0 then
            data.Properties.Attachment0ID = ensureAttachmentID(inst.Attachment0)
            local parentCF = parentPart and (parentPart:IsA("Model") and parentPart:GetPivot() or parentPart.CFrame) or CFrame.new()
            data.Properties.Attachment0CF = saveProp(parentCF:ToObjectSpace(inst.Attachment0.WorldCFrame))
        end
        if inst.Attachment1 then
            data.Properties.Attachment1ID = ensureAttachmentID(inst.Attachment1)
            local parentCF = parentPart and (parentPart:IsA("Model") and parentPart:GetPivot() or parentPart.CFrame) or CFrame.new()
            data.Properties.Attachment1CF = saveProp(parentCF:ToObjectSpace(inst.Attachment1.WorldCFrame))
        end

        local props = {
            "Color", "Transparency", "Width0", "Width1",
            "FaceCamera", "LightEmission", "LightInfluence", "Texture", "TextureSpeed",
            "TextureLength", "CurveSize0", "CurveSize1", "Enabled"
        }
        for _, prop in ipairs(props) do
            local ok, val = pcall(function() return inst[prop] end)
            if ok and val ~= nil then local s = saveProp(val); if s ~= nil then data.Properties[prop] = s end end
        end

    elseif inst:IsA("Trail") then
        if inst.Attachment0 then
            data.Properties.Attachment0ID = ensureAttachmentID(inst.Attachment0)
            local parentCF = parentPart and (parentPart:IsA("Model") and parentPart:GetPivot() or parentPart.CFrame) or CFrame.new()
            data.Properties.Attachment0CF = saveProp(parentCF:ToObjectSpace(inst.Attachment0.WorldCFrame))
        end
        if inst.Attachment1 then
            data.Properties.Attachment1ID = ensureAttachmentID(inst.Attachment1)
            local parentCF = parentPart and (parentPart:IsA("Model") and parentPart:GetPivot() or parentPart.CFrame) or CFrame.new()
            data.Properties.Attachment1CF = saveProp(parentCF:ToObjectSpace(inst.Attachment1.WorldCFrame))
        end

        local props = {
            "Brightness", "Color", "FaceCamera", "LightEmission", "LightInfluence",
            "Texture", "TextureLength", "TextureMode", "Transparency",
            "Enabled", "Lifetime", "WidthScale"
        }
        pcall(function() data.Properties.MaxLength = saveProp(inst.MaxLength) end)
        pcall(function() data.Properties.MinLength = saveProp(inst.MinLength) end)
        for _, prop in ipairs(props) do
            local ok, val = pcall(function() return inst[prop] end)
            if ok and val ~= nil then local s = saveProp(val); if s ~= nil then data.Properties[prop] = s end end
        end

    elseif inst:IsA("ParticleEmitter") then
        local props = {
            "Brightness", "Color", "LightEmission", "LightInfluence",
            "Orientation", "EmissionDirection", "Size", "Squash", "Texture", "Transparency", "ZOffset",
            "Lifetime", "Rate", "Rotation", "RotSpeed", "Speed", "SpreadAngle",
            "FlipbookFramerate", "FlipbookIncompatible", "FlipbookLayout", "FlipbookMode",
            "Shape", "ShapeInOut", "ShapePartial", "ShapeStyle",
            "Drag", "LockedToPart", "TimeScale", "VelocityInheritance",
            "WindAffectsDrag", "Acceleration", "Enabled"
        }
        for _, prop in ipairs(props) do
            local ok, val = pcall(function() return inst[prop] end)
            if ok and val ~= nil then local s = saveProp(val); if s ~= nil then data.Properties[prop] = s end end
        end
        
        if inst.Parent and inst.Parent:IsA("Attachment") then
            local parentAtt = inst.Parent
            data.Properties.ParentAttachmentName = parentAtt.Name
            if parentPart then
                local parentCF = parentPart:IsA("Model") and parentPart:GetPivot() or parentPart.CFrame
                local relativeCF = parentCF:Inverse() * parentAtt.WorldCFrame
                data.Properties["AttachmentCFrame"] = {__t = "CFrame", v = {relativeCF:GetComponents()}}
            end
        end

    elseif inst:IsA("Bone") then
        if parentPart then
            local parentCF = parentPart:IsA("Model") and parentPart:GetPivot() or parentPart.CFrame
            local relativeToParent = parentCF:Inverse() * inst.CFrame
            data.Properties["RelativeCFrame"] = {__t = "CFrame", v = {relativeToParent:GetComponents()}}
        end
        pcall(function() data.Properties["Transform"] = saveProp(inst.Transform) end)
        for _, child in ipairs(inst:GetChildren()) do
            if visualClasses[child.ClassName] then
                table.insert(data.Children, saveInstance(child, inst))
            end
        end
    end

    return data
end

function SaveModel()
    local stand = getStandMorph1()
    if not stand then warn("StandMorph not found") return end

    for _, obj in ipairs(stand:GetDescendants()) do
        if obj:IsA("Attachment") then
            obj:SetAttribute("SaveID", nil)
        end
    end

    local usedAttachments = {}
    for _, obj in ipairs(stand:GetDescendants()) do
        if obj:IsA("Beam") or obj:IsA("Trail") then
            if obj.Attachment0 then usedAttachments[obj.Attachment0] = true end
            if obj.Attachment1 then usedAttachments[obj.Attachment1] = true end
        end
    end

    local modelData = {}

    pcall(function()
        local upperTorso = stand:FindFirstChild("UpperTorso")
        local gearModel = stand:FindFirstChild("Gear")
        if gearModel and upperTorso then
            local gearMesh = nil
            if gearModel:IsA("Model") then
                gearMesh = gearModel:FindFirstChildWhichIsA("MeshPart")
            elseif gearModel:IsA("MeshPart") then
                gearMesh = gearModel
            end
            if gearMesh then
                if not modelData["_Gear"] then modelData["_Gear"] = {Children = {}} end
                table.insert(modelData["_Gear"].Children, saveInstance(gearMesh, upperTorso))
            end
        end
    end)

    for _, partName in ipairs(allSaveParts) do
        local part = stand:FindFirstChild(partName)
        if part then
            local partData = {Children = {}}

            for _, child in ipairs(part:GetChildren()) do
                if visualClasses[child.ClassName] then
                    if child:IsA("Attachment") then
                        if hasParticleEmitterInside(child) or usedAttachments[child] then
                            table.insert(partData.Children, saveInstance(child, part))
                        end
                    elseif child:IsA("Model") then
                    else
                        table.insert(partData.Children, saveInstance(child, part))
                    end
                end
            end

            modelData[partName] = partData
        end
    end

    for _, obj in ipairs(stand:GetDescendants()) do
        if obj:IsA("Folder") and obj.Name:find("_Extra_Parts$") then
            local targetPartName = obj.Name:gsub("_Extra_Parts$", "")
            if not modelData[targetPartName] then
                modelData[targetPartName] = {Children = {}}
            end
            for _, child in ipairs(obj:GetChildren()) do
                if visualClasses[child.ClassName] then
                    table.insert(modelData[targetPartName].Children, saveInstance(child, stand:FindFirstChild(targetPartName)))
                end
            end
        end
    end

    local highlightsData = {}
    for _, obj in ipairs(stand:GetDescendants()) do
        if obj:IsA("Highlight") then
            table.insert(highlightsData, saveInstance(obj, stand))
        end
    end
    if #highlightsData > 0 then
        modelData["_Highlights"] = {Children = highlightsData}
    end

    local targetPlayer = nil
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Name:lower():find(_G.ADMINDEBUG_name:lower(), 1, true) then
            targetPlayer = player
            break
        end
    end
    
    if targetPlayer and targetPlayer.Character then
        local playerAuras = {}
        for _, part in ipairs(targetPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") then
                for _, child in ipairs(part:GetChildren()) do
                    if (child:IsA("Attachment") or child:IsA("ParticleEmitter")) and (child.Name:find("StandAura") or child.Name:find("Aura")) then
                        local auraData = saveInstance(child, part)
                        auraData.Properties.ParentPartName = part.Name
                        table.insert(playerAuras, auraData)
                        break
                    end
                end
            end
        end
        if #playerAuras > 0 then
            modelData["_PlayerAuras"] = {Children = playerAuras}
            print("Saved " .. #playerAuras .. " StandAura attachments from " .. _G.ADMINDEBUG_name)
        end
    end

    if not isfolder("ssoc_skins") then makefolder("ssoc_skins") end

    local json = HttpService:JSONEncode(modelData)
    local encoded = encodeData(json)
    writefile("ssoc_skins/model.ssoc", encoded)
    print("Saved! (encrypted .ssoc + StandAura)")
end

local function loadProp(data)
    if type(data) == "table" and data.__t then
        local t = data.__t
        local v = data.v

        if t == "Vector3" then
            return Vector3.new(v[1], v[2], v[3])
        elseif t == "Vector2" then
            return Vector2.new(v[1], v[2])
        elseif t == "Color3" then
            return Color3.new(v[1], v[2], v[3])
        elseif t == "CFrame" then
            return CFrame.new(table.unpack(v))
        elseif t == "NumberRange" then
            return NumberRange.new(v[1], v[2])
        elseif t == "NumberSequence" then
            local keys = {}
            for _, p in ipairs(v) do
                table.insert(keys, NumberSequenceKeypoint.new(p.Time, p.Value, p.Envelope or 0))
            end
            return NumberSequence.new(keys)
        elseif t == "ColorSequence" then
            local keys = {}
            for _, p in ipairs(v) do
                table.insert(keys, ColorSequenceKeypoint.new(p.Time, Color3.new(p.Color[1], p.Color[2], p.Color[3])))
            end
            return ColorSequence.new(keys)
        elseif t == "BrickColor" then
            return BrickColor.new(v)
        elseif t == "Enum" then
            local parts = {}
            for part in string.gmatch(v, "[^%.]+") do
                table.insert(parts, part)
            end
            if #parts >= 3 then
                local enumName = parts[2]
                local valueName = parts[3]
                local success, result = pcall(function()
                    return Enum[enumName][valueName]
                end)
                if success then
                    return result
                end
            end
        end
    end
    return data
end

local function applyProps(inst, props, children)
    if inst:IsA("MeshPart") then
        if props.MeshId then pcall(function() inst.MeshId = loadProp(props.MeshId) end) end
        if props.TextureID then pcall(function() inst.TextureID = loadProp(props.TextureID) end) end

        for prop, value in pairs(props) do
            if prop ~= "RelativeCFrame" and prop ~= "MeshId" and prop ~= "TextureID" 
               and prop ~= "SizeOrig" and prop ~= "HasDecalChild" 
               and prop ~= "Attachment0CF" and prop ~= "Attachment1CF"
               and prop ~= "Attachment0ID" and prop ~= "Attachment1ID"
               and prop ~= "AttachmentID"
               and prop ~= "RelativeToStand"
               and prop ~= "Position" and prop ~= "Orientation"
               and prop ~= "Transform" then
                local decoded = loadProp(value)
                if decoded ~= nil then
                    pcall(function() inst[prop] = decoded end)
                end
            end
        end

        local hasDecalChild = false
        if children then
            for _, child in ipairs(children) do
                if child.ClassName == "Decal" then
                    hasDecalChild = true
                    break
                end
            end
        end
        if hasDecalChild then
            pcall(function() inst.Size = Vector3.new(1.1, 1.1, 1.1) end)
        else
            pcall(function() inst.Size = Vector3.new(1, 1, 1) end)
        end

    elseif inst:IsA("Bone") then
        if props.Transform then
            pcall(function() inst.Transform = loadProp(props.Transform) end)
        end

    elseif inst:IsA("Weld") or inst:IsA("WeldConstraint") then
        if props.Part0Name then inst:SetAttribute("WeldPart0", props.Part0Name) end
        if props.Part1Name then inst:SetAttribute("WeldPart1", props.Part1Name) end
        for prop, value in pairs(props) do
            if prop ~= "Part0Name" and prop ~= "Part1Name" then
                local decoded = loadProp(value)
                if decoded ~= nil then pcall(function() inst[prop] = decoded end) end
            end
        end

    elseif inst:IsA("Highlight") then
        for prop, value in pairs(props) do
            local decoded = loadProp(value)
            if decoded ~= nil then
                pcall(function() inst[prop] = decoded end)
            end
        end

    elseif inst:IsA("PointLight") then
        for prop, value in pairs(props) do
            if prop ~= "RelativeCFrame" then
                local decoded = loadProp(value)
                if decoded ~= nil then
                    pcall(function() inst[prop] = decoded end)
                end
            end
        end

    elseif inst:IsA("Attachment") then
        if props.Position then
            pcall(function() inst.Position = loadProp(props.Position) end)
        end
        if props.Orientation then
            pcall(function() inst.Orientation = loadProp(props.Orientation) end)
        end

    elseif inst:IsA("Decal") then
        for prop, value in pairs(props) do
            if prop ~= "RelativeCFrame" then
                local decoded = loadProp(value)
                if decoded ~= nil then
                    pcall(function() inst[prop] = decoded end)
                end
            end
        end

    elseif inst:IsA("Texture") then
        for prop, value in pairs(props) do
            local decoded = loadProp(value)
            if decoded ~= nil then
                pcall(function() inst[prop] = decoded end)
            end
        end

    elseif inst:IsA("SurfaceAppearance") then
        for prop, value in pairs(props) do
            local decoded = loadProp(value)
            if decoded ~= nil then
                pcall(function() inst[prop] = decoded end)
            end
        end

    elseif inst:IsA("Beam") then
        for prop, value in pairs(props) do
            if prop ~= "Attachment0CF" and prop ~= "Attachment1CF"
               and prop ~= "Attachment0ID" and prop ~= "Attachment1ID" then
                local decoded = loadProp(value)
                if decoded ~= nil then
                    pcall(function() inst[prop] = decoded end)
                end
            end
        end

    elseif inst:IsA("Trail") then
        for prop, value in pairs(props) do
            if prop ~= "Attachment0CF" and prop ~= "Attachment1CF"
               and prop ~= "Attachment0ID" and prop ~= "Attachment1ID" then
                local decoded = loadProp(value)
                if decoded ~= nil then
                    pcall(function() inst[prop] = decoded end)
                end
            end
        end

    elseif inst:IsA("ParticleEmitter") then
        for prop, value in pairs(props) do
            local decoded = loadProp(value)
            if decoded ~= nil then
                pcall(function() inst[prop] = decoded end)
            end
        end
    end
end

local function createFromData(parent, childData)
    if childData.ClassName == "Model" then
        for _, subData in ipairs(childData.Children or {}) do
            if subData.ClassName == "Attachment" then
                createFromData(parent, subData)
            end
        end
        for _, subData in ipairs(childData.Children or {}) do
            if subData.ClassName == "Beam" or subData.ClassName == "Trail" then
                createFromData(parent, subData)
            end
        end
        for _, subData in ipairs(childData.Children or {}) do
            if subData.ClassName ~= "Attachment" and subData.ClassName ~= "Beam" and subData.ClassName ~= "Trail" then
                createFromData(parent, subData)
            end
        end

    elseif childData.ClassName == "Attachment" then
        local attachment = Instance.new("Attachment")
        attachment.Name = (childData.Name or "Attachment") .. "_Custom"
        attachment.Parent = parent

        if childData.Properties and childData.Properties.AttachmentID then
            attachmentCache[childData.Properties.AttachmentID] = attachment
        end

        if childData.Properties and childData.Properties.RelativeCFrame then
            local parentCF = parent:IsA("Model") and parent:GetPivot() or parent.CFrame
            local relCF = loadProp(childData.Properties.RelativeCFrame)
            attachment.CFrame = relCF
        end

        if childData.Properties then
            applyProps(attachment, childData.Properties)
        end

        for _, subData in ipairs(childData.Children or {}) do
            createFromData(attachment, subData)
        end

    elseif childData.ClassName == "Beam" then
        local beam = Instance.new("Beam")
        beam.Name = (childData.Name or "Beam") .. "_Custom"
        beam.Parent = parent

        if childData.Properties then
            if childData.Properties.Attachment0ID then
                beam:SetAttribute("A0", childData.Properties.Attachment0ID)
            end
            if childData.Properties.Attachment1ID then
                beam:SetAttribute("A1", childData.Properties.Attachment1ID)
            end
            applyProps(beam, childData.Properties)
        end

    elseif childData.ClassName == "Trail" then
        local trail = Instance.new("Trail")
        trail.Name = (childData.Name or "Trail") .. "_Custom"
        trail.Parent = parent

        if childData.Properties then
            if childData.Properties.Attachment0ID then
                trail:SetAttribute("A0", childData.Properties.Attachment0ID)
            end
            if childData.Properties.Attachment1ID then
                trail:SetAttribute("A1", childData.Properties.Attachment1ID)
            end
            applyProps(trail, childData.Properties)
        end

    elseif childData.ClassName == "Bone" then
        local bone = Instance.new("Bone")
        bone.Name = (childData.Name or "Bone") .. "_Custom"
        bone.Parent = parent

        applyProps(bone, childData.Properties or {})

        for _, subData in ipairs(childData.Children or {}) do
            createFromData(bone, subData)
        end

    elseif childData.ClassName == "Highlight" then
        local highlight = Instance.new("Highlight")
        highlight.Name = (childData.Name or "Highlight") .. "_Custom"
        highlight.Parent = parent
        applyProps(highlight, childData.Properties or {})

    elseif childData.ClassName == "Weld" or childData.ClassName == "WeldConstraint" then
        local weld = Instance.new(childData.ClassName)
        weld.Name = (childData.Name or childData.ClassName) .. "_Custom"
        weld.Parent = parent
        applyProps(weld, childData.Properties or {})

    elseif childData.ClassName == "PointLight" then
        local light = Instance.new("PointLight")
        light.Name = (childData.Name or "PointLight") .. "_Custom"
        light.Parent = parent

        applyProps(light, childData.Properties or {})

        if childData.Properties and childData.Properties.RelativeCFrame then
            local parentCF = parent:IsA("Model") and parent:GetPivot() or parent.CFrame
            local relCF = loadProp(childData.Properties.RelativeCFrame)
            light.CFrame = parentCF * relCF
        end

    elseif childData.ClassName == "MeshPart" then
        local child = Instance.new("MeshPart")
        child.Name = (childData.Name or childData.ClassName) .. "_Custom"
        child.Parent = parent

        applyProps(child, childData.Properties or {}, childData.Children or {})
        
        child.Anchored = false
        child.CanCollide = false
        child.CanTouch = false
        child.CanQuery = false
        child.Massless = true

        for _, subData in ipairs(childData.Children or {}) do
            if subData.ClassName == "Attachment" then
                createFromData(child, subData)
            end
        end
        for _, subData in ipairs(childData.Children or {}) do
            if subData.ClassName == "Beam" or subData.ClassName == "Trail" then
                createFromData(child, subData)
            end
        end
        for _, subData in ipairs(childData.Children or {}) do
            if subData.ClassName ~= "Attachment" and subData.ClassName ~= "Beam" and subData.ClassName ~= "Trail" then
                createFromData(child, subData)
            end
        end

        if childData.Properties and childData.Properties.RelativeCFrame then
            local parentCF = parent:IsA("Model") and parent:GetPivot() or (parent:IsA("Attachment") and parent.WorldCFrame or parent.CFrame)
            local relCF = loadProp(childData.Properties.RelativeCFrame)
            child.CFrame = parentCF * relCF
        end

        if parent:IsA("BasePart") then
            local weld = Instance.new("Weld")
            weld.Part0 = parent
            weld.Part1 = child
            local relative = parent.CFrame:ToObjectSpace(child.CFrame)
            weld.C0 = relative
            weld.C1 = CFrame.new()
            weld.Parent = child
        end

    elseif childData.ClassName == "Decal" then
        local decal = Instance.new("Decal")
        decal.Name = (childData.Name or "Decal") .. "_Custom"
        decal.Parent = parent
        applyProps(decal, childData.Properties or {})

    else
        local child = Instance.new(childData.ClassName)
        child.Name = (childData.Name or childData.ClassName) .. "_Custom"
        child.Parent = parent
        applyProps(child, childData.Properties or {})
    end
end

local function clearAllPlayerAuras()
    local myChar = LocalPlayer.Character
    if not myChar then return end
    for _, part in ipairs(myChar:GetChildren()) do
        if part:IsA("BasePart") then
            local toRemove = {}
            for _, child in ipairs(part:GetChildren()) do
                if child:IsA("Attachment") and (child.Name:find("StandAura") or child.Name:find("Aura")) then
                    table.insert(toRemove, child)
                end
                if child:IsA("ParticleEmitter") and (child.Name:find("StandAura") or child.Name:find("Aura")) then
                    table.insert(toRemove, child)
                end
            end
            for _, att in ipairs(toRemove) do att:Destroy() end
        end
    end
end

local function loadPlayerAuras(modelData)
    if not modelData["_PlayerAuras"] then return end
    local myChar = LocalPlayer.Character
    if not myChar then return end
    
    for _, childData in ipairs(modelData["_PlayerAuras"].Children or {}) do
        local savedPartName = nil
        if childData.Properties then
            savedPartName = childData.Properties.ParentPartName
        end
        
        if savedPartName then
            local targetPart = myChar:FindFirstChild(savedPartName)
            if targetPart then
                createFromData(targetPart, childData)
            end
        end
    end
end

local zzz = {"madeinchristmasfuture.ssoc", "horsemanofheaven.ssoc", "mrjukesangels.ssoc", "retrotheworldoverheaven.ssoc", "theworldunderhell.ssoc", "arlong.ssoc", "shadowtheworld.ssoc", "festiveworld.ssoc", "thewaifuoverheaven.ssoc", "ghostworld.ssoc", "fusedzamasu.ssoc", "thewaifuv2.ssoc", "lightbringer.ssoc", "sumoworld.ssoc", "old.ssoc", "thenooboverheaven.ssoc", "theworldgreatesthigh.ssoc", "ovatheworld.ssoc"}

function validate(val)
    for _, b in pairs(zzz) do
        if tostring(val) == tostring(b) then
            print(val .. ' == ' .. b)
            return false
        end
    end
    return true
end

function LoadModel(val, standName, standOverride)
    local stand = standOverride or getStandMorph2()
    if not stand then warn("StandMorph not found") return end

    local standNameParsed = standName:gsub(":", ""):match("^%s*(.-)%s*$")
    local filePath = "ssoc_skins/" .. val

    if not isfile(filePath) then
        warn("'" .. filePath .. "' not found, trying to download...")
        if DownloadSkin(val) then
            print("Downloaded '" .. val .. "' successfully. Continue loading...")
        else
            warn("Failed to download '" .. val .. "'.")
            return
        end
    end

    attachmentCache = {}

    local raw = readfile(filePath)
    local json = decodeData(raw)
    local modelData = HttpService:JSONDecode(json)

    local upperTorso = stand:FindFirstChild("UpperTorso")
    local hrp = stand:FindFirstChild("HumanoidRootPart")

    clearAllPlayerAuras()

    if modelData["Horse"] and upperTorso and not upperTorso:FindFirstChild("Horse") then
        local horse = Instance.new("MeshPart")
        horse.Name = "Horse"
        horse.Anchored = false
        horse.CanCollide = false
        horse.Massless = true
        horse.Parent = upperTorso
        local weld = Instance.new("Weld")
        weld.Part0 = upperTorso
        weld.Part1 = horse
        weld.C0 = upperTorso.CFrame:ToObjectSpace(horse.CFrame)
        weld.C1 = CFrame.new()
        weld.Parent = horse
        print("Created Horse MeshPart in UpperTorso")
    end

    if modelData["_Gear"] then
        local gearData = modelData["_Gear"].Children[1]
        if gearData and gearData.ClassName == "MeshPart" then
            local gear = Instance.new("MeshPart")
            gear.Name = "Gear"
            gear.Anchored = false
            gear.CanCollide = false
            gear.Massless = true
            if gearData.Properties then
                applyProps(gear, gearData.Properties, nil)
            end
            if upperTorso and gearData.Properties and gearData.Properties.RelativeCFrame then
                local relCF = loadProp(gearData.Properties.RelativeCFrame)
                gear.CFrame = upperTorso.CFrame * relCF
            end
            gear.Parent = upperTorso or stand
            if stand:FindFirstChild("HumanoidRootPart") then
                local weld = Instance.new("Weld")
                weld.Part0 = stand:FindFirstChild("HumanoidRootPart")
                weld.Part1 = gear
                weld.C0 = CFrame.new()
                weld.C1 = CFrame.new(0, -2, -2)
                weld.Parent = gear
            end
        end
    end

    local bodyLookup = {}
    for _, name in ipairs(bodyParts) do
        bodyLookup[name] = false
    end
    bodyLookup["HumanoidRootPart"] = false
    bodyLookup["Head"] = false

    bodyLookup["Gear"] = false
    bodyLookup["Horse"] = false

    for _, obj in ipairs(stand:GetDescendants()) do
        if obj:IsA("MeshPart") or obj:IsA("Part") then
            if not bodyLookup[obj.Name] then
                obj.Transparency = 1
                obj.LocalTransparencyModifier = 1
                obj.CanCollide = false
                obj.CastShadow = false
            end
        elseif obj:IsA("Decal") then
            obj.Transparency = 1
        elseif obj:IsA("Beam") then
            obj.Enabled = false
        elseif obj:IsA("Trail") then
            obj.Enabled = false
        elseif obj:IsA("ParticleEmitter") then
            obj.Enabled = false
        elseif obj:IsA("PointLight") then
            obj.Enabled = false
        end
    end

    local toRemove = {}
    for _, obj in ipairs(stand:GetDescendants()) do
        if obj.Name:find("_Custom$") then
            table.insert(toRemove, obj)
        end
    end
    for _, obj in ipairs(toRemove) do
        obj:Destroy()
    end

    local partNames = {}
    for name in pairs(modelData) do
        table.insert(partNames, name)
    end
    table.sort(partNames)

    for _, partName in ipairs(partNames) do
        if partName ~= "_Gear" and partName ~= "_Highlights" and partName ~= "_PlayerAuras" then
            local part = stand:FindFirstChild(partName)
            local partData = modelData[partName]
            if part and partData then
                for _, childData in ipairs(partData.Children or {}) do
                    if childData.ClassName == "Attachment" then
                        createFromData(part, childData)
                    end
                end
            end
        end
    end

    for _, partName in ipairs(partNames) do
        if partName ~= "_Gear" and partName ~= "_Highlights" and partName ~= "_PlayerAuras" then
            local part = stand:FindFirstChild(partName)
            local partData = modelData[partName]
            if part and partData then
                for _, childData in ipairs(partData.Children or {}) do
                    if childData.ClassName == "Beam" or childData.ClassName == "Trail" then
                        createFromData(part, childData)
                    end
                end
            end
        end
    end

    for _, partName in ipairs(partNames) do
        if partName == "_Highlights" then
            local highlightsData = modelData["_Highlights"]
            if highlightsData then
                for _, childData in ipairs(highlightsData.Children or {}) do
                    createFromData(stand, childData)
                end
            end
        elseif partName == "_Gear" then
        elseif partName == "_PlayerAuras" then
            loadPlayerAuras(modelData)
        else
            local part = stand:FindFirstChild(partName)
            local partData = modelData[partName]
            if part and partData then
                for _, childData in ipairs(partData.Children or {}) do
                    if childData.ClassName ~= "Attachment" and childData.ClassName ~= "Beam" and childData.ClassName ~= "Trail" then
                        createFromData(part, childData)
                    end
                end
            end
        end
    end

    for _, obj in ipairs(stand:GetDescendants()) do
        if obj:IsA("Beam") or obj:IsA("Trail") then
            local a0ID = obj:GetAttribute("A0")
            local a1ID = obj:GetAttribute("A1")
            if a0ID and attachmentCache[a0ID] then
                obj.Attachment0 = attachmentCache[a0ID]
            end
            if a1ID and attachmentCache[a1ID] then
                obj.Attachment1 = attachmentCache[a1ID]
            end
        end
    end

    for _, obj in ipairs(stand:GetDescendants()) do
        if obj:IsA("Weld") or obj:IsA("WeldConstraint") then
            local p0Name = obj:GetAttribute("WeldPart0")
            local p1Name = obj:GetAttribute("WeldPart1")
            if p0Name then
                local p0 = obj.Parent:FindFirstChild(p0Name .. "_Custom") or obj.Parent:FindFirstChild(p0Name)
                if p0 then obj.Part0 = p0 end
            end
            if p1Name then
                local p1 = obj.Parent:FindFirstChild(p1Name .. "_Custom") or obj.Parent:FindFirstChild(p1Name)
                if p1 then obj.Part1 = p1 end
            end
        end
    end

    if not standOverride then
        local function onStandRemoved()
            clearAllPlayerAuras()
        end
        
        stand.AncestryChanged:Connect(function(_, parent)
            if parent == nil then
                onStandRemoved()
            end
        end)
        
        LocalPlayer.CharacterAdded:Connect(function()
            clearAllPlayerAuras()
        end)
    end

    local count = 0
    for _, obj in ipairs(stand:GetDescendants()) do
        if obj.Name:find("_Custom$") then
            count = count + 1
        end
    end

    if val:match("retrotheworld") or (val:match("old") and not val:match("controldevil")) or val:match("theworldgreatest") or val:match("ovatheworld") then
        stand.Name = ""
        stand.Head.Transparency = 0
        stand.Head.Color = Color3.new(1,1,1)
        stand.LeftFoot.Transparency = 0
        stand.LeftFoot.Color = Color3.new(1,1,1)
        stand.UpperTorso.Transparency = 0
        stand.UpperTorso.Color = Color3.new(1,1,1)
        stand.RightUpperLeg.Transparency = 0
        stand.RightUpperLeg.Color = Color3.new(1,1,1)
        stand.RightUpperArm.Transparency = 0
        stand.RightUpperArm.Color = Color3.new(1,1,1)
        stand.RightLowerLeg.Transparency = 0
        stand.RightLowerLeg.Color = Color3.new(1,1,1)
        stand.RightLowerArm.Transparency = 0
        stand.RightLowerArm.Color = Color3.new(1,1,1)
        stand.RightHand.Transparency = 0
        stand.RightHand.Color = Color3.new(1,1,1)
        stand.RightFoot.Transparency = 0
        stand.RightFoot.Color = Color3.new(1,1,1)
        stand.LowerTorso.Transparency = 0
        stand.LowerTorso.Color = Color3.new(1,1,1)
        stand.LeftUpperLeg.Transparency = 0
        stand.LeftUpperLeg.Color = Color3.new(1,1,1)
        stand.LeftUpperArm.Transparency = 0
        stand.LeftUpperArm.Color = Color3.new(1,1,1)
        stand.LeftLowerLeg.Transparency = 0
        stand.LeftLowerLeg.Color = Color3.new(1,1,1)
        stand.LeftLowerArm.Transparency = 0
        stand.LeftLowerArm.Color = Color3.new(1,1,1)
        stand.LeftHand.Transparency = 0
        stand.LeftHand.Color = Color3.new(1,1,1)
    elseif val:match("ovasp") then
        stand.Name = ""
        stand.LeftFoot.Transparency = 0
        stand.UpperTorso.Transparency = 0
        stand.UpperTorso.Color = Color3.fromRGB(22, 29, 50)
        stand.RightUpperLeg.Transparency = 0
        stand.RightUpperLeg.Color = Color3.fromRGB(52, 67, 89)
        stand.RightUpperArm.Transparency = 0
        stand.RightUpperArm.Color = Color3.fromRGB(175, 221, 255)
        stand.RightLowerLeg.Transparency = 0
        stand.RightLowerArm.Transparency = 0
        stand.RightHand.Transparency = 0
        stand.RightFoot.Transparency = 0
        stand.LowerTorso.Transparency = 0
        stand.LeftUpperLeg.Transparency = 0
        stand.LeftUpperLeg.Color = Color3.fromRGB(52, 67, 89)
        stand.LeftUpperArm.Transparency = 0
        stand.LeftUpperArm.Color = Color3.fromRGB(175, 221, 255)
        stand.LeftLowerLeg.Transparency = 0
        stand.LeftLowerArm.Transparency = 0
        stand.LeftHand.Transparency = 0
    end
    print("Loaded! " .. count .. " custom parts created")
end
_G.ADMINDEBUG_name = "yaro"
function loadRtwoh(val, standName, standOverride)
	LoadModel("thenooboverheaven.ssoc", standName, standOverride)
	LoadModel(val, standName, standOverride)

    local gear = standOverride.UpperTorso:FindFirstChild("Gear")
    if gear then
        gear.Transparency = 0
        print('[debug]: loaded rtwoh gear')
    end
end
-- ok
createStandTab = function(classLabel, title, entries, callback)
    return Library:CreateStandTab(classLabel, title, entries, callback)
end
local tab_stands = Library:CreateClass("Stands")
if not isfolder("ssoc_skins") then
    makefolder("ssoc_skins")
end
local ssocskins = {}
local function scanFolder(folder)
	for _, path in ipairs(listfiles(folder)) do
		if isfolder(path) then
			scanFolder(path)
		elseif path:lower():match("%.ssoc$") then
			table.insert(ssocskins, path:match("([^/\\]+)$"))
		end
	end
end
scanFolder("ssoc_skins")

function DownloadSkin(fileName)
    local success, data = pcall(function()
        return game:HttpGet(_G.nga_link .. "?s=" .. fileName)
    end)

    if not success then
        warn("Failed to download skin:", fileName)
        return false
    end

    writefile("ssoc_skins/" .. fileName, data)

    if not table.find(ssocskins, fileName) then
        table.insert(ssocskins, fileName)
    end

    return true
end

local DB_FILE = "ssoc_skins/stands_dat.json"
_G.skinChanger_stands = {}
function SaveSkinDB()
    if not isfolder("ssoc_skins") then makefolder("ssoc_skins") end
    local json = HttpService:JSONEncode(_G.skinChanger_stands)
    writefile(DB_FILE, json)
    print("[DB] Saved " .. #_G.skinChanger_stands .. " entries")
end
function LoadSkinDB()
    if not isfile(DB_FILE) then
        _G.skinChanger_stands = {}
        print("[DB] No database found, created empty")
        return
    end
    local json = readfile(DB_FILE)
    local data = HttpService:JSONDecode(json)
    _G.skinChanger_stands = data or {}
    print("[DB] Loaded " .. #_G.skinChanger_stands .. " entries")
end
LoadSkinDB()
createStandTab(tab_stands, "Stand Skins", {
    {Name = "Star Platinum", Skins = {"None", "Ova SP", "Jack-O-Platinum", "Luffy Gear 4", "Sumo Platinum", "Ova Platinum"}},
    {Name = "Star Platinum: The World", Skins = {"None", "Haunted Jack-O-Platinum", "Jack-O-Platinum", "Festive Platinum", "Digital Star Platinum", "Star Platinum Stone Ocean", "Luffy Gear 4", "Sumo Platinum", "Ova Platinum", "Ova SP"}},
    {Name = "The World", Skins = {"None", "Ghost World", "Festive World", "Shadow The World", "Sumo World", "Arlong", "The World Greatest High", "The Waifu v2", "Ova The World"}},
    {Name = "The World Over Heaven", Skins = {"None", "OLD", "Fused Zamasu", "Ghost World", "Mirage of Phantoms", "The Waifu Over Heaven", "Lightbringer", "The World Under Hell", "Festive World", "Retro The World Over Heaven", "Shadow The World", "Sumo World", "Arlong", "The World Greatest High", "The Waifu v2", "The Noob Over Heaven", "Ova The World"}},
    {Name = "The World Alternate Universe", Skins = {"None", "TWAU Over Heaven", "Deadeye Drifter", "The World: Ultimate", "The Waifu Alternate Universe"}},
    {Name = "King Crimson", Skins = {"None", "Jester Crimson", "King Peppermint"}},
    {Name = "King Crimson Requiem", Skins = {"None", "Grim Reaper", "Goku Black", "King Crampus", "Sukuna", "Jester Crimson", "King Peppermint"}},
    {Name = "Gold Experience", Skins = {"None", "Dead Experience", "Biblically Accurate Experience"}},
    {Name = "Gold Experience Requiem", Skins = {"None", "Astral Enigma", "Lord Boros", "Dead Experience", "Biblically Accurate Experience"}},
    {Name = "Killer Queen", Skins = {"None", "Frostbite"}},
    {Name = "Killer Queen: Bites the Dust", Skins = {"None", "SCP-096", "Frostbite"}},
    {Name = "Whitesnake", Skins = {"None", "Snake of Christmas Past", "Moon of Christmas Past", "Deimos Snake"}},
    {Name = "C-Moon", Skins = {"None", "Devil Moon", "Vela-Nova", "Snake of Christmas Past", "Moon of Christmas Past", "Deimos Snake"}},
    {Name = "Made in Heaven", Skins = {"None", "Made in Christmas Future", "Horseman of Heaven", "Mr Jukes Angles", "Devil Moon", "Vela-Nova", "Snake of Christmas Past", "Moon of Christmas Past", "Deimos Snake"}},
    {Name = "Shadow The World", Skins = {"None", "Booette", "GoJo", "Nah Id Win", "Shadow The World", "Shadow The Waifu"}},
    {Name = "Tusk Act 4", Skins = {"None", "Wendigo", "Tusk Dark Determination", "Tomb Crypt Tusk", "Heaven Act 4"}},
    {Name = "Crazy Diamond", Skins = {"None", "Crazy Overseer", "Neon Ascension Diamond", "Crazy Idol"}},
    {Name = "Crazy Diamond Requiem", Skins = {"None", "New Idol", "Crazy Sapphire Requiem", "Volcanic Diamond", "Jade Serenity", "Gilded Diamond", "Diamond head"}},
    {Name = "Chariot Requiem", Skins = {"None", "Bunny Devil", "Ghostface", "Shanks", "Control Devil"}},
    {Name = "Chilli Pepper Alternate Universe", Skins = {"None", "Zenitsu"}},
    {Name = "Weather Report", Skins = {"None", "Aang", "Korra", "Zeus OP"}},
    {Name = "Diver Down", Skins = {"None", "Diva Down", "Bondrewd", "Bubblegum", "Cthulhu", "Deep Sea Diver", "Mermaid", "Nautilodaunt"}},
    {Name = "Magicans Red", Skins = {"None", "Undead Flare"}}
}, function(stand, skin)
    print('[DEBUG.2924] st: ' .. stand .. ' | sk: ' .. skin)
    if skin == "None" then
        _G.skinChanger_stands[stand] = nil
        SaveSkinDB()
        return
    end
    local wanted = string.lower(skin:gsub(" ", ""):match("^%s*(.-)%s*$"))
    local found

    for _, file in ipairs(ssocskins) do
        if file:match(wanted) then
            found = file
            break
        end
    end

    if not found then
        local fileName = wanted .. ".ssoc"

        if DownloadSkin(fileName) then
            found = fileName
        else
            warn("Skin doesn't exist on server:", fileName)
            return
        end
    end

    _G.skinChanger_stands[stand] = found
    SaveSkinDB()
end)

local player = game:GetService("Players").LocalPlayer

if _G.AD_SkinChangerCleanup then
    pcall(_G.AD_SkinChangerCleanup)
end

local function ApplyStandSkinFromMorph(standMorph)
    task.spawn(function()
        local standName = standMorph:WaitForChild("Stand Name", 5)
        if not standName then return end

        local skin = _G.skinChanger_stands[standName.Value]

        if skin == "" or not skin then
            return
        end

        task.wait(1)

        local ok, err = pcall(function()
            if skin:match("retrotheworld") or skin:match("old") or skin:match("theworldgreatest") or skin:match("ovatheworld") then
                loadRtwoh(skin, standName.Value, standMorph)
            else
                LoadModel(skin, standName.Value, standMorph)
            end
        end)
        if not ok then
            warn("[SkinChanger] LoadModel failed: " .. tostring(err))
        end
    end)
end

local function ApplyGloveSkinWhenReady()
    task.spawn(function()
        repeat
            task.wait(0.15)
        until #getAllGloves() > 0

        skinChanger(_G.Config.itemSkinGloves)
    end)
end

local function SetupCharacter()
    local workspacePlayer
    for _ = 1, 40 do
        local living = workspace:FindFirstChild("Living")
        workspacePlayer = living and living:FindFirstChild(player.Name)
        if workspacePlayer then
            break
        end
        task.wait(0.25)
    end

    if not workspacePlayer then
        warn("[SkinChanger] workspace.Living." .. player.Name .. " not found")
        return
    end

    if _G.qweqwe then
        _G.qweqwe:Disconnect()
    end

    local currentStand = workspacePlayer:FindFirstChild("StandMorph")
    if currentStand then
        ApplyStandSkinFromMorph(currentStand)
    end

    _G.qweqwe = workspacePlayer.ChildAdded:Connect(function(child)
        if child.Name == "StandMorph" then
            ApplyStandSkinFromMorph(child)
        end
    end)
end

local skinChangerCharacterConnection

_G.AD_SkinChangerCleanup = function()
    if _G.qweqwe then
        _G.qweqwe:Disconnect()
        _G.qweqwe = nil
    end
    if skinChangerCharacterConnection then
        skinChangerCharacterConnection:Disconnect()
        skinChangerCharacterConnection = nil
    end
end

if player.Character then
    task.spawn(SetupCharacter)
    ApplyGloveSkinWhenReady()
end

skinChangerCharacterConnection = player.CharacterAdded:Connect(function()
    task.spawn(SetupCharacter)
    ApplyGloveSkinWhenReady()
end)

local succ, err = pcall(function()
    -- init
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end

    if not syn or not protectgui then
        getgenv().protectgui = function() end
    end

    local Camera = workspace.CurrentCamera
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local GuiService = game:GetService("GuiService")
    local UserInputService = game:GetService("UserInputService")

    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()

    local GetPlayers = Players.GetPlayers
    local WorldToScreen = Camera.WorldToScreenPoint
    local WorldToViewportPoint = Camera.WorldToViewportPoint
    local GetPartsObscuringTarget = Camera.GetPartsObscuringTarget
    local FindFirstChild = game.FindFirstChild
    local RenderStepped = RunService.RenderStepped
    local GuiInset = GuiService.GetGuiInset
    local GetMouseLocation = UserInputService.GetMouseLocation

    local ValidTargetParts = {"Head", "HumanoidRootPart"}

    local ExpectedArguments = {
        Raycast = {
            ArgCountRequired = 3,
            Args = {
                "Instance", "Vector3", "Vector3", "RaycastParams"
            }
        }
    }

    local targetVelocities = {}
    local targetLastPositions = {}

    RunService.RenderStepped:Connect(function(deltaTime)
        for _, player in next, GetPlayers(Players) do
            if player == LocalPlayer then continue end
            local character = player.Character
            if character then
                local root = character:FindFirstChild("HumanoidRootPart")
                if root then
                    if targetLastPositions[player] then
                        targetVelocities[player] = (root.Position - targetLastPositions[player]) / math.max(deltaTime, 0.001)
                    end
                    targetLastPositions[player] = root.Position
                end
            end
        end
    end)

    local function createTracer(startPos, endPos)
        local beam = Instance.new("Beam")
        beam.Width0 = 0.08
        beam.Width1 = 0.08
        beam.FaceCamera = true
        beam.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))
        beam.Transparency = NumberSequence.new(0)
        beam.LightEmission = 1
        beam.LightInfluence = 0

        local attach0 = Instance.new("Attachment")
        attach0.WorldPosition = startPos
        attach0.Parent = workspace.Terrain

        local attach1 = Instance.new("Attachment")
        attach1.WorldPosition = endPos
        attach1.Parent = workspace.Terrain

        beam.Attachment0 = attach0
        beam.Attachment1 = attach1
        beam.Parent = workspace.Terrain

        task.delay(3.5, function()
            beam:Destroy()
            attach0:Destroy()
            attach1:Destroy()
        end)
    end

    local function getPositionOnScreen(Vector)
        local Vec3, OnScreen = WorldToScreen(Camera, Vector)
        return Vector2.new(Vec3.X, Vec3.Y), OnScreen
    end

    local function ValidateArguments(Args, RayMethod)
        local Matches = 0
        if #Args < RayMethod.ArgCountRequired then
            return false
        end
        for Pos, Argument in next, Args do
            if typeof(Argument) == RayMethod.Args[Pos] then
                Matches = Matches + 1
            end
        end
        return Matches >= RayMethod.ArgCountRequired
    end

    local function getDirection(Origin, Position)
        return (Position - Origin).Unit * 1000
    end

    local function getMousePosition()
        return GetMouseLocation(UserInputService)
    end

    local function IsPlayerVisible(Player)
        local PlayerCharacter = Player.Character
        local LocalPlayerCharacter = LocalPlayer.Character

        if not (PlayerCharacter or LocalPlayerCharacter) then return end

        local PlayerRoot = FindFirstChild(PlayerCharacter, "HumanoidRootPart")

        if not PlayerRoot then return end

        local CastPoints, IgnoreList = {PlayerRoot.Position, LocalPlayerCharacter, PlayerCharacter}, {LocalPlayerCharacter, PlayerCharacter}
        local ObscuringObjects = #GetPartsObscuringTarget(Camera, CastPoints, IgnoreList)

        return ((ObscuringObjects == 0 and true) or (ObscuringObjects > 0 and false))
    end

    local function getClosestTarget()
        if not _G.Config.SilentAimbotEnabled then return nil, nil end

        local closestPart = nil
        local closestPlayer = nil
        local closestDist = _G.Config.SilentAimbotFOV or 250

        local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

        for _, Player in next, GetPlayers(Players) do
            if Player == LocalPlayer then continue end

            local Character = Player.Character
            if not Character then continue end

            local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
            local Humanoid = FindFirstChild(Character, "Humanoid")
            if not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 then continue end

            local screenPos, onScreen = getPositionOnScreen(HumanoidRootPart.Position)
            if not onScreen then continue end

            local dist = (screenPos - screenCenter).Magnitude
            if dist < closestDist then
                closestDist = dist
                closestPart = HumanoidRootPart
                closestPlayer = Player
            end
        end

        return closestPart, closestPlayer
    end

    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
        local Method = getnamecallmethod()
        local Arguments = {...}
        local self = Arguments[1]

        if self == workspace and not checkcaller() then
            if Method == "Raycast" then
                if _G.Config.SilentAimbotEnabled and _G.Config.SilentAimbotBulletDelay and _G.Config.SilentAimbotBulletDelay > 0 then
                    task.wait(_G.Config.SilentAimbotBulletDelay)
                end

                if ValidateArguments(Arguments, ExpectedArguments.Raycast) then
                    local A_Origin = Arguments[2]

                    local HitPart, targetPlayer = getClosestTarget()
                    if HitPart then
                        local targetVel = targetVelocities[targetPlayer] or HitPart.Velocity or Vector3.zero
                        local predictAmount = _G.Config.SilentAimbotPrediction or 0.165

                        Arguments[3] = getDirection(A_Origin, HitPart.Position + targetVel * predictAmount)
                        local result = oldNamecall(unpack(Arguments))

                        if result and result.Instance then
                            local hitChar = result.Instance:FindFirstAncestorOfClass("Model")
                            if hitChar and Players:GetPlayerFromCharacter(hitChar) then
                                if _G.Config.SilentAimbotShowTracer then
                                    createTracer(A_Origin, result.Position)
                                end
                            end
                        end

                        return result
                    end
                end
            end
        end

        return oldNamecall(...)
    end))

    local oldIndex = nil
    oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, Index)
        if self == Mouse and not checkcaller() then
            local HitPart = getClosestTarget()
            if HitPart then
                local predictAmount = _G.Config.SilentAimbotPrediction or 0.165

                if Index == "Target" or Index == "target" then
                    return HitPart
                elseif Index == "Hit" or Index == "hit" then
                    return HitPart.CFrame + (HitPart.Velocity * predictAmount)
                elseif Index == "X" or Index == "x" then
                    return self.X
                elseif Index == "Y" or Index == "y" then
                    return self.Y
                elseif Index == "UnitRay" then
                    return Ray.new(self.Origin, ((HitPart.Position + HitPart.Velocity * predictAmount) - self.Origin).Unit)
                end
            end
        end

        return oldIndex(self, Index)
    end))
end)
if not succ then warn('( !!! ) SILENT AIMBOT: ' .. err) end

end
