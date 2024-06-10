-- basiccube's Default Weapon Base Extension

AddCSLuaFile()

function SWEP:EmitPrimarySound()
    self:EmitSound(self.Primary.Sound)
end

function SWEP:IsCurrentWeapon()
    if (self:GetOwner():GetActiveWeapon():GetClass() == self:GetClass()) then
        return true
    end
    return false
end