class User < ApplicationRecord
    has_one :cart
    has_many :short_urls

    # has_secure_password - this gives error with password_digest=
end
