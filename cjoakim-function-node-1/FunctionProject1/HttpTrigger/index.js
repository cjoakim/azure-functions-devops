// Sample HttpTrigger Azure Function which accesses Azure Redis Cache.
// Chris Joakim, 2019/10/23

const util  = require('util');
const redis = require("redis");
const build_timestamp_obj = require("../build_timestamp.json");

// Environment variables
const REDIS_NS  = process.env.AZURE_REDISCACHE_NAMESPACE; 
const REDIS_KEY = process.env.AZURE_REDISCACHE_KEY;

const server = REDIS_NS + '.redis.cache.windows.net';
const creds  = { auth_pass: REDIS_KEY, tls: {servername: server}}
const client = redis.createClient(6380, server, creds);

// Make the Redis client work with async/await
// See https://github.com/NodeRedis/node_redis
const {promisify} = require('util');
const getAsync = promisify(client.get).bind(client);
const setAsync = promisify(client.set).bind(client);

module.exports = async function (context, req) {
    var op    = req.query.operation || (req.body && req.body.operation);
    var key   = req.query.key || (req.body && req.body.key);
    var value = req.query.value || (req.body && req.body.value);
    var now   = new Date();
    var data  = {};
    data['date'] = new Date().toUTCString();
    data['build'] = build_timestamp_obj;
    console.log(util.format('op: %s, key: %s, value: %s ', op, key, value));

    if (key && op) {
        console.log(util.format('client: %s', client));
        data['key'] = key;
        data['operation'] = op;
        if (op.toLowerCase() == 'set') {
            data['value'] = value;
            await setAsync(key, value).then(function(reply) {
                data['reply'] = reply;
                context.res = {
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(data, null, 2)
                };
            });
        }
        else {
            console.log(util.format('getting: %s', key)); 
            await getAsync(key).then(function(reply) {
                data['reply'] = reply;
                context.res = {
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(data, null, 2)
                };
            });
        }
    }
    else {
        data['message'] = 'error: no key and/or operation parameter provided';
        context.res = {
            status: 400,
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data, null, 2)
        };
    }
};
