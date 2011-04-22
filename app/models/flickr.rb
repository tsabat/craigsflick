class Flickr

  def initialize(url)
    @url = url
    FlickRaw.api_key = credentials[:key]
    FlickRaw.shared_secret = credentials[:secret]
  end

  def url
    frob = flickr.auth.getFrob
    FlickRaw.auth_url :frob => frob, :perms => 'read'
  end

  def login(frob)
    begin
      auth = flickr.auth.getToken :frob => frob
      login = flickr.test.login
      {:auth_token => auth.token, :user_id => login.id}
    rescue FlickRaw::FailedResponse
      nil
    end
  end

  def sets(user_id)
    begin
      sets = flickr.photosets.getList(:user_id => user_id)
      sets.map do |set|
        {
            :id => set.id,
            :name => set.title,
            :description => set.description,
            :count => set.photos,
            :primary_url => FlickRaw.url_t(set_normalize(set))
        }
      end
    rescue FlickRaw::FailedResponse
      nil
    end

  end

  def photos(set_id)
    photos = flickr.photosets.getPhotos(:photoset_id => set_id, :extras => "url_m")

    photos.photo.map do |photo|
      {
          :url => photo.url_m,
          :name => photo.title,
          :user => photos.ownername
      }
    end
  end

  def set_normalize(set)
    PhotoFromSet.new(set)
  end


  def credentials
    if Rails.env.development?
      if @url.include? 'fuck'
          #chris
          {:key => '50d9ac23dbe5f2861533ba5d7298857b', :secret => '8f58d0de127827d0'}
        elsif @url.include? 'winning'
          #tim
          {:key => '00df746ec86d858b365921cc8131356c', :secret => '37c0d7244bc8b327'}
      end

    else
      {:key => 'f3283743a59586a7bc3cabe615336034', :secret => '10a545042e3e1b8c'}
    end
  end

end

class PhotoFromSet

  attr_reader :id, :farm, :secret, :server

  def initialize(set)
    @id = set.primary
    @farm = set.farm
    @secret = set.secret
    @server = set.server
  end

end