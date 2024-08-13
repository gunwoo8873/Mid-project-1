let router = require('express').Router();

chatBot = {
    HOST: process.env.CHATBOT_HOST,
    PORT: process.env.CHATBOT_PORT
};

// ChatBot
router.post('/', async function (req, res) {
    try {
        const response = await fetch(`http://${chatBot.HOST}:${chatBot.PORT}/chatbot`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(req.body)
        });

        const data = await response.json();
        if (response.ok) {
            return res.json({ data });
        } else {
            return res.status(401).json({ data });
        }
    } catch (error) {
        // console.error(error);
        return res.status(500).json({ data: { answer: '챗봇 서버에 문제가 생겼습니다.' } });
    }
});

module.exports = router;