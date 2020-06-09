module CorevistAPI
  class JwtToken < ApplicationRecord
    self.table_name = 'jwt_tokens'

    belongs_to :user
    validates_presence_of :access_jti, :refresh_jti, :access_exp, :refresh_exp

    def to_s
      id.to_s
    end
  end
end
