require 'json'
require 'rest_client'

class Picture < SourceAdapter
  def initialize(source,credential)
    @base = 'http://localhost:3000/pictures'
    super(source,credential)
  end
 
  def login
    # TODO: Login to your data source here if necessary
  end
 
  def query(params=nil)
    # TODO: Query your backend data source and assign the records 
    # to a nested hash structure called @result. For example:
    # @result = { 
    #  "1"=>{"name"=>"Acme", "industry"=>"Electronics"},
    #  "2"=>{"name"=>"Best", "industry"=>"Software"}
    # }
    @result = {}
    parsed = JSON.parse(RestClient.get(@base))
    parsed.each do |item|
      @result[item["picture"]["id"].to_s] = item["picture"]
    end if parsed
    @result
  end
 
  def sync
    # Manipulate @result before it is saved, or save it 
    # yourself using the Rhosync::Store interface.
    # By default, super is called below which simply saves @result
    super
  end
 
  def create(create_hash,blob=nil)
    # Create a new record in your backend data source
    # If your rhodes rhom object contains image/binary data 
    # (has the image_uri attribute), then a blob will be provided
    
    # KB: I don't see a blob here, just a path to the file.  Fine.

    unless create_hash["image_uri"].nil?
      # make sure its a tmp file, /etc/passwd anyone?
      if create_hash["image_uri"].to_s.start_with?('/tmp')
        # pass it to the backend as base64 encoded data
        create_hash["image"] = Base64.encode64(IO.read( create_hash["image_uri"] ) )
      end
    end

    result = RestClient.post(@base,:picture => create_hash)
    JSON.parse(result)["picture"]["id"].to_s
  end
 
  def update(update_hash)
    # TODO: Update an existing record in your backend data source
    raise "Please provide some code to update a single record in the backend data source using the update_hash"
  end
 
  def delete(delete_hash)
    # TODO: write some code here if applicable
    # be sure to have a hash key and value for "object"
    # for now, we'll say that its OK to not have a delete operation
    RestClient.delete(@base + '/' + delete_hash["id"] )
  end
 
  def logoff
    # TODO: Logout from the data source if necessary
  end
end
