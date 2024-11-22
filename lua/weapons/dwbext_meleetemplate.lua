// basiccube's Default Weapon Base Extension
// Melee weapon template

AddCSLuaFile()

SWEP.PrintName = "DWBExt Melee"
SWEP.Category = "[DWBExt] Base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Base = "dwbext_base"
SWEP.WeaponIcon = "weapons/swep"

SWEP.Primary = {
    Damage = 12,
    Automatic = true,
    Delay = 0.4,

    ViewPunchAngle = Angle(1.0, 0, 0),
    ViewPunchRandom = true,
    ViewPunchRandomMin = -0.5,
    ViewPunchRandomMax = -1.5,

    Force = 1,
    MeleeDistance = 80,
    Sound = "Weapon_Crowbar.Single",
}

SWEP.Slot = 0
SWEP.SlotPos = 2
SWEP.DrawAmmo = false
SWEP.Weight = 5

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = false

SWEP.WeaponDeploy = {
    Sequence = "draw",
    Speed = 1,

    Sound = "",
    SoundDelay = 0.5,
}

SWEP.MeleeMissToIdleAnim = true

SWEP.HoldType = "melee"

function SWEP:PrimaryAttack()
    self:PrimaryAttackMelee()
end

function SWEP:Think()
    self:BaseThink()
end