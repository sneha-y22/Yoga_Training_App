const mongoose = require('mongoose');

const courseSchema = new mongoose.Schema({
  title: String,
  level: String,
  duration: Number,
  videoUrl: String
});

module.exports = mongoose.model('Course', courseSchema);
