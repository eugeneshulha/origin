module CorevistAPI::Translations::Cache::Redis
  include CorevistAPI::Translations::Cache::Base

  def initialize
    @use_base = false
    # TODO: add Redis settings for translations
    safe_call do
      @current = ::Redis.new(Const::App.redis[:translations])
    end
  end

  def fetch(*)
    return super if @use_base
    safe_call { super }
  end

  def reconnect
    return if @current.is_a?(Hash)
    safe_call { @current.client.reconnect }
  end

  def connected?
    return false if @use_base
    safe_call { @current.client.connected? }
  end

  def cached?(locale, loaded: false)
    return super if @use_base
    safe_call do
      @current["#{locale}/locale_loaded"] ||= loaded
    end
  end

  def write(*)
    return super if @use_base
    safe_call { super }
  end

  def key?(key)
    return super if @use_base
    safe_call do
      @current.exists(key)
    end
  end

  def delete(key)
    return super if @use_base
    safe_call { @current.del(key) }
  end

  def init(*)
    return super if @use_base
    safe_call do
      @current.pipelined { super }
    end
  end

  def digest
    super if @use_base
  end

  def switch_to(*)
    super if @use_base
  end

  def full_reload
    return super if @use_base
    @current.flushdb
  end

  private

  def safe_call
    begin
      yield
    rescue Redis::InheritedError => exc
      if @reconnected
        redis_conn_failed(exc)
      else
        direct_reconnect and retry
      end
    rescue => exc
      redis_conn_failed(exc)
    end
  end

  def direct_reconnect
    @current.client.reconnect
    @reconnected = true
  end

  def redis_conn_failed(exception)
    @use_base = true
    @store = {}
    reload!
    init(FastGettext.locale)

    Rails.logger.tagged('Redis Connection Failed') do
      Rails.logger.error(exception.class.to_s)
      Rails.logger.error(exception.message)
    end
  end
end
