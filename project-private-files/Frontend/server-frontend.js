// Express
const express = require('express');
const app = express();
app.use(express.static('public'));

// Session
const { sessionConfig } = require('./utils/session');
app.use(sessionConfig);

// Cookie-parser
const cookieParser = require('cookie-parser');
app.use(cookieParser());

// Body-parser
const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// HTTPS
const https = require('https');
const fs = require('fs');
const options = {
    key: fs.readFileSync('./rootca.key'),
    cert: fs.readFileSync('./rootca.crt')
};

// Dotenv
const dotenv = require('dotenv');
dotenv.config();

// node-cache 설정
const NodeCache = require('node-cache');
const transactionCache = new NodeCache({ stdTTL: 600, checkperiod: 120 });

// CSRF
const csrf = require('csurf');
app.use(csrf({ ignoreMethods: ['GET', 'POST', 'OPTIONS'] }));
app.use((req, res, next) => {
    req.transactionCache = transactionCache;

    if (!req.session.user) {
        res.clearCookie('uid', { path: '/' });
    }

    res.cookie('XSRF-TOKEN', req.csrfToken());
    next();
});
app.use(function (err, req, res, next) {
    // 만일 토큰 에러가 아닌 다른 에러일경우 다른 에러처리 미들웨어로 보냅니다.
    if (err.code !== 'EBADCSRFTOKEN') { return next(err); }

    // CSRF 토큰 에러
    const errorHtml = /*html*/`<title>검증 실패</title><h2>CSRF 토큰 검증에 실패했습니다. 페이지를 새로고침한 후 다시 시도하세요.</h2>`;
    res.status(403).send(errorHtml);
    next();
});

// Listen
https.createServer(options, app).listen(process.env.PORT, () => {
    console.log(`Frontend Server Ready. https://127.0.0.1:${process.env.PORT}`);
});

// Routes
app.use('/', require('./routes/index'));
app.use('/auth', require('./routes/auth'));
app.use('/amm', require('./routes/asset-management'));
app.use('/real-estate', require('./routes/real-estate'));
app.use('/chatbot', require('./routes/chatbot'));
app.use('/naverlogin', require('./routes/naverlogin'));
