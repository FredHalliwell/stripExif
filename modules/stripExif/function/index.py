from PIL import Image
import boto3
import os
import io

OUTPUT_BUCKET = os.environ["OUTPUT_BUCKET"]

s3 = boto3.client("s3")
def lambda_handler(event, context):
    print("running")

    record = event["Records"][0]["s3"]
    bucket = record["bucket"]["name"]
    key = record["object"]["key"]

    response = s3.get_object(Bucket=bucket, Key=key)
    image = Image.open(io.BytesIO(response["Body"].read()))

    buffer = io.BytesIO()
    image.save(buffer, format="JPEG", quality=95)

    s3.put_object(
        Bucket=OUTPUT_BUCKET,
        Key=key,
        Body=buffer.getvalue(),
        ContentType="image/jpeg",
    )