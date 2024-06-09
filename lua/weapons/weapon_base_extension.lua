-- basiccube's Default Weapon Base Extension
-- Version 0.2.10

SWEP.PrintName = "Default Weapon Base Extension"
SWEP.Category = "Other"
SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false
SWEP.Spawnable = false
SWEP.AdminOnly = false
SWEP.Base = "weapon_base"
SWEP.WeaponIcon = "weapons/swep"

SWEP.WeaponType = "generic"

SWEP.ShootSound = Sound("weapons/pistol/pistol_fire2.wav")
SWEP.ShootSound2 = Sound("weapons/pistol/pistol_fire3.wav")
SWEP.EmptySound = Sound("weapons/pistol/pistol_empty.wav")
SWEP.ReloadSound = Sound("weapons/pistol/pistol_reload1.wav")
SWEP.DeploySound = Sound("common/null.wav")
SWEP.ShotgunPumpSound = Sound("weapons/shotgun/shotgun_cock.wav", 75, 100, 1, CHAN_ITEM)
SWEP.ShotgunSecondarySound = Sound("weapons/shotgun/shotgun_dbl_fire7.wav")

SWEP.MeleeSwingSound = Sound("weapons/iceaxe/iceaxe_swing1.wav")
SWEP.MeleeHitSound = Sound("physics/flesh/flesh_impact_bullet1.wav")
SWEP.MeleeHitSound2 = Sound("physics/flesh/flesh_impact_bullet2.wav")
SWEP.MeleeHitSound3 = Sound("physics/flesh/flesh_impact_bullet3.wav")
SWEP.MeleeHitSound4 = Sound("physics/flesh/flesh_impact_bullet4.wav")
SWEP.MeleeHitSound5 = Sound("physics/flesh/flesh_impact_bullet5.wav")

SWEP.Primary.Damage = 14
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 20
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Spread = Vector( 0.1 * 0.1 , 0.1 * 0.1, 0)
SWEP.Primary.NumberofShots = 1
SWEP.Primary.TracerAmount = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 0.5
SWEP.Primary.ShotgunRecoil = -1.85
SWEP.Primary.Delay = 0.1
SWEP.Primary.Force = 5
SWEP.Primary.MeleeDistance = 80

SWEP.Primary.ViewPunchAngle = Angle( SWEP.Primary.Recoil * math.random(-0.5,-2),0,0 )

SWEP.ViewEyePunch = true

SWEP.Secondary.Damage = 10
SWEP.Secondary.TakeAmmo = 2
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Spread = Vector( 0.1 * 0.1 , 0.1 * 0.1, 0)
SWEP.Secondary.NumberofShots = 12
SWEP.Secondary.TracerAmount = 1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Recoil = .5
SWEP.Secondary.ShotgunRecoil = -3.25
SWEP.Secondary.Delay = 1.0
SWEP.Secondary.Force = 2

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

SWEP.DrawSequence = "draw"
SWEP.DrawPlaybackSpeed = 1
SWEP.DrawSequenceLength = 1
SWEP.DeploySoundDelay = 0.5

SWEP.HasReloadSound = true
SWEP.HasDeploySound = false
SWEP.MultipleShootSounds = false

-- TODO: Add settings
SWEP.AutoReload = true

SWEP.MeleeMissToIdleAnim = false

SWEP.HoldType = "pistol"

SWEP.FiresUnderwater = false

