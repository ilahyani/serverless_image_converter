const express = require('express')
const multer = require('multer')
const { upload_function } = require('./upload_func')

const app = express()
const upload = multer({ storage: multer.memoryStorage() })

app.get('/', (req, res) => {
    res.json({message: 'function is up'})
})

app.post ('/upload',
    upload.fields([{ name: 'image', maxCount: 1 }, { name: 'watermark', maxCount: 1 }]),
    (req, res, next) => {
        if (!req.files?.image || !req.files?.watermark) {
            return res.status(400).json({'error': 'Both image and watermark are required'})
        }
        next()
    },
    upload_function)

app.listen(process.env.PORT, () => {
    console.log(`stream service running on port ${process.env.PORT}`)
})
