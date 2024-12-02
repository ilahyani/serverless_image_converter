const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");
const { S3Client, PutObjectCommand, GetObjectCommand } = require("@aws-sdk/client-s3");

exports.upload_function = async (request, response) => {
    const file = request.file;
    const s3Client = new S3Client({ region: "us-east-1" });
    try {
        uploaded_file = await s3Client.send(
            new PutObjectCommand({
                Bucket: 'upload-fun',
                Key: 'test-file',
                Body: file,
                contentType: 'image/jpeg'
            })
        )
        const cmd = new GetObjectCommand({
            Bucket: 'upload-fun',
            key: 'test-file'
        })
        const url = await getSignedUrl(s3Client, cmd, { expiresIn: 3600 })
        return response.json({uploaded_file: url})
    }
    catch (error) {
        console.error('>>>>>>>>>>> upload failed', error)
        response.status(503).json({error: 'upload failed'})
    }
}