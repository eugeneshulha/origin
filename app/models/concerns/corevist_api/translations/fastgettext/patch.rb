module CorevistAPI::GettextPatch
  delegate :key_class, :fetchers, :used_translations, to: CorevistAPI::Translation
  include CorevistAPI::Translations::Cache::Redis
end

FastGettext::Cache.prepend CorevistAPI::GettextPatch
Thread.current[:fast_gettext_cache] = FastGettext::Cache.new
