const express = require("express");
const mongoose = require("mongoose");
const multer = require("multer");
const bodyParser = require("body-parser");
const cors = require("cors"); // Import CORS
const app = express();

app.use(cors()); // Use CORS middleware
app.use(bodyParser.json());

mongoose.connect("mongodb://localhost:27017/mediaDB", {
    useNewUrlParser: true,
    useUnifiedTopology: true,
});

// Define Schema
const mediaSchema = new mongoose.Schema({
    date: Date,
    text: String,
    imagePath: String,
    videoPath: String,
    audioPath: String,
});

const MediaEntry = mongoose.model("MediaEntry", mediaSchema);

// Set up multer for file uploads
const storage = multer.diskStorage({
    destination: (req, file, cb) => cb(null, "uploads/"),
    filename: (req, file, cb) => cb(null, Date.now() + "-" + file.originalname),
});
const upload = multer({ storage: storage });

// Route to add an entry
app.post("/addEntry", upload.fields([{ name: "image" }, { name: "video" }, { name: "audio" }]), async (req, res) => {
    try {
        const newEntry = new MediaEntry({
            date: req.body.date,
            text: req.body.text,
            imagePath: req.files.image ? req.files.image[0].path : null,
            videoPath: req.files.video ? req.files.video[0].path : null,
            audioPath: req.files.audio ? req.files.audio[0].path : null,
        });
        await newEntry.save();
        res.status(201).send("Entry added successfully!");
    } catch (error) {
        res.status(500).send(error);
    }
});

// Route to get entries by date
app.get("/entries", async (req, res) => {
    try {
        const entries = await MediaEntry.find().sort({ date: -1 });
        res.status(200).json(entries);
    } catch (error) {
        res.status(500).send(error);
    }
});

app.listen(3000, () => console.log("Server is running on port 3000"));
