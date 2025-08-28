// basiccube's Default Weapon Base Extension
// Shotgun template

AddCSLuaFile()

SWEP.PrintName = "DWBExt Shotgun"
SWEP.Category = "DWBExt: Base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Base = "dwbext_base"
SWEP.WeaponIcon = "weapons/swep"

SWEP.ShotgunPumpSound = "Weapon_Shotgun.Special1"

SWEP.Primary = {
    Damage = 10,
    Ammo = "Buckshot",
    TakeAmmo = 1,

    ClipSize = 6,
    DefaultClip = 6,
    Automatic = true,
    Delay = 0.85,

    Spread = Vector(0.8 * 0.1, 0.8 * 0.1, 0),
    ViewPunchAngle = Angle(-1.85, 1, -0.5),
    ViewPunchRandom = false,
    ViewPunchRandomMin = 0,
    ViewPunchRandomMax = 0,
    ViewEyePunch = true,

    NumberofShots = 6,
    TracerAmount = 6,
    Force = 2,
    Sound = "Weapon_Shotgun.Single",
}

SWEP.Secondary = {
    Damage = 10,
    Ammo = "none",
    TakeAmmo = 2,

    ClipSize = -1,
    DefaultClip = -1,
    Automatic = true,
    Delay = 1.0,

    Spread = Vector(0.8 * 0.1, 0.8 * 0.1, 0),
    ViewPunchAngle = Angle(-3.25, 0.5, -0.5),
    ViewPunchRandom = false,
    ViewPunchRandomMin = 0,
    ViewPunchRandomMax = 0,
    ViewEyePunch = true,

    NumberofShots = 12,
    TracerAmount = 12,
    Force = 2,
    Sound = "Weapon_Shotgun.Double",
}

SWEP.Slot = 2
SWEP.SlotPos = 3
SWEP.DrawAmmo = true
SWEP.Weight = 10
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/v_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.UseHands = false
SWEP.CSMuzzleFlashes = false

SWEP.WeaponDeploy = {
    Sequence = "draw",
    Speed = 1,

    Sound = "",
    SoundDelay = 0.5,
}

SWEP.HoldType = "shotgun"

SWEP.FiresUnderwater = false

function SWEP:PrimaryAttack()
    self:PrimaryAttackShotgun()
end

function SWEP:SecondaryAttack()
    self:ShotgunDoubleAttack()
end

function SWEP:Reload()
    self:ShotgunReload()
end

function SWEP:Think()
    self:ShotgunThink()
    self:BaseThink()
end