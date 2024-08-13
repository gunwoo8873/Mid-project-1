// Express
const express = require('express');
const cors = require('cors');
const app = express();
app.use(cors());

// Dotenv
const dotenv = require('dotenv');
dotenv.config();

// session
const { sessionConfig } = require('./utils/session');
app.use(sessionConfig);

// Body-parser
const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// cookie-parser
const cookieParser = require('cookie-parser');
app.use(cookieParser());

// Listen
app.listen(process.env.PORT, function () {
    console.log(`Backend Server Ready. http://127.0.0.1:${process.env.PORT}`);
});

// Routes
app.use('/auth', require('./routes/auth'));
app.use('/amm', require('./routes/asset-management'));
app.use('/real-estate', require('./routes/real-estate'));
app.use('/naverlogin', require('./routes/naverlogin'));
app.use('/chatbot', require('./routes/chatbot'));
