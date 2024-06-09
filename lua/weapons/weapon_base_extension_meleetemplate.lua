-- basiccube's Default Weapon Base Extension
-- Melee weapon template

SWEP.PrintName = "Weapon Base Extension Melee Weapon" -- Weapon name in spawn menu and in weapon selection HUD.
SWEP.Category = "Other" -- Spawn menu category.
SWEP.Spawnable = true -- Make the weapon appear in the spawn menu.
SWEP.AdminOnly = false -- Is the weapon spawnable only for admins?
SWEP.Base = "weapon_base_extension" -- The base the weapon uses. Do not change this!
SWEP.WeaponIcon = "weapons/swep" -- Weapon icon in HUD.

SWEP.WeaponType = "melee" -- Weapon type. Can be the following: generic, shotgun, melee.

SWEP.MeleeSwingSound = Sound("weapons/iceaxe/iceaxe_swing1.wav")
SWEP.MeleeHitSound = Sound("physics/flesh/flesh_impact_bullet1.wav")
SWEP.MeleeHitSound2 = Sound("physics/flesh/flesh_impact_bullet2.wav")
SWEP.MeleeHitSound3 = Sound("physics/flesh/flesh_impact_bullet3.wav")
SWEP.MeleeHitSound4 = Sound("physics/flesh/flesh_impact_bullet4.wav")
SWEP.MeleeHitSound5 = Sound("physics/flesh/flesh_impact_bullet5.wav")

SWEP.Primary.Damage = 12 -- How much damage the primary attack does.
SWEP.Primary.ClipSize = -1 -- Not used by melee weapon
SWEP.Primary.Ammo = "none" -- Not used by melee weapon
SWEP.Primary.DefaultClip = -1 -- Not used by melee weapon
SWEP.Primary.Automatic = true -- Can you swing without having to press the primary attack again?
SWEP.Primary.Delay = 0.4 -- How long do you have to wait before you can swing again?
SWEP.Primary.Force = 1 -- The force of the swing.
SWEP.Primary.MeleeDistance = 80 -- The max distance you can swing.

-- The angle your view gets punched.
SWEP.Primary.ViewPunchAngle = Angle( 1.0 * math.random(-0.5, -1.5),0,0 )

SWEP.Slot = 0 -- Weapon slot. Can go from 0 to 5.
SWEP.SlotPos = 2 -- How far down is the weapon in that slot?
SWEP.DrawCrosshair = true -- Draw the crosshair?
SWEP.DrawAmmo = false -- Not used by melee weapon
SWEP.Weight = 5 -- The weight of the weapon.

SWEP.ViewModelFlip = false -- Flip the viewmodel.
SWEP.ViewModelFOV = 54 -- Viewmodel FOV.
SWEP.ViewModel = "models/weapons/v_crowbar.mdl" -- Weapon viewmodel.
SWEP.WorldModel = "models/weapons/w_crowbar.mdl" -- Weapon worldmodel.
SWEP.UseHands = false -- Use c_hands if the viewmodel supports it. Only works with c_ viewmodels, not v_ viewmodels!

SWEP.DrawSequence = "draw" -- The animation to play when deploying/selecting the weapon.
SWEP.DrawPlaybackSpeed = 1 -- The speed to play the draw animation at.
SWEP.DrawSequenceLength = 0.7 -- How long does the animation need to play before being able to swing.

SWEP.HasDeploySound = false -- Does the weapon have a deploy sound to play during the draw animation? 

SWEP.MeleeMissToIdleAnim = false -- Experimental. Moves the weapon back to its idle position after a miss.
                                 -- Used by melee weapons that use HL2 crowbar animations.
                                 -- Will cause issues when switching to another weapon after a swing.

SWEP.HoldType = "melee" -- Weapon hold type.
