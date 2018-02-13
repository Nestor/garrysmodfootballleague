-- By Black Tea for NUTSCRIPT CITYRP. I did not make this!

local iconMat = {
    Material("hud/iconsheet1.png"),
    Material("hud/iconsheet2.png"),
    Material("hud/iconsheet3.png"),
}


surface.CreateFont( "HelperFont", {
	font = font,
	extended = true,
	size = 34,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
} )


local matSize = 256
local iconSize = 60
local iconSizeSect = 64
local txtMiddle = 18
local sw, sh = ScrW(), ScrH()

local function drawIconText(_icoX, _icoY, _x, _y, _t, _icoTex, _alpha)
    _alpha = _alpha or 255
    surface.SetFont("HelperFont")
    local tw, th = surface.GetTextSize(_t)
    local icoSect = (iconSize + 10)

    surface.SetMaterial(iconMat[_icoTex or 2])
    surface.SetDrawColor(255, 255, 255, _alpha)
    surface.DrawTexturedRectUV(_x - icoSect/2 - tw/2, _y - iconSize/2, iconSize, iconSize, iconSizeSect/matSize*_icoX, iconSizeSect/matSize*_icoY, iconSizeSect/matSize*(_icoX+1), iconSizeSect/matSize*(_icoY+1))
    surface.SetTextColor(255, 255, 255, _alpha)
    surface.SetTextPos(_x - tw/2 + icoSect/2, _y - txtMiddle)
    surface.DrawText(_t)
end

local function drawIcon(_icoX, _icoY, _x, _y, _icoTex, _alpha)
    _alpha = _alpha or 255
    surface.SetMaterial(iconMat[_icoTex or 2])
    surface.SetDrawColor(255, 255, 255, _alpha)
    surface.DrawTexturedRectUV(_x - iconSize/2, _y - iconSize/2, iconSize, iconSize, iconSizeSect/matSize*_icoX, iconSizeSect/matSize*_icoY, iconSizeSect/matSize*(_icoX+1), iconSizeSect/matSize*(_icoY+1))
end

local function getEntity()
    local client = LocalPlayer()

    if (client) then
        local trace = client:GetEyeTraceNoCursor()

        if (IsValid(trace.Entity)) then
            return trace.Entity
        end
    end

    return
end

local helperTrackingEnts = {}

function addTrackEntity(icoX, icoY, text, lifeTime, target)
    surface.PlaySound("nui/beepclear.wav")

    local kek = {
        pos = Vector(sw/2, sh/2),
        ico = {icoX, icoY},
        text = text,
        alpha = 0,
        lifetime = CurTime() + lifeTime,
        target = target
    }
    table.insert(helperTrackingEnts, kek)
end

netstream.Hook("notify", function(icX,icY,text,lifeTime,target)
	print(text)
	return addTrackEntity(icX,icY,text,(lifeTime or 5), (target or LocalPlayer()))
end)

local annoyingEnts = {}
local displayInfo = {
    nut_bankreserve = {"tipBankReserve", 0, 2},
    nut_seller = {"tipCheckout", 1, 2},
    nut_atm = {"tipAtm", 1, 2},
    nut_vnd_covfefe = {"tipCovfefe", 1, 2},
    nut_vnd_medical = {"tipMedven", 1, 2},
    nut_attrib_gun = {"tipGunBag", 0, 0},
    nut_attrib_punch = {"tipPunchBag", 0, 0},
    nut_helloboard = {"tipGoaway", 0, 0},
    nut_outfit = {"tipOutfitter", 0, 0},
    nut_craftingtable = {"tipCrafting", 0, 0},
    nut_loadingtable = {"tipCrafting", 0, 0},
    nut_microwave = {"tipCooker", 0, 0},
    nut_stove = {"tipCooker", 0, 0},
    nut_stash = {"tipStash", 0, 0},
    freshcardealer = {"tipCardealer", 0, 0},
}

local nextUpdate = 0
local lastTrace = {}
local lastEntity
local mathApproach = math.Approach
local surface = surface
local hookRun = hook.Run
local toScreen = FindMetaTable("Vector").ToScreen

hook.Add("HUDPaintBackground","DrawNSHintsBG",function()
	if cameraMode then return end
    local realTime = RealTime()
    local localPlayer = LocalPlayer()

	if (nextUpdate < realTime) then
		nextUpdate = realTime + 0.8

		lastTrace.start = localPlayer.GetShootPos(localPlayer)
		lastTrace.endpos = lastTrace.start + localPlayer.GetAimVector(localPlayer)*512
		lastTrace.filter = localPlayer
		lastTrace.mins = Vector( -3, -3, -3 )
		lastTrace.maxs = Vector( 3, 3, 3 )

		lastEntity = util.TraceHull(lastTrace).Entity
	end

    if (IsValid(lastEntity)) then
        local class = lastEntity:GetClass()
        if (displayInfo[class]) then
            if (annoyingEnts[class] and annoyingEnts[class] < CurTime()) then
                annoyingEnts[class] = nil
            end

            if (class and !annoyingEnts[class]) then
                addTrackEntity(displayInfo[class][2], displayInfo[class][3], L(displayInfo[class][1]), 5, lastEntity)
                annoyingEnts[class] = CurTime() + 300
            end
        end
    end
end)

hook.Add("HUDPaint","DrawNSHints",function()
	if cameraMode then return end

    local lerpFT = RealFrameTime() * 7

    for k, v in pairs(helperTrackingEnts) do
        if (!IsValid(v.target)) then
            helperTrackingEnts[k] = nil
            return
        end

        local pos = isentity(v.target) and (v.target:GetPos() + v.target:OBBCenter()) or v.target

        if (v.lifetime and v.lifetime < CurTime()) then
            if (v.alpha) then
                v.alpha = Lerp(lerpFT, v.alpha, 0)
            end

            if (v.alpha and v.alpha < 1) then
                helperTrackingEnts[k] = nil
                return
            end
        else
            if (v.alpha) then
                v.alpha = Lerp(lerpFT, v.alpha, 255)
            end
        end

        v.pos = v.pos or Vector()
        local nw, nh = sh*.1, sh*.1
        local t = pos:ToScreen()

        if (t.x >= nw and t.x <= (sw-nw) and
            t.y >= nh and t.y <= (sh-nh)) then
            v.pos = Lerp(lerpFT, v.pos, Vector(t.x, t.y, 0))
            drawIconText(v.ico[1], v.ico[2], v.pos.x, v.pos.y, v.text, 1, v.alpha)
        else
            t.x = math.Clamp(t.x, nw*.9, sw - nw*.9)
            t.y = math.Clamp(t.y, nh*.9, sh - nh*.9)
            v.pos = Lerp(lerpFT, v.pos, Vector(t.x, t.y, 0))
            drawIcon(v.ico[1], v.ico[2], v.pos.x, v.pos.y, 1, v.alpha)
        end
    end
end)

