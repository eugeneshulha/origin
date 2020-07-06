module CorevistAPI::Services::Token
  class RefreshService < CorevistAPI::Services::BaseService
    MSG_DOUBLE_USE        = 'api.errors.token.refresh.used_double_times'.freeze
    MSG_EMPTY_TOKEN       = 'api.errors.token.refresh.empty'.freeze
    MSG_EXPIRED_TOKEN     = 'api.errors.token.refresh.expired'.freeze
    MSG_INVALID_USER      = 'api.errors.token.refresh.invalid_user'.freeze
    MSG_NO_REFRESH_TOKENS = 'api.errors.token.refresh.no_refresh_tokens'.freeze

    private

    def perform
      return result.fail!(MSG_EMPTY_TOKEN) if @object.blank?

      payload = Warden::JWTAuth::TokenDecoder.new.call(@object)
      return result.fail!(MSG_EXPIRED_TOKEN) if expired?(payload[CorevistAPI::User::KEY_EXP])
      return result.fail!(MSG_DOUBLE_USE) if double_use?(payload[CorevistAPI::User::KEY_JTI])
      return result.fail!(MSG_INVALID_USER) if (user = fetch_user(payload[CorevistAPI::User::KEY_SUB])).blank?
      return result.fail!(MSG_NO_REFRESH_TOKENS) if (token = fetch_token(user, payload[CorevistAPI::User::KEY_JTI])).blank?

      CorevistAPI::JWTBlacklist.invalidate_token(token)
      result(resource: user)
    end

    def expired?(exp)
      Time.now.utc > Time.at(exp).utc
    end

    def double_use?(jti)
      CorevistAPI::JWTBlacklist.find_by(jti: jti).present?
    end

    def fetch_user(id)
      CorevistAPI::User.find_by(id: id)
    end

    def fetch_token(user, refresh_jti)
      user.jwt_tokens.find_by(refresh_jti: refresh_jti)
    end
  end
end
