-- basiccube's Default Weapon Base Extension
-- Pistol template

AddCSLuaFile()

SWEP.PrintName = "DWBExt Pistol" -- Weapon name in spawn menu and in weapon selection HUD.
SWEP.Category = "Other" -- Spawn menu category.
SWEP.Spawnable = true -- Make the weapon appear in the spawn menu.
SWEP.AdminOnly = false -- Is the weapon spawnable only for admins?
SWEP.Base = "dwbext_base" -- The base the weapon uses. Do not change this!
SWEP.WeaponIcon = "weapons/swep" -- Weapon icon in HUD.

SWEP.WeaponType = "generic" -- Weapon type. Can be the following: generic, shotgun, melee.

-- Sound that plays when the weapon clip is empty.
SWEP.EmptySound = "Weapon_Pistol.Empty"
-- Reload sound if the viewmodel doesn't have one. Enable HasReloadSound for it to work.
SWEP.ReloadSound = "Weapon_Pistol.Reload"

SWEP.Primary.Damage = 4 -- How much damage the primary attack does.
SWEP.Primary.TakeAmmo = 1 -- How much ammo to take away when firing.
SWEP.Primary.ClipSize = 18 -- The clip size.
SWEP.Primary.Ammo = "Pistol" -- The ammo type the primary attack uses.
SWEP.Primary.DefaultClip = 18 -- The clip size the player starts with.
SWEP.Primary.Spread = Vector( 0.2 * 0.1 , 0.2 * 0.1, 0) -- The bullet spread.
SWEP.Primary.NumberofShots = 1 -- How many bullets does the weapon shoot?
SWEP.Primary.TracerAmount = 1 -- How many bullet tracers does the weapon make?
SWEP.Primary.Automatic = false -- Does the weapon automatically fire?
SWEP.Primary.Recoil = 0.5 -- Weapon recoil.
SWEP.Primary.Delay = 0.1 -- How long do you have to wait before you can shoot again?
SWEP.Primary.Force = 4 -- Bullet force.
SWEP.Primary.Sound = "Weapon_Pistol.Single" -- Weapon shoot sound.

-- The angle your view gets punched.
SWEP.Primary.ViewPunchAngle = Angle( -1.25,SWEP.Primary.Recoil * 1,SWEP.Primary.Recoil * -1 )

SWEP.ViewEyePunch = false -- Should your eye position move when firing?

SWEP.Slot = 1 -- Weapon slot. Can go from 0 to 5.
SWEP.SlotPos = 2 -- How far down is the weapon in that slot?
SWEP.DrawAmmo = true -- Draw the ammo counter?
SWEP.Weight = 5 -- The weight of the weapon.
SWEP.AutoSwitchTo = false -- Switch to this weapon if the player runs out of ammo on their current weapon or gets this weapon.
SWEP.AutoSwitchFrom = false -- Switch away from this weapon if the player runs out of ammo or gets another weapon.

SWEP.ViewModelFlip = false -- Flip the viewmodel.
SWEP.ViewModelFOV = 54 -- Viewmodel FOV.
SWEP.ViewModel = "models/weapons/v_pistol.mdl" -- Weapon viewmodel.
SWEP.WorldModel = "models/weapons/w_pistol.mdl" -- Weapon worldmodel.
SWEP.UseHands = false -- Use c_hands if the viewmodel supports it. Only works with c_ viewmodels, not v_ viewmodels!
SWEP.CSMuzzleFlashes = false -- Use CS:S muzzleflashes if the viewmodel is a CS:S viewmodel.

SWEP.DrawSequence = "draw" -- The animation to play when deploying/selecting the weapon.
SWEP.DrawPlaybackSpeed = 1 -- The speed to play the draw animation at.
SWEP.DrawSequenceLength = 0.7 -- How long does the animation need to play before being able to fire the weapon.

SWEP.HoldType = "pistol" -- Weapon hold type.

SWEP.FiresUnderwater = true -- Can this weapon be fired underwater?
