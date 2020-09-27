local logging = require("logging")

local log = logging.new(
  function(self, level, message)
    print(level, message)
    return true
  end
)

return log
