-- basiccube's Default Weapon Base Extension
-- Shotgun template

AddCSLuaFile()

SWEP.PrintName = "DWBExt Shotgun" -- Weapon name in spawn menu and in weapon selection HUD.
SWEP.Category = "Other" -- Spawn menu category.
SWEP.Spawnable = true -- Make the weapon appear in the spawn menu.
SWEP.AdminOnly = false -- Is the weapon spawnable only for admins?
SWEP.Base = "dwbext_base" -- The base the weapon uses. Do not change this!
SWEP.WeaponIcon = "weapons/swep" -- Weapon icon in HUD.

SWEP.WeaponType = "shotgun" -- Weapon type. Can be the following: generic, shotgun, melee.

-- Sound that plays when the weapon clip is empty.
SWEP.EmptySound = "Weapon_Shotgun.Empty"
-- Shotgun pump sound.
SWEP.ShotgunPumpSound = "Weapon_Shotgun.Special1"

SWEP.Primary.Damage = 10 -- How much damage the primary attack does.
SWEP.Primary.TakeAmmo = 1 -- How much ammo to take away when firing.
SWEP.Primary.ClipSize = 6 -- The clip size.
SWEP.Primary.Ammo = "Buckshot" -- The ammo type the primary attack uses.
SWEP.Primary.DefaultClip = 6 -- The clip size the player starts with.
SWEP.Primary.Spread = Vector( 0.8 * 0.1 , 0.8 * 0.1, 0) -- The bullet spread.
SWEP.Primary.NumberofShots = 6 -- How many bullets does the weapon shoot?
SWEP.Primary.TracerAmount = 6 -- How many bullet tracers does the weapon make?
SWEP.Primary.Automatic = true -- Does the weapon automatically fire?
SWEP.Primary.Recoil = 0.5 -- Weapon recoil. Due to current shotgun code, it is seperate from ShotgunRecoil.
SWEP.Primary.ShotgunRecoil = -1.85 -- Shotgun WeaponType recoil. Different from Primary.Recoil because weird coding.
SWEP.Primary.Delay = 0.85 -- How long do you have to wait before you can shoot again?
SWEP.Primary.Force = 2 -- Bullet force.
SWEP.Primary.Sound = "Weapon_Shotgun.Single" -- Weapon shoot sound.

SWEP.Secondary.Damage = 10
SWEP.Secondary.TakeAmmo = 2
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Spread = Vector( 0.8 * 0.1 , 0.8 * 0.1, 0)
SWEP.Secondary.NumberofShots = 12
SWEP.Secondary.TracerAmount = 12
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Recoil = .5
SWEP.Secondary.ShotgunRecoil = -3.25
SWEP.Secondary.Delay = 1.0
SWEP.Secondary.Force = 2
SWEP.Secondary.Sound = "Weapon_Shotgun.Double"

SWEP.Slot = 2 -- Weapon slot. Can go from 0 to 5.
SWEP.SlotPos = 3 -- How far down is the weapon in that slot?
SWEP.DrawAmmo = true -- Draw the ammo counter?
SWEP.Weight = 10 -- The weight of the weapon.
SWEP.AutoSwitchTo = false -- Switch to this weapon if the player runs out of ammo on their current weapon or gets this weapon.
SWEP.AutoSwitchFrom = false -- Switch away from this weapon if the player runs out of ammo or gets another weapon.

SWEP.ViewModelFlip = false -- Flip the viewmodel.
SWEP.ViewModelFOV = 54 -- Viewmodel FOV.
SWEP.ViewModel = "models/weapons/v_shotgun.mdl" -- Weapon viewmodel.
SWEP.WorldModel = "models/weapons/w_shotgun.mdl" -- Weapon worldmodel.
SWEP.UseHands = false -- Use c_hands if the viewmodel supports it. Only works with c_ viewmodels, not v_ viewmodels!
SWEP.CSMuzzleFlashes = false -- Use CS:S muzzleflashes if the viewmodel is a CS:S viewmodel.

SWEP.DrawSequence = "draw" -- The animation to play when deploying/selecting the weapon.
SWEP.DrawPlaybackSpeed = 1 -- The speed to play the draw animation at.
SWEP.DrawSequenceLength = 0.6 -- How long does the animation need to play before being able to fire the weapon.

SWEP.HoldType = "shotgun" -- Weapon hold type.

SWEP.FiresUnderwater = false -- Can this weapon be fired underwater?
