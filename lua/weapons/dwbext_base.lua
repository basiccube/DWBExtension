// basiccube's Default Weapon Base Extension

AddCSLuaFile()

SWEP.PrintName = "Default Weapon Base Extension"
SWEP.Category = "DWBExt: Base"
SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false
SWEP.Spawnable = false
SWEP.AdminOnly = false
SWEP.Base = "weapon_base"
SWEP.WeaponIcon = "weapons/swep"

SWEP.ReloadSound = ""
SWEP.ShotgunPumpSound = ""

SWEP.Primary = {
    Damage = 0,
    Ammo = "none",
    TakeAmmo = 1,

    ClipSize = -1,
    DefaultClip = -1,
    Automatic = false,
    Delay = 0.0,

    Spread = Vector(0, 0, 0),
    ViewPunchAngle = Angle(0, 0, 0),
    ViewPunchRandom = false,
    ViewPunchRandomMin = 0,
    ViewPunchRandomMax = 0,
    ViewEyePunch = false,

    NumberofShots = 0,
    TracerAmount = 0,
    Force = 0,
    MeleeDistance = 0,
    Sound = "",
}

SWEP.Secondary = {
    Damage = 0,
    Ammo = "none",
    TakeAmmo = 1,

    ClipSize = -1,
    DefaultClip = -1,
    Automatic = false,
    Delay = 0.0,

    Spread = Vector(0, 0, 0),
    ViewPunchAngle = Angle(0, 0, 0),
    ViewPunchRandom = false,
    ViewPunchRandomMin = 0,
    ViewPunchRandomMax = 0,
    ViewEyePunch = false,

    NumberofShots = 0,
    TracerAmount = 0,
    Force = 0,
    Sound = "",
}

SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.DrawCrosshair = true
SWEP.DrawAmmo = true
SWEP.Weight = 0
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.UseHands = false
SWEP.CSMuzzleFlashes = false

SWEP.WeaponDeploy = {
    Sequence = "draw",
    Speed = 1,

    Sound = "",
    SoundDelay = 0.5,
}

SWEP.MeleeMissToIdleAnim = false

SWEP.HoldType = "pistol"

SWEP.FiresUnderwater = false

include("dwbext/dwbext_utils.lua")

function SWEP:DoViewPunch(secondary)
    secondary = secondary || false

    local punchangle = self.Primary.ViewPunchAngle
    local punchrandom = self.Primary.ViewPunchRandom
    local punchrandommin = self.Primary.ViewPunchRandomMin
    local punchrandommax = self.Primary.ViewPunchRandomMax
    local vieweyepunch = self.Primary.ViewEyePunch
    if secondary then
        punchangle = self.Secondary.ViewPunchAngle
        punchrandom = self.Secondary.ViewPunchRandom
        punchrandommin = self.Secondary.ViewPunchRandomMin
        punchrandommax = self.Secondary.ViewPunchRandomMax
        vieweyepunch = self.Secondary.ViewEyePunch
    end

    if punchrandom then
        punchangle = Angle(punchangle.Pitch * math.Rand(punchrandommin, punchrandommax), punchangle.Yaw, punchangle.Roll)
    end

    if !self:GetOwner():IsNPC() then
        self:GetOwner():ViewPunch(punchangle)
        if vieweyepunch then
            local ViewEyes = self:GetOwner():EyeAngles()
            ViewEyes.Pitch = ViewEyes.Pitch + punchangle.Pitch
            ViewEyes.Yaw = ViewEyes.Yaw + punchangle.Yaw

            self:GetOwner():SetEyeAngles(ViewEyes)
        end
    end
end

function SWEP:Initialize()
    self:SetWeaponHoldType(self.HoldType)
    if CLIENT then
        self.WepSelectIcon = surface.GetTextureID(self.WeaponIcon)
    end
end

function SWEP:PrimaryAttackGeneric()
    if !self:CanPrimaryAttack() then return end

    if (!self.FiresUnderwater && self:GetOwner():WaterLevel() == 3) then
        self:EmitSound("Weapon_Pistol.Empty")
        self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    return end

    local bullet = {}
    bullet.Num = self.Primary.NumberofShots
    bullet.Src = self:GetOwner():GetShootPos()
    bullet.Dir = self:GetOwner():GetAimVector()
    bullet.Spread = self.Primary.Spread
    bullet.Tracer = self.Primary.TracerAmount
    bullet.Force = self.Primary.Force
    bullet.Damage = self.Primary.Damage
    bullet.AmmoType = self.Primary.Ammo

    self:ShootEffects()
    self:GetOwner():FireBullets(bullet)
    self:EmitSound(self.Primary.Sound)
    self:DoViewPunch()

    self:TakePrimaryAmmo(self.Primary.TakeAmmo)
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
end

