class ShortUrl < ApplicationRecord
  # users will be able to create short urls to promote their books from may be amaxon etc with big url and get shorted url
  belongs_to :user
  validates :long_url, presence: true
  validates :short_code, uniqueness: true

  def is_expired?
    # if expires_at is not null and expires_at is greater than or equal to current time then return true
    expires_at && expires_at >= Time.current
  end

  def shortened_code
    loop do
      code = SecureRandom.base62(6)
      break unless ShortUrl.where(short_code: code).exists?
    end
    code
  end

end
# to do
# custom url