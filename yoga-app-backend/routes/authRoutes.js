const express = require('express');
const router = express.Router();
const { register, login, getProfile } = require('../controllers/authController');
const authMiddleware = require('../middleware/authMiddleware'); // Adjust the path accordingly


router.post('/register', register);
router.post('/login', login);
router.get('/profile', authMiddleware, getProfile); // import getProfile from controller

module.exports = router;
