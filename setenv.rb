# The name of this business, as displayed to your users throughout the application
ENV['BUSINESS_NAME']="Coord"
# the from address used when sending email to customers, and also the email address we send admin emali to (e.g. from the conact form)
ENV['BUSINESS_EMAIL']="support@coordapp.com"

# used for facebook connect, google analytics, emails and other places where a master domain name is used to represent the business
ENV['BASE_DOMAIN_NAME']="staging.coordapp.com"

# the database namespace used in database.yml, "foobar" will create foobar_development and foobar_test databases for MySQL and MongoDB
ENV['DATABASE_NAMESPACE']="coord"
# mysql usernme and password
ENV['MYSQL_USERNAME']="coord"
ENV['MYSQL_PASSWORD']="NTBeNasjrYvdCdAQTH8nT97t"
ENV['MYSQL_HOST']="localhost"
ENV['MYSQL_PORT']="3306"

# emails sent in development are intercepted and delivered to the developer, so we dont bombard customers by accident
ENV['DEVELOPER_EMAIL']="john@kohactive.com"

# we use AWS as a backend for fog and paperclip
ENV['AWS_ACCESS_KEY_ID']="AKIAIBUEOLHAW7RCLNTQ"
ENV['AWS_SECRET_ACCESS_KEY']="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"
ENV['S3_NAMESPACE']="coord_development"
ENV['S3_CLOUDFRONT_DOMAIN']="d3a47inhbi5am8.cloudfront.net"


# for onmiauth with facebook and facebook connect/widgets etc
ENV['FACEBOOK_CLIENT_ID']="179276442204399"
ENV['FACEBOOK_SECRET']="436598d31a24b069e6be0784cc9bde65"
# for displaying to your customers
ENV['FACEBOOK_FAN_PAGE_NAME']=""
ENV['FACEBOOK_FAN_PAGE_ID']=" "

# for omniauth with twitter
ENV['TWITTER_CONSUMER_KEY']=""
ENV['TWITTER_CONSUMER_SECRET']=""
# for displaying to your customers
ENV['TWITTER_SCREEN_NAME']=""

# urchin code for google analytics
ENV['GOOGLE_ANALYTICS_ACCOUNT_ID']=""

# emails generated in development will be delivered through gmail
ENV['GMAIL_DOMAIN']="gmail.com"
ENV['GMAIL_USER_NAME']="you@gmail.com"
ENV['GMAIL_PASSWORD']="your_password"

ENV['GOOGLE_WEBMASTER_TOOLS_META']=""

ENV['MEMCACHE_SERVERS'] = "localhost:11211"
