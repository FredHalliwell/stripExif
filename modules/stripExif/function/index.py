from PIL import Image
import boto3
import os

OUTPUT_BUCKET = os.environ["OUTPUT_BUCKET"]

s3 = boto3.client("s3")
def lambda_handler(event, context):

    record = event["Records"][0]["s3"]
    bucket = record["bucket"]["name"]

    filename = record["object"]["key"]

    image = s3.get_object(Bucket=bucket, Key=filename)
    
    data = list(image.getdata())
    image_without_exif = Image.new(image.mode, image.size)
    image_without_exif.putdata(data)
        
    image_without_exif.save(filename)

    image_without_exif.close()

    s3.put_object(
    Bucket=OUTPUT_BUCKET,
    Key=filename,
    Body=image_without_exif,
    ContentType="image/jpeg",
)