function SWEP:Initialize()
    self:SetWeaponHoldType( self.HoldType )
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
    if ( !self:CanPrimaryAttack() ) then return end

    if (self.FiresUnderwater == false && self:GetOwner():WaterLevel() == 3) then
        self:EmitSound(self.EmptySound, 75, 100)
        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
        return
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

    self:ShootEffects()

    local ShootSoundRandom = math.random(1,2)

    self:GetOwner():FireBullets( bullet )
    if (self.MultipleShootSounds == true) then
        if (ShootSoundRandom == 1) then
            self:EmitSound(self.ShootSound)
        elseif (ShootSoundRandom == 2) then
            self:EmitSound(self.ShootSound2)
        end
    else
        self:EmitSound(self.ShootSound)
    end

    if (!self:GetOwner():IsNPC()) then
        self:GetOwner():ViewPunch(self.Primary.ViewPunchAngle)
        if (self.ViewEyePunch == true) then
            local ViewEyes = self:GetOwner():EyeAngles()
            ViewEyes.Pitch = ViewEyes.Pitch + self.Primary.ViewPunchAngle.Pitch
            ViewEyes.Yaw = ViewEyes.Yaw + self.Primary.ViewPunchAngle.Yaw
            self:GetOwner():SetEyeAngles(ViewEyes)
        end
    end

    self:TakePrimaryAmmo(self.Primary.TakeAmmo)
    self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
end

function SWEP:PrimaryAttackShotgun()
    if (!self:CanPrimaryAttack()) then return end

    if (self:Clip1() > 0) && (!(self:GetOwner():KeyDown(IN_ATTACK2))) then
        self:EmitSound(self.ShootSound)
        self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
        self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
        self:TakePrimaryAmmo(self.Primary.TakeAmmo)
        self.StartReload = false
        self:SetNWBool("reloading",false)

        self:ShootEffects()
        timer.Simple( 0.3, function() self:SendWeaponAnim(ACT_SHOTGUN_PUMP) end )
        timer.Simple( 0.3, function() self:EmitSound(self.ShotgunPumpSound) end )

        local rnda = self.Primary.Recoil * -1
        local rndb = self.Primary.Recoil * math.random(-2, 2)
        if !self:GetOwner():IsNPC() then
            self:GetOwner():ViewPunch( Angle( self.Primary.ShotgunRecoil,rndb,rnda ) )
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

        self:GetOwner():FireBullets( bullet )
    end
end

function SWEP:PrimaryAttackMelee()
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    local trace = self:GetOwner():GetEyeTrace()
    if trace.HitPos:Distance(self:GetOwner():GetShootPos()) <= self.Primary.MeleeDistance then
        self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
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
        local HitSoundRandom = math.random(1,2,3,4,5)
        if (HitSoundRandom == 1) then
            self:EmitSound(self.MeleeHitSound)
        elseif (HitSoundRandom == 2) then
            self:EmitSound(self.MeleeHitSound2)
        elseif (HitSoundRandom == 3) then
            self:EmitSound(self.MeleeHitSound3)
        elseif (HitSoundRandom == 4) then
            self:EmitSound(self.MeleeHitSound4)
        elseif (HitSoundRandom == 5) then
            self:EmitSound(self.MeleeHitSound5)
        end
        self:EmitSound(self.MeleeSwingSound)
        if !self:GetOwner():IsNPC() then
            self:GetOwner():ViewPunch( self.Primary.ViewPunchAngle )
        end
    else
        self:EmitSound(self.MeleeSwingSound)
        self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
        self:SendWeaponAnim(ACT_VM_MISSCENTER)
        if (self.MeleeMissToIdleAnim == true) then
            timer.Simple( 0.4, function() self:SendWeaponAnim(ACT_VM_IDLE) end )
        end
    end
end

