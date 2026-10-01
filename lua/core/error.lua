-- Thesmsworks SDK error

local json = require("dkjson")

local ThesmsworksError = {}
ThesmsworksError.__index = ThesmsworksError

-- Reachable for a debugger, absent from the table itself: the context holds
-- the live spec and options, and an error is what gets dumped or encoded.
local CONTEXT = setmetatable({}, { __mode = "k" })


function ThesmsworksError.new(code, msg, ctx)
  local self = setmetatable({}, ThesmsworksError)
  self.is_sdk_error = true
  self.sdk = "Thesmsworks"
  self.code = code or ""
  self.msg = msg or ""
  self.result = nil
  self.spec = nil
  CONTEXT[self] = ctx
  return self
end


function ThesmsworksError:context()
  return CONTEXT[self]
end


function ThesmsworksError:error()
  return self.msg
end


-- What make_error attached is already cleaned; the context is not part of
-- the record.
function ThesmsworksError:to_table()
  return {
    sdk = self.sdk,
    code = self.code,
    msg = self.msg,
    status = self.status,
    result = self.result,
    spec = self.spec,
  }
end


function ThesmsworksError:to_json()
  return json.encode(self:to_table())
end


function ThesmsworksError:__tostring()
  return self.msg
end


function ThesmsworksError.__tojson(self)
  return self:to_json()
end


return ThesmsworksError
