class JsonWebToken
    SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

    # This takes care of encoding the payload by adding an expiration date of 24 hours by default
    def self.encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY)
    end

    # This takes care of decoding the JWT token and gets the payload. Then we use the 
    # HashWithIndifferentAccess class provided by rails which allows us to retrieve a value
    # to a hash with a symbol or a string
    def self.decode(token)
        decoded = JWT.decode(token, SECRET_KEY).first
        HashWithIndifferentAccess.new decoded
    end
end

