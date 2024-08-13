const session = require('express-session');
const sessionConfig = session({
    secret: 'qlalfdldi123698745',
    resave: false,
    saveUninitialized: false,
});

module.exports = { sessionConfig };