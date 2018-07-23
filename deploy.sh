set -euf -o pipefail

S3_BUCKET_NAME='hearthstone-secrets.fletom.com'
CLOUDFRONT_DISTRIBUTION_ID='E14DPMMLGM0NE4'
EXCLUDE=('.DS_Store' 'deploy.sh' '.git/*' '.idea/*')

exclude_params=''
for e in ${EXCLUDE[@]}; do
	exclude_params="$exclude_params --exclude $e"
done

aws cloudfront create-invalidation --distribution-id $CLOUDFRONT_DISTRIBUTION_ID --paths "/*"

aws s3 sync \
	./ s3://$S3_BUCKET_NAME \
	--acl 'public-read' \
	$exclude_params \
	--delete