function SWEP:PrimaryAttackShotgun(secondary)
    secondary = secondary || false
    if !self:CanPrimaryAttack() then return end

    if (self:Clip1() > 0 && (!self:GetOwner():KeyDown(IN_ATTACK2) || secondary)) then
        self:EmitSound(self.Primary.Sound)
        self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
        self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
        self:TakePrimaryAmmo(self.Primary.TakeAmmo)
        self.StartReload = false
        self:SetNWBool("reloading", false)

        self:ShootEffects()
        self:DoViewPunch()
        timer.Simple(0.3, function()
            if self:IsCurrentWeapon() then
                self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
                self:EmitSound(self.ShotgunPumpSound)
            end
        end)

        local bullet = {}
        bullet.Num = self.Primary.NumberofShots
        bullet.Src = self:GetOwner():GetShootPos()
        bullet.Dir = self:GetOwner():GetAimVector()
        bullet.Spread = self.Primary.Spread
        bullet.Tracer = self.Primary.TracerAmount
        bullet.Force = self.Primary.Force
        bullet.Damage = self.Primary.Damage
        bullet.AmmoType = self.Primary.Ammo

        self:GetOwner():FireBullets(bullet)
    end
end

function SWEP:PrimaryAttackMelee()
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    local trace = self:GetOwner():GetEyeTrace()

    if (trace.HitPos:Distance(self:GetOwner():GetShootPos()) <= self.Primary.MeleeDistance) then
        self:GetOwner():SetAnimation(PLAYER_ATTACK1)
        self:SendWeaponAnim(ACT_VM_HITCENTER)

        self:EmitSound("Weapon_Crowbar.Melee_Hit")
        self:EmitSound(self.Primary.Sound)
        self:DoViewPunch()

        local dmg = self.Primary.Damage
        local dmginfo = DamageInfo()
        dmginfo:SetDamage(dmg)
        dmginfo:SetDamageType(DMG_CLUB)
        dmginfo:SetDamagePosition(trace.HitPos)
        dmginfo:SetDamageForce((trace.Normal * dmg) * self.Primary.Force)
        dmginfo:SetAttacker(self:GetOwner())
        dmginfo:SetInflictor(self)

        if (trace.Entity != NULL) then
            local edata = EffectData()
            edata:SetEntity(trace.Entity)
            edata:SetOrigin(trace.HitPos)
            edata:SetStart(trace.StartPos)
            edata:SetSurfaceProp(trace.SurfaceProps)
            edata:SetDamageType(DMG_CLUB)
            edata:SetHitBox(trace.HitBox)
            util.Effect("Impact", edata)

            trace.Entity:DispatchTraceAttack(dmginfo, trace)
        end
    else
        self:EmitSound(self.Primary.Sound)

        self:GetOwner():SetAnimation(PLAYER_ATTACK1)
        self:SendWeaponAnim(ACT_VM_MISSCENTER)

        if self.MeleeMissToIdleAnim then
            timer.Simple(0.4, function()
                if self:IsCurrentWeapon() then
                    self:SendWeaponAnim(ACT_VM_IDLE)
                end
            end)
        end
    end
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:ShotgunDoubleAttack()
    if (self:Clip1() <= 0) then
        if (!self:CanPrimaryAttack()) then
            self:SetNextPrimaryFire(CurTime() + self.Secondary.Delay)
            self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
        return end
    return end

    if (self:Clip1() <= 1 && self:Clip1() > 0 && !self:GetOwner():KeyDown(IN_ATTACK)) then
        self:PrimaryAttackShotgun(true)
    return end

    if (self:Clip1() > 0 && !self:GetOwner():KeyDown(IN_ATTACK)) then
        self:EmitSound(self.Secondary.Sound)
        self:SetNextPrimaryFire(CurTime() + self.Secondary.Delay)
        self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
        self:TakePrimaryAmmo(self.Secondary.TakeAmmo)
        self.StartReload = false
        self:SetNWBool("reloading", false)

        self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
        self:DoViewPunch(true)
        self:GetOwner():MuzzleFlash()
        self:GetOwner():SetAnimation(PLAYER_ATTACK1)
        timer.Simple(0.3, function()
            if self:IsCurrentWeapon() then
                self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
                self:EmitSound(self.ShotgunPumpSound)
            end
        end)

        local bullet = {}
        bullet.Num = self.Secondary.NumberofShots
        bullet.Src = self:GetOwner():GetShootPos()
        bullet.Dir = self:GetOwner():GetAimVector()
        bullet.Spread = self.Secondary.Spread
        bullet.Tracer = self.Secondary.TracerAmount
        bullet.Force = self.Secondary.Force
        bullet.Damage = self.Secondary.Damage
        bullet.AmmoType = self.Primary.Ammo

        self:GetOwner():FireBullets(bullet)
    end
