namespace :db do
  desc 'Re-create database'
  task :rebuild do
    %i[drop create migrate].each do |task|
      Rake::Task["db:#{task}"].invoke
    end

    Rake::Task["app:db:seed"].invoke
  end
end

namespace :users do
  desc 'Remove stale jwt tokens'
  task remove_stale_tokens: :environment do
    CorevistAPI::JwtToken.where('refresh_exp < ?', Time.now.utc).delete_all
    CorevistAPI::JWTBlacklist.where('exp < ?', Time.now.utc).delete_all
  end
end

namespace :translations do
  desc 'Empty translations table'
  task clear: :environment do
    num = CorevistAPI::Translation.delete_all
    puts "#{num} translations have been removed from database"
  end


  desc 'Reset translations table'
  task reset: :environment do
    Rake::Task["app:translations:clear"].invoke

    default_translation_files = Dir[*File.join(CorevistAPI::Engine.root, "/config/locales/default.*.yml")]

    default_translation_files.each do |t_file|
      translations = YAML.load(File.read(t_file))
      locale = translations.keys.first
      translations[locale].each do |k, v|

        CorevistAPI::Translation.create!(
            key: k,
            df_translation: v,
            locale: locale,
            microsite_id: nil,
            cst_translation: nil,
            status: 1
        )
      end
    end

    num = CorevistAPI::Translation.count
    puts "#{num} translations have been created in database"
  end
end
