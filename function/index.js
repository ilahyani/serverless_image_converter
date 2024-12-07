const AWS = require('aws-sdk');
const sharp = require("sharp");
const s3 = new AWS.S3();

exports.handler = async (event, context) => {
    console.log('S3 Event:', event);
    const bucketName = event.Records[0].s3.bucket.name
    const obj_key = decodeURIComponent(event.Records[0].s3.object.key.replace(/\+/g, " "))
    try {
        const file = await s3.getObject({
            Bucket: bucketName,
            Key: decodeURIComponent(event.Records[0].s3.object.key.replace(/\+/g, " "))
        }).promise();
        const file_size = parseInt(file.ContentLength)
        console.log(file_size)
        if (file_size / (1024 * 1024) > 1) {
            throw new Error('File Too Large, try a smaller one')
        }
        const processedImage = await sharp(file.Body)
            .webp({ quality: 100 })
            .toBuffer();
        await s3.upload({
            Bucket: process.env.edited_files_bucket_name,
            Key: `${Date.now()}-${obj_key}.webp`,
            Body: processedImage
        }).promise()
        console.log('SUCCESS')
    }
    catch (error) {
        console.error('Error processing the image from S3:', error);
        throw error;
    }
};
