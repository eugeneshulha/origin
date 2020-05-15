class PopulateDefaultTranslations < ActiveRecord::Migration[5.2]
  def up
    require 'pry-byebug'
    binding.pry

    default_translation_files = Dir[*File.join(CorevistAPI::Engine.root, "/config/locales/default.*.yml")]
    default_translation_files.each do |t_file|
      translations = YAML.load(File.read(t_file))
      locale = translations.keys.first
      translations[locale].each do |k, v|

        CorevistAPI::Translation.find_or_create_by!(
            key: k,
            df_translation: v,
            locale: locale,
            microsite_id: nil,
            cst_translation: nil,
            status: 1
        )
      end
    end
  end

  def down
  end
end
