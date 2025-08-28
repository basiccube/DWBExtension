// basiccube's Default Weapon Base Extension

AddCSLuaFile()

function SWEP:IsCurrentWeapon()
    return self:GetOwner():GetActiveWeapon():GetClass() == self:GetClass()
end