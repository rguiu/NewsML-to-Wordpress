class Post
   include DataMapper::Resource

   # not usually need to be changed the following wordpress data
   WP_POST_TABLE = "wp_posts"
   WP_POST_ID = "ID"
   WP_POST_TYPE = "post"

   WP_POST_CONTENT_COLUMN = "post_content"
   WP_POST_TITLE_COLUMN = "post_title"
   WP_POST_STATUS_COLUMN = "post_status" 
   WP_POST_PARENT_COLUMN = "post_parent" 
   WP_POST_TYPE_COLUMN = "post_type"
   WP_POST_AUTHOR_COLUMN = "post_author"
   WP_POST_PING_COLUMN = "to_ping"
   WP_POST_EXCERPT_COLUMN = "post_excerpt"
   WP_POST_COMMENTS_COLUMN = "comment_status"
   WP_POST_PINGED_COLUMN = "pinged"
   WP_POST_PCF_COLUMN = "post_content_filtered"
   WP_POST_DATE_COLUMN = "post_date"
   WP_POST_DATE_GMT_COLUMN = "post_date_gmt"
   WP_POST_MODIFIED_COLUMN = "post_modified"
   WP_POST_MODIFIED_GMT_COLUMN = "post_modified_gmt"
   WP_POST_MIME_TYPE_COLUMN = "post_mime_type"
   WP_POST_GUID_COLUMN = "guid"
   
   # set the storage name for the :legacy repository
   storage_names[:default] = WP_POST_TABLE
   property :id, Serial, :field => WP_POST_ID
   property :title, String, :field => WP_POST_TITLE_COLUMN
   property :body, String, :field => WP_POST_CONTENT_COLUMN
   property :author, Integer, :field => WP_POST_AUTHOR_COLUMN
   property :status, String, :field => WP_POST_STATUS_COLUMN
   property :excerpt, String, :field => WP_POST_EXCERPT_COLUMN
   property :ping, String, :field => WP_POST_PING_COLUMN
   property :comments, String, :field => WP_POST_COMMENTS_COLUMN
   property :pinged, String, :field => WP_POST_PINGED_COLUMN
   property :post_content_filtered, String, :field  => WP_POST_PCF_COLUMN
   property :date, DateTime, :field => WP_POST_DATE_COLUMN
   property :date_gmt, DateTime, :field => WP_POST_DATE_GMT_COLUMN
   property :modified, DateTime, :field => WP_POST_MODIFIED_COLUMN
   property :modified_gmt, DateTime, :field => WP_POST_MODIFIED_GMT_COLUMN
   property :parent, Integer, :field => WP_POST_PARENT_COLUMN
   property :type, String, :field => WP_POST_TYPE_COLUMN
   property :mime_type, String, :field => WP_POST_MIME_TYPE_COLUMN
   property :guid, String, :field => WP_POST_GUID_COLUMN


   def complete
    self.author = WP_USER_ID
    self.status = WP_STATUS
    self.excerpt = ''
    self.pinged = ''
    self.post_content_filtered = ''
    self.ping = WP_PING
    self.comments = WP_COMMENTS
    self.date = Time.now
    self.date_gmt = Time.now
    self.modified = Time.now
    self.modified_gmt = Time.now
    self.parent = 0
    self.type = WP_POST_TYPE
   end

   def create_image(parent, image_name) 
    self.author = parent.author
    self.status = 'inherit'
    self.excerpt =  parent.excerpt
    self.pinged =  parent.pinged
    self.post_content_filtered =  parent.post_content_filtered
    self.ping =  parent.ping
    self.comments =  parent.comments
    self.date =  parent.date
    self.date_gmt =  parent.date_gmt
    self.modified =  parent.modified
    self.modified_gmt =  parent.modified_gmt
    self.parent =  parent.id
    self.type = 'attachment'
    self.title = "image"
    self.body = ''
    self.mime_type = "image/#{IMAGES_FILE_EXTENSION}"
    self.guid = "#{IMAGES_URL}#{IMAGES_DESTINATION_PATH}#{image_name.gsub!(" ", "_")}"
   end
end

