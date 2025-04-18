const Course = require('../models/Course');

exports.getCourses = async (req, res) => {
  const courses = await Course.find();
  res.json(courses);
};

exports.toggleFavorite = async (req, res) => {
    const user = await User.findById(req.user.id);
    const { courseId } = req.body;
  
    const index = user.favorites.indexOf(courseId);
    if (index > -1) {
      user.favorites.splice(index, 1);
    } else {
      user.favorites.push(courseId);
    }
  
    await user.save();
    res.json({ favorites: user.favorites });
  };
  