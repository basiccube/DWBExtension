-- basiccube's Default Weapon Base Extension
-- SMG template

SWEP.PrintName = "Weapon Base Extension SMG" -- Weapon name in spawn menu and in weapon selection HUD.
SWEP.Category = "Other" -- Spawn menu category.
SWEP.Spawnable = true -- Make the weapon appear in the spawn menu.
SWEP.AdminOnly = false -- Is the weapon spawnable only for admins?
SWEP.Base = "weapon_base_extension" -- The base the weapon uses. Do not change this!
SWEP.WeaponIcon = "weapons/swep" -- Weapon icon in HUD.

SWEP.WeaponType = "generic" -- Weapon type. Can be the following: generic, shotgun, melee.

-- Weapon shoot sounds.
SWEP.ShootSounds = {
    "weapons/smg1/smg1_fire1.wav"
}
-- Sound that plays when the weapon clip is empty.
SWEP.EmptySound = Sound("weapons/pistol/pistol_empty.wav")
-- Reload sound if the viewmodel doesn't have one. Enable HasReloadSound for it to work.
SWEP.ReloadSound = Sound("weapons/smg1/smg1_reload.wav")

SWEP.Primary.Damage = 3 -- How much damage the primary attack does.
SWEP.Primary.TakeAmmo = 1 -- How much ammo to take away when firing.
SWEP.Primary.ClipSize = 30 -- The clip size.
SWEP.Primary.Ammo = "SMG1" -- The ammo type the primary attack uses.
SWEP.Primary.DefaultClip = 30 -- The clip size the player starts with.
SWEP.Primary.Spread = Vector( 0.5 * 0.1 , 0.5 * 0.1, 0) -- The bullet spread.
SWEP.Primary.NumberofShots = 1 -- How many bullets does the weapon shoot?
SWEP.Primary.TracerAmount = 1 -- How many bullet tracers does the weapon make?
SWEP.Primary.Automatic = true -- Does the weapon automatically fire?
SWEP.Primary.Recoil = 0.2 -- Weapon recoil.
SWEP.Primary.Delay = 0.07 -- How long do you have to wait before you can shoot again?
SWEP.Primary.Force = 5 -- Bullet force.

-- The angle your view gets punched.
SWEP.Primary.ViewPunchAngle = Angle( SWEP.Primary.Recoil * -0.9,0,-0.05 )

SWEP.ViewEyePunch = false -- Should your eye position move when firing?

SWEP.Slot = 2 -- Weapon slot. Can go from 0 to 5.
SWEP.SlotPos = 1 -- How far down is the weapon in that slot?
SWEP.DrawCrosshair = true -- Draw the crosshair?
SWEP.DrawAmmo = true -- Draw the ammo counter?
SWEP.Weight = 5 -- The weight of the weapon.
SWEP.AutoSwitchTo = false -- Switch to this weapon if the player runs out of ammo on their current weapon or gets this weapon.
SWEP.AutoSwitchFrom = false -- Switch away from this weapon if the player runs out of ammo or gets another weapon.

SWEP.ViewModelFlip = false -- Flip the viewmodel.
SWEP.ViewModelFOV = 54 -- Viewmodel FOV.
SWEP.ViewModel = "models/weapons/v_smg1.mdl" -- Weapon viewmodel.
SWEP.WorldModel = "models/weapons/w_smg1.mdl" -- Weapon worldmodel.
SWEP.UseHands = false -- Use c_hands if the viewmodel supports it. Only works with c_ viewmodels, not v_ viewmodels!
SWEP.CSMuzzleFlashes = false -- Use CS:S muzzleflashes if the viewmodel is a CS:S viewmodel.

SWEP.DrawSequence = "draw" -- The animation to play when deploying/selecting the weapon.
SWEP.DrawPlaybackSpeed = 1 -- The speed to play the draw animation at.
SWEP.DrawSequenceLength = 0.7 -- How long does the animation need to play before being able to fire the weapon.

SWEP.HasReloadSound = true -- Does the weapon have a reload sound? Use this if the viewmodel doesn't have a reload sound.
SWEP.HasDeploySound = false -- Does the weapon have a deploy sound to play during the draw animation? 

SWEP.AutoReload = true -- Auto reload. Will be replaced with an option that can be toggled on or off by the user.

SWEP.HoldType = "smg" -- Weapon hold type.

SWEP.FiresUnderwater = false -- Can this weapon be fired underwater?
