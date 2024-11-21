-- basiccube's Default Weapon Base Extension

AddCSLuaFile()

SWEP.PrintName = "Default Weapon Base Extension"
SWEP.Category = "[DWBExt] Base"
SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false
SWEP.Spawnable = false
SWEP.AdminOnly = false
SWEP.Base = "weapon_base"
SWEP.WeaponIcon = "weapons/swep"

SWEP.WeaponType = "generic"

SWEP.ReloadSound = ""
SWEP.ShotgunPumpSound = ""

SWEP.Primary.Damage = 14
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = -1
SWEP.Primary.Ammo = "none"
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Spread = Vector(0.1 * 0.1, 0.1 * 0.1, 0)
SWEP.Primary.NumberofShots = 1
SWEP.Primary.TracerAmount = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 0.5
SWEP.Primary.ShotgunRecoil = -1.85
SWEP.Primary.Delay = 0.1
SWEP.Primary.Force = 5
SWEP.Primary.MeleeDistance = 80
SWEP.Primary.Sound = ""
SWEP.Primary.ViewPunchAngle = Angle(SWEP.Primary.Recoil * math.random(-0.5, -2), 0, 0)

SWEP.ViewEyePunch = true

SWEP.Secondary.Damage = 10
SWEP.Secondary.TakeAmmo = 2
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Spread = Vector(0.1 * 0.1, 0.1 * 0.1, 0)
SWEP.Secondary.NumberofShots = 12
SWEP.Secondary.TracerAmount = 1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Recoil = .5
SWEP.Secondary.ShotgunRecoil = -3.25
SWEP.Secondary.Delay = 1.0
SWEP.Secondary.Force = 2
SWEP.Secondary.Sound = ""
SWEP.Secondary.ShotgunDouble = false

SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.DrawCrosshair = true
SWEP.DrawAmmo = true
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
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

function SWEP:Initialize()
    self:SetWeaponHoldType(self.HoldType)
    if CLIENT then
        self.WepSelectIcon = surface.GetTextureID(self.WeaponIcon)
    end
end

function SWEP:PrimaryAttack()
    if (self.WeaponType == "generic") then
        self:PrimaryAttackGeneric()
    elseif (self.WeaponType == "shotgun") then
        self:PrimaryAttackShotgun()
    elseif (self.WeaponType == "melee") then
        self:PrimaryAttackMelee()
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
    self:EmitPrimarySound()

    if !self:GetOwner():IsNPC() then
        self:GetOwner():ViewPunch(self.Primary.ViewPunchAngle)
        if self.ViewEyePunch then
            local ViewEyes = self:GetOwner():EyeAngles()
            ViewEyes.Pitch = ViewEyes.Pitch + self.Primary.ViewPunchAngle.Pitch
            ViewEyes.Yaw = ViewEyes.Yaw + self.Primary.ViewPunchAngle.Yaw
			
            self:GetOwner():SetEyeAngles(ViewEyes)
        end
    end

    self:TakePrimaryAmmo(self.Primary.TakeAmmo)
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
end

function SWEP:PrimaryAttackShotgun(secondary)
    secondary = secondary || false
    if !self:CanPrimaryAttack() then return end

    if (self:Clip1() > 0 && (!self:GetOwner():KeyDown(IN_ATTACK2) || secondary)) then
        self:EmitPrimarySound()
        self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
        self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
        self:TakePrimaryAmmo(self.Primary.TakeAmmo)
        self.StartReload = false
        self:SetNWBool("reloading", false)

        self:ShootEffects()
        timer.Simple(0.3, function()
            if self:IsCurrentWeapon() then
                self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
            end
        end)
        timer.Simple(0.3, function()
            if self:IsCurrentWeapon() then
                self:EmitSound(self.ShotgunPumpSound)
            end
        end)

        local rnda = self.Primary.Recoil * -1
        local rndb = self.Primary.Recoil * math.random(-2, 2)
        if !self:GetOwner():IsNPC() then
            self:GetOwner():ViewPunch(Angle(self.Primary.ShotgunRecoil, rndb, rnda))
        end

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

    if trace.HitPos:Distance(self:GetOwner():GetShootPos()) <= self.Primary.MeleeDistance then
        self:GetOwner():SetAnimation(PLAYER_ATTACK1)
        self:SendWeaponAnim(ACT_VM_HITCENTER)

        local bullet = {}
        bullet.Num = 1
        bullet.Src = self:GetOwner():GetShootPos()
        bullet.Dir = self:GetOwner():GetAimVector()
        bullet.Spread = Vector(0, 0, 0)
        bullet.Tracer = 0
        bullet.Force  = self.Primary.Force
        bullet.Damage = self.Primary.Damage
        self:GetOwner():FireBullets(bullet)

        self:EmitSound("Weapon_Crowbar.Melee_Hit")
        self:EmitPrimarySound()

        if !self:GetOwner():IsNPC() then
            self:GetOwner():ViewPunch(self.Primary.ViewPunchAngle)
        end
    else
        self:EmitPrimarySound()

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

function SWEP:SecondaryAttack()
    if (self.WeaponType == "shotgun" && self.Secondary.ShotgunDouble) then
        self:SecondaryAttackShotgun()
    end
end

function SWEP:SecondaryAttackShotgun()
    if (self:Clip1() == 0) then
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
        self:GetOwner():MuzzleFlash()
        self:GetOwner():SetAnimation(PLAYER_ATTACK1)
        timer.Simple(0.3, function()
            if self:IsCurrentWeapon() then
                self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
            end
        end)
        timer.Simple(0.3, function()
            if self:IsCurrentWeapon() then
                self:EmitSound(self.ShotgunPumpSound)
            end
        end)

        local rnda = self.Secondary.Recoil * -1
        local rndb = self.Secondary.Recoil * math.random(-1, 1)
        if !self:GetOwner():IsNPC() then
            self:GetOwner():ViewPunch(Angle(self.Secondary.ShotgunRecoil, rndb, rnda))
        end

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

function SWEP:Reload()
    if (self.WeaponType == "generic") then
        self:DefaultReload(ACT_VM_RELOAD)

        if (self.ReloadSound != "" && self:Clip1() < self.Primary.ClipSize && self:Ammo1() > 0) then
            self:EmitSound(self.ReloadSound)
        end
    end

    if (self.WeaponType == "shotgun") then
        if self:GetNWBool("reloading", false) then return end

        if (self:Clip1() < self.Primary.ClipSize && self:Ammo1() > 0) then
            self:SetNWBool("reloading", true)
            self:SetVar("reloadtimer", CurTime() + 0.2)
        end
    end
end

function SWEP:Think()
    if (self.WeaponType == "shotgun" && self:GetNWBool("reloading", false)) then
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

    if (self.WeaponType == "generic" && self:GetActivity() != ACT_VM_RELOAD && GetConVar("dwbext_autoreload"):GetBool() && self:GetOwner():Alive() && self:Clip1() <= 0 && self:Ammo1() > 0) then
        self:Reload()
    end

    self.DrawCrosshair = GetConVar("dwbext_crosshair"):GetBool()
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