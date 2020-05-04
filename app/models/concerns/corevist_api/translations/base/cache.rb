module CorevistAPI::Translations::Base::Cache
  delegate :cache, to: FastGettext

  def init_cache
    cache.init(FastGettext.locale)
  end

  def update_cache(translation)
    if translation.persisted? && translation.status == 'active'
      cache_one(translation)
    else
      delete_from_cache(translation)
    end
  end

  # write single translation into cache
  def cache_one(translation)
    delete_from_cache(translation) if translation.cache_key.present?
    cache.write(translation.cache_key(init: true), translation.value)
  end

  # delete single translation from cache
  def delete_from_cache(translation)
    cache.delete(translation.cache_key)
  end

  # method for reloading cache, it will clear cache for all locales and initialize it for current one
  def reload_cache
    cache.full_reload
    init_cache
  end

  # checks if user languge is already cached
  def cached?
    cache.cached?(FastGettext.locale)
  end

  def cache_digest
    cache.digest
  end
end
