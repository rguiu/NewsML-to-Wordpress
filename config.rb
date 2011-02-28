require 'rubygems'
require 'dm-core'
require 'dm-mysql-adapter'

XML_FILE = "source.xml"
IMAGES_SOURCE_PATH = "images/"
IMAGES_DESTINATION_LOCAL = "/Applications/MAMP/htdocs/wordpress/"
IMAGES_DESTINATION_PATH = "wp-content/uploads/"
IMAGES_URL = "http://localhost:8888//wordpress/"
IMAGES_FILE_EXTENSION = "jpg" # this should be detected, I will do it in the future

IMAGES_WIDTH = 200
IMAGES_HEIGHT = 100

#Wordpress data
WP_USER_ID = 2
WP_STATUS = "publish" # draft can be a better alternative
WP_PING = "open"
WP_COMMENTS = "open"

# db
WP_DB_USER = "root"
WP_DB_PASSWORD = nil
WP_DB_SERVER = "localhost"
WP_DB_NAME = "wordpress"
WP_DB = "mysql"

# business code now - dont need to change(hopefully)
pass = WP_DB_PASSWORD.nil? ? "" : ":#{WP_DB_PASSWORD}"
DataMapper.setup(:default, "#{WP_DB}://#{WP_DB_USER}#{pass}:@#{WP_DB_SERVER}/#{WP_DB_NAME}") 
