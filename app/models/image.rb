class Image < ApplicationRecord
  URL_REGEXP = %r{\A((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z}ix
  IMG_REGEXP = /.\.(png|jpeg|jpg|gif)\z/

  validates :url, presence: true, uniqueness: true, format: { with: IMG_REGEXP, message:
    'Errors: Invalid Image URL. We only accept .png/.jpeg/.jpg/.gif files.' }
  validates :url, format: { with: URL_REGEXP, message: 'Errors: Invalid URL!' }
  # validates :tag, presence: true
end
