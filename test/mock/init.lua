#!/usr/bin/env tarantool

require('strict').on()
package.setsearchroot()

local port = os.getenv('TARANTOOL_HTTP_PORT')
print('PORT is ' .. port)
local http = require('http.server').new('localhost', tonumber(port))

http:route({method = 'GET', path = '/ping'}, function()
    print('Ping received!')
    return {status=200}
end)
http:start()

print('Started mock!')
