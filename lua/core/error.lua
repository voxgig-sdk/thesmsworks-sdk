-- Thesmsworks SDK error

local ThesmsworksError = {}
ThesmsworksError.__index = ThesmsworksError


function ThesmsworksError.new(code, msg, ctx)
  local self = setmetatable({}, ThesmsworksError)
  self.is_sdk_error = true
  self.sdk = "Thesmsworks"
  self.code = code or ""
  self.msg = msg or ""
  self.ctx = ctx
  self.result = nil
  self.spec = nil
  return self
end


function ThesmsworksError:error()
  return self.msg
end


function ThesmsworksError:__tostring()
  return self.msg
end


return ThesmsworksError
