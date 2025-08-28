// basiccube's Default Weapon Base Extension
// Pistol template

AddCSLuaFile()

SWEP.PrintName = "DWBExt Pistol"
SWEP.Category = "DWBExt: Base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Base = "dwbext_base"
SWEP.WeaponIcon = "weapons/swep"

SWEP.ReloadSound = "Weapon_Pistol.Reload"

SWEP.Primary = {
    Damage = 4,
    Ammo = "Pistol",
    TakeAmmo = 1,

    ClipSize = 18,
    DefaultClip = 18,
    Automatic = false,
    Delay = 0.1,

    Spread = Vector(0.2 * 0.1, 0.2 * 0.1, 0),
    ViewPunchAngle = Angle(-1.25, 0.1, -0.25),
    ViewPunchRandom = true,
    ViewPunchRandomMin = 0.5,
    ViewPunchRandomMax = 1,
    ViewEyePunch = false,

    NumberofShots = 1,
    TracerAmount = 1,
    Force = 4,
    Sound = "Weapon_Pistol.Single",
}

SWEP.Slot = 1
SWEP.SlotPos = 2
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

SWEP.HoldType = "pistol"

SWEP.FiresUnderwater = true

function SWEP:PrimaryAttack()
    self:PrimaryAttackGeneric()
end

function SWEP:Reload()
    self:GenericReload()
end

function SWEP:Think()
    self:BaseThink()
end