function SWEP:SecondaryAttack()
    if (self.WeaponType == "shotgun") then
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

    if (self:Clip1() == 1) && (self:Clip1() > 0) && (!(self:GetOwner():KeyDown(IN_ATTACK))) then
        self:EmitSound(self.ShootSound)
        self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
        self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
        self:TakePrimaryAmmo(self.Primary.TakeAmmo)
        self.StartReload = false
        self:SetNWBool("reloading",false)

        self:ShootEffects()
        timer.Simple( 0.3, function() self:SendWeaponAnim(ACT_SHOTGUN_PUMP) end )
        timer.Simple( 0.3, function() self:EmitSound(self.ShotgunPumpSound) end )

        local rnda = self.Primary.Recoil * -1
        local rndb = self.Primary.Recoil * math.random(-2, 2)
        if !self:GetOwner():IsNPC() then
            self:GetOwner():ViewPunch( Angle( self.Primary.ShotgunRecoil,rndb,rnda ) )
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

        self:GetOwner():FireBullets( bullet )
    end
    if (self:Clip1() > 0) && (!(self:GetOwner():KeyDown(IN_ATTACK))) then
        self:EmitSound(self.ShotgunSecondarySound)
        self:SetNextPrimaryFire(CurTime() + self.Secondary.Delay)
        self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
        self:TakePrimaryAmmo(self.Secondary.TakeAmmo)
        self.StartReload = false
        self:SetNWBool("reloading",false)

        self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
        self:GetOwner():MuzzleFlash()
        self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
        timer.Simple( 0.3, function() self:SendWeaponAnim(ACT_SHOTGUN_PUMP) end )
        timer.Simple( 0.3, function() self:EmitSound(self.ShotgunPumpSound) end )

        local rnda = self.Secondary.Recoil * -1
        local rndb = self.Secondary.Recoil * math.random(-1, 1)
        if !self:GetOwner():IsNPC() then
            self:GetOwner():ViewPunch( Angle( self.Secondary.ShotgunRecoil,rndb,rnda ) )
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

        self:GetOwner():FireBullets( bullet )
    end
end

function SWEP:Reload()
    if (self.WeaponType == "generic" && self.HasReloadSound == true && self:Clip1() <= self.Primary.ClipSize - 1 && self:Ammo1() >= 1) then
        self:EmitSound(Sound(self.ReloadSound))
    end
    if (self.WeaponType == "generic") then
        self:DefaultReload( ACT_VM_RELOAD );
    end
    if (self.WeaponType == "shotgun") then
        if (self:GetNWBool("reloading",false)) then return end
        if (self:Clip1() <= self.Primary.ClipSize - 1 && self:Ammo1() >= 1) then
            self:SetNWBool("reloading",true)
            self:SetVar("reloadtimer",CurTime() + 0.2)
        end
    end
end

function SWEP:Think()
    if (self.WeaponType == "shotgun" && self:GetNWBool("reloading",false)) then
        if self.StartReload == false then
            self.StartReload = true
            self.CanReload = false
            self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
            timer.Simple(0.3,function()
                self.CanReload = true
            end)
        end
        if self.CanReload == true && (self:GetVar("reloadtimer",0) < CurTime()) then
            if (self:Clip1() >= self.Primary.ClipSize || self:Ammo1() <= 0) then
                self:SetNWBool("reloading",false)
                return
            end
            self:SetVar("reloadtimer",CurTime() + 0.4)
            self:SendWeaponAnim(ACT_VM_RELOAD)
            self:EmitSound("weapons/shotgun/shotgun_reload" .. math.random( 1,2,3 ) .. ".wav")
            self:GetOwner():RemoveAmmo(1,self.Primary.Ammo,false)
            self:SetClip1(self:Clip1() + 1)
            if (self:Clip1() >= self.Primary.ClipSize || self:Ammo1() <= 0) then
                timer.Simple(0.6, function()
                    if (IsValid(self) && self:Clip1() == self.Primary.ClipSize || self:Ammo1() <= 0) then
                        self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
                        self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
                        self:SetNextSecondaryFire(CurTime() + self:SequenceDuration())
                    end
                end)
            end
        end
    end
    if (self.WeaponType == "generic" && self.AutoReload && self:GetOwner():Alive() && self:Clip1() <= 0 && self:Ammo1() > 0) then
        self:Reload()
    end
end

function SWEP:Deploy()
    local vm = self:GetOwner():GetViewModel()
    vm:SendViewModelMatchingSequence( vm:LookupSequence( self.DrawSequence ) )
    vm:SetPlaybackRate( self.DrawPlaybackSpeed )
    self:SetNextPrimaryFire(CurTime() + self.DrawSequenceLength)
    if (self.HasDeploySound == true) then
        timer.Simple( self.DeploySoundDelay, function() self:EmitSound(Sound(self.DeploySound)) end)
    end
end