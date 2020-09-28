local log = require('amqp.logger')

-- create socket prototype
local socket = {}

--- Check if in the environment has nginx socket
function socket.has_nginx()
    return (_G.ngx and _G.ngx.socket)
end

--- Check if in the environment has cqueues socket
function socket.has_cqueues()
    local cqueues, _ = pcall(require, "cqueues")

    return cqueues
end

--- Get the nginx socket
-- @return nginx socket and the tcp
function socket.get_nginx()
    log:info('Using NGINX socket.')

    local sckt = _G.ngx.socket
    local tcp = sckt.tcp

    return sckt, tcp
end

--- Get the CQueues socket
-- @return the cqueue socket and the tcp
function socket.get_cqueues()
    log:info('Using CQueues socket.')

    local sckt = require('cqueues.socket')

    return sckt, sckt
end

--- Get the Lua Socket
-- @return the lua socket and the tcp
function socket.get_lua()
    log:info('Using Lua socket.')

    local sckt = require("socket")
    local tcp = sckt.tcp

    return sckt, tcp
end

--- Get socket based on parameter
-- @param type the type of socket
-- @return socket and the tcp
function socket:get(type)
    if type == 'default' then
        return self.get()
    elseif type == 'ngx' then
        return self.get_nginx()
    elseif type == 'cqueues' then
        return self.get_cqueues()
    end

    return self.get_lua()
end

--- Get socket based on the environment disponibility
-- @return socket and the tcp
function socket:get()
    if self.has_nginx() then
        return self.get_nginx()
    end

    if self.has_cqueues() then
        return self.get_cqueues()
    end

    return self.get_lua()
end

return socket
