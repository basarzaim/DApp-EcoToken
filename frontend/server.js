const express = require('express');
const multer = require('multer');
const path = require('path');

const app = express();
const PORT = 3000;

const storage = multer.diskStorage({
    destination: 'uploads/',
    filename: (req, file, cb) => {
        cb(null, Date.now() + path.extname(file.originalname));
    }
});

const upload = multer({
    storage: storage,
    limits: { fileSize: 10 * 1024 * 1024 } // Set limit to 10MB
}).single('proof');

app.use('/uploads', express.static(path.join(__dirname, 'uploads')));
app.use(express.json());

app.post('/submit-action', (req, res) => {
    upload(req, res, (err) => {
        if (err) {
            console.error(err);
            return res.status(500).send('Error uploading file.');
        }
        const { description, userWallet } = req.body;
        const proofPath = req.file.path.replace('uploads\\', 'uploads/'); // Ensure the correct path format

        // Simulate saving submission details to a database or similar
        console.log(`Received submission from ${userWallet}: ${description}, proof saved at ${proofPath}`);

        res.json({ message: 'Submission successful', proofPath });
    });
});

app.get('/submissions/:userAddress', (req, res) => {
    const userAddress = req.params.userAddress;

    // Simulate fetching submissions for a user from a database or similar
    const submissions = [
        {
            description: 'Recycling glass bottles',
            status: 'Pending',
            proofPath: 'uploads/somefile.jpg' // Example file path, replace with actual
        },
        // Add more submissions as needed
    ];

    res.json({ submissions });
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
