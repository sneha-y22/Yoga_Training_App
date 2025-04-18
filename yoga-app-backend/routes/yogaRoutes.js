const express = require('express');
const router = express.Router();
const { getCourses, toggleFavorite } = require('../controllers/yogaController');
const authMiddleware = require('../middleware/authMiddleware');

router.get('/courses', getCourses);
router.post('/favorites', authMiddleware, toggleFavorite);

module.exports = router;
