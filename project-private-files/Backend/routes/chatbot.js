let router = require('express').Router();
const { QNA } = require('../utils/qna');
const chatBot = new QNA();

// 챗봇 API
router.post('/', async function (req, res) {
    try {
        res.json({ answer: chatBot.getBestAnswer(req.body.question) });
    } catch (error) {
        console.error('챗봇 API:', error);
        res.status(500).json({ answer: '서버 오류가 발생했습니다.' });
    }
});

module.exports = router;