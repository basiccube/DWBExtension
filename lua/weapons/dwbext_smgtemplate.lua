// basiccube's Default Weapon Base Extension
// SMG template

AddCSLuaFile()

SWEP.PrintName = "DWBExt SMG"
SWEP.Category = "[DWBExt] Base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Base = "dwbext_base"
SWEP.WeaponIcon = "weapons/swep"

SWEP.ReloadSound = "Weapon_SMG1.Reload"

SWEP.Primary = {
    Damage = 3,
    Ammo = "SMG1",
    TakeAmmo = 1,

    ClipSize = 30,
    DefaultClip = 30,
    Automatic = true,
    Delay = 0.07,

    Spread = Vector(0.5 * 0.1, 0.5 * 0.1, 0),
    ViewPunchAngle = Angle(0.2 * -0.9, 0, -0.05),
    ViewPunchRandom = false,
    ViewPunchRandomMin = 0,
    ViewPunchRandomMax = 0,
    ViewEyePunch = false,

    NumberofShots = 1,
    TracerAmount = 1,
    Force = 5,
    Sound = "Weapon_SMG1.Single",
}

SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.DrawAmmo = true
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/v_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.UseHands = false
SWEP.CSMuzzleFlashes = false

SWEP.WeaponDeploy = {
    Sequence = "draw",
    Speed = 1,

    Sound = "",
    SoundDelay = 0.5,
}

SWEP.HoldType = "smg"

SWEP.FiresUnderwater = false

function SWEP:PrimaryAttack()
    self:PrimaryAttackGeneric()
end

function SWEP:Reload()
    self:GenericReload()
end

function SWEP:Think()
    self:BaseThink()
end