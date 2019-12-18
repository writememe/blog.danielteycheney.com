AWS := aws
HUGO := hugo
PUBLIC_FOLDER := public/
S3_BUCKET = s3://blog-danielteycheney/
CLOUDFRONT_ID := E1548VJA83ILXT
DOMAIN = blog.danielteycheney.com
SITEMAP_URL = https://blog.danielteycheney.com/sitemap.xml

.ONESHELL:

.PHONY: all

all: deploy

deploy:
	$(AWS) s3 sync --acl "public-read" $(PUBLIC_FOLDER) $(S3_BUCKET)
	curl --silent "http://www.google.com/ping?sitemap=$(SITEMAP_URL)"
	$(AWS) cloudfront create-invalidation --distribution-id $(CLOUDFRONT_ID) --paths "/*"
