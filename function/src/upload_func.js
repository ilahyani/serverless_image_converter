const { getSignedUrl } = require("@aws-sdk/s3-request-presigner")
const { S3Client, PutObjectCommand, GetObjectCommand } = require("@aws-sdk/client-s3")
const sharp = require("sharp");

const s3Client = new S3Client({ region: process.env.AWS_REGION })

const upload_to_s3 = async (bucketName, filename, file) => {
    uploaded_file = await s3Client.send(
        new PutObjectCommand({
            Bucket: bucketName,
            Key: filename,
            Body: file,
            contentType: 'image/jpeg'
        })
    )
    const cmd = new GetObjectCommand({
        Bucket: bucketName,
        Key: filename,
    })
    const url = await getSignedUrl(s3Client, cmd, { expiresIn: 3600 })
    return url
}

exports.upload_function = async (request, response) => {
    const image = request.files.image[0].buffer
    const imagename = `${Date.now()}-${request.files.image[0].originalname}`
    try {
        og_url = await upload_to_s3(process.env.ORIGINAL_FILES_BUCKET, imagename, image)
    }
    catch (error) {
        console.error('original image upload failed', error)
        return response.status(503).json({error: 'upload failed'})
    }
    try {
        const sfile = sharp(image)
        const file_md = await sfile.metadata()
        let watermark = request.files.watermark[0].buffer
        watermark = await sharp(watermark)
            .resize({ width: Math.round(file_md.width * 0.2) })
            .png({ quality: 100 })
            .toBuffer()
        watermark = sharp(watermark)
        const watermark_buffer = await watermark.toBuffer()
        const watermark_md = await watermark.metadata()
        const watermarked_file = await sfile.composite([{
            input: watermark_buffer,
            left:  Math.floor(file_md.width / 2) - Math.floor(watermark_md.width / 2),
            top: Math.floor(file_md.height / 2) - Math.floor(watermark_md.height / 2)
        }]).toBuffer()
        try {
            const result_name = `${Date.now()}-edit-${request.files.image[0].originalname}`
            wm_url = await upload_to_s3(process.env.EDITED_FILES_BUCKET, result_name, watermarked_file)
        }
        catch (error) {
            console.error('original file upload failed', error)
            return response.status(503).json({error: 'upload failed'})
        }
        return response.json({ original_file: og_url, edit_file: wm_url })
    } catch(error) {
        console.error('operation failed', error)
        return response.status(503).json({error: 'upload failed'})
    }
}
