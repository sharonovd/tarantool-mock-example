local t = require('luatest')
local g = t.group('integration_api')

local helper = require('test.helper.integration')

local cluster = helper.cluster
local server = t.Server:new({
    command = 'test/mock/init.lua',
    workdir='tmp',
    -- passed as TARANTOOL_HTTP_PORT, used in http_request
    http_port = 3333,
})

g.before_all(function()
    server:start()
    t.helpers.retrying({}, function() server:http_request('get', '/ping') end)
end)

g.after_all(function()
    server:stop()
end)

g.test_mock = function()
    local server = cluster.main_server
    local response = server:http_request('get', '/ping_mock')
    t.assert_equals(response.json.mock_response.status, 200)
end
