require 'busted.runner'()

local sckt = require('amqp.socket') 

describe("Socket Environment", function ()

    it('Should get Lua socket', function ()
        local sock, tcp
        sock, tcp = sckt:get_lua()

        assert.truthy(sock)
        assert.truthy(tcp)
    end)
end)