end

function SWEP:GenericReload()
    if (self:GetNextPrimaryFire() - CurTime() > 0.25) then return end

    self:DefaultReload(ACT_VM_RELOAD)
    if (self.ReloadSound != "" && self:Clip1() < self.Primary.ClipSize && self:Ammo1() > 0) then
        self:EmitSound(self.ReloadSound)
    end
end

function SWEP:ShotgunReload()
    if self:GetNWBool("reloading", false) then return end

    if (self:Clip1() < self.Primary.ClipSize && self:Ammo1() > 0) then
        self:SetNWBool("reloading", true)
        self:SetVar("reloadtimer", CurTime() + 0.2)
    end
end

function SWEP:BaseThink()
    local act = self:GetActivity()
    if (GetConVar("dwbext_autoreload"):GetBool() && act != ACT_VM_RELOAD && act != ACT_VM_SECONDARYATTACK && !self:GetNWBool("reloading", false) && self:GetOwner():Alive() && self:Clip1() <= 0 && self:Ammo1() > 0) then
        timer.Simple(0.45, function()
            if (self:IsCurrentWeapon() && self:GetActivity() != ACT_VM_RELOAD && !self:GetNWBool("reloading", false) && self:GetOwner():Alive()) then
                self:Reload()
            end
        end)
    end

    self.DrawCrosshair = GetConVar("dwbext_crosshair"):GetBool()
end

function SWEP:ShotgunThink()
    // bad and is buggy
    if self:GetNWBool("reloading", false) then
        if !self.StartReload then
            self.StartReload = true
            self.CanReload = false

            self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
            timer.Simple(0.3, function()
                if self:IsCurrentWeapon() then
                    self.CanReload = true
                end
            end)
        end

        if (self.CanReload && self:GetVar("reloadtimer", 0) < CurTime()) then
            if (self:Clip1() >= self.Primary.ClipSize || self:Ammo1() <= 0) then
                self:SetNWBool("reloading", false)
            return end

            self:SetVar("reloadtimer", CurTime() + 0.4)
            self:SendWeaponAnim(ACT_VM_RELOAD)
            self:EmitSound("weapons/shotgun/shotgun_reload" .. math.random( 1,2,3 ) .. ".wav")
            self:GetOwner():RemoveAmmo(1, self.Primary.Ammo)
            self:SetClip1(self:Clip1() + 1)

            if (self:Clip1() >= self.Primary.ClipSize || self:Ammo1() <= 0) then
                timer.Simple(0.6, function()
                    if (IsValid(self) && self:IsCurrentWeapon() && (self:Clip1() == self.Primary.ClipSize || self:Ammo1() <= 0)) then
                        self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
                        self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
                        self:SetNextSecondaryFire(CurTime() + self:SequenceDuration())
                    end
                end)
            end
        end
    end
end

function SWEP:Deploy()
    local vm = self:GetOwner():GetViewModel()
    local drawseq = vm:LookupSequence(self.WeaponDeploy.Sequence)

    vm:SendViewModelMatchingSequence(drawseq)
    vm:SetPlaybackRate(self.WeaponDeploy.Speed)

    self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration(drawseq))
    if (self.WeaponDeploy.Sound != "") then
        timer.Simple(self.WeaponDeploy.SoundDelay, function()
            if self:IsCurrentWeapon() then
                self:EmitSound(self.WeaponDeploy.Sound)
            end
        end)
    end

    return true
end