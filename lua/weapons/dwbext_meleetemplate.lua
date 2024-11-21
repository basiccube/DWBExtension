-- basiccube's Default Weapon Base Extension
-- Melee weapon template

AddCSLuaFile()

SWEP.PrintName = "DWBExt Melee" -- Weapon name in spawn menu and in weapon selection HUD.
SWEP.Category = "[DWBExt] Base" -- Spawn menu category.
SWEP.Spawnable = true -- Make the weapon appear in the spawn menu.
SWEP.AdminOnly = false -- Is the weapon spawnable only for admins?
SWEP.Base = "dwbext_base" -- The base the weapon uses. Do not change this!
SWEP.WeaponIcon = "weapons/swep" -- Weapon icon in HUD.

SWEP.WeaponType = "melee" -- Weapon type. Can be the following: generic, shotgun, melee.

SWEP.Primary.Damage = 12 -- How much damage the primary attack does.
SWEP.Primary.Automatic = true -- Can you swing without having to press the primary attack again?
SWEP.Primary.Delay = 0.4 -- How long do you have to wait before you can swing again?
SWEP.Primary.Force = 1 -- The force of the swing.
SWEP.Primary.MeleeDistance = 80 -- The max distance you can swing.
SWEP.Primary.Sound = "Weapon_Crowbar.Single"

-- The angle your view gets punched.
SWEP.Primary.ViewPunchAngle = Angle(1.0 * math.random(-0.5, -1.5), 0, 0)

SWEP.Slot = 0 -- Weapon slot. Can go from 0 to 5.
SWEP.SlotPos = 2 -- How far down is the weapon in that slot?
SWEP.DrawAmmo = false -- Not used by melee weapon
SWEP.Weight = 5 -- The weight of the weapon.

SWEP.ViewModelFlip = false -- Flip the viewmodel.
SWEP.ViewModelFOV = 54 -- Viewmodel FOV.
SWEP.ViewModel = "models/weapons/v_crowbar.mdl" -- Weapon viewmodel.
SWEP.WorldModel = "models/weapons/w_crowbar.mdl" -- Weapon worldmodel.
SWEP.UseHands = false -- Use c_hands if the viewmodel supports it. Only works with c_ viewmodels, not v_ viewmodels!

SWEP.WeaponDeploy = {
    Sequence = "draw",
    Speed = 1,

    Sound = "",
    SoundDelay = 0.5,
}

SWEP.MeleeMissToIdleAnim = true -- Moves the weapon back to its idle position after a miss.
                                -- Used by melee weapons that use HL2 crowbar animations.

SWEP.HoldType = "melee" -- Weapon hold type.
