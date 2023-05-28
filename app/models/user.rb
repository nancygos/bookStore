class User < ApplicationRecord
    has_one :cart

    # has_secure_password - this gives error with password_digest=
end
