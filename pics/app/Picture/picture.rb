# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class Picture
  include Rhom::PropertyBag

  # Uncomment the following line to enable sync with Picture.
  enable :sync

  #add model specifc code here
  property :image_uri, :blob
end
