const session = require('express-session');
const RedisStore = require('connect-redis').default;
const { createClient } = require('redis');

const dotenv = require('dotenv');
dotenv.config();

let redisClient = createClient({
    socket: {
        host: process.env.REDIS_HOST,
        port: process.env.REDIS_PORT
    }
});

redisClient.connect().catch(err => {
    console.error('Could not connect to Redis', err);
});

const sessionConfig = session({
    store: new RedisStore({ client: redisClient }),
    secret: process.env.REDIS_SECRET,
    resave: false,
    saveUninitialized: false,
    cookie: {
        secure: false,
        maxAge: 1000 * 3600
    }
});

module.exports = { sessionConfig };