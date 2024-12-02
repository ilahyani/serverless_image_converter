const express = require('express')
const multer = require('multer')
const { upload_function } = require('./upload_func')

const app = express()
const upload = multer()

app.get('/', (req, res) => {
    res.json({message: 'function is up'})
})

app.post ('/upload', upload.single('file'), upload_function)

app.listen(process.env.PORT, () => {
    console.log(`stream service running on port ${process.env.PORT}`)
})
