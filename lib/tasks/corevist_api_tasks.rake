require 'optparse'

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

  desc 'Activate a user'
  task populate_formats: :environment do
    users = CorevistAPI::User.where(date_format: nil).or(CorevistAPI::User.where(time_format: nil)).or(
        CorevistAPI::User.where(number_format: nil)
    )

    num = users.count do |user|
      %i[date_format time_format number_format].each do |field|
        user.send("#{field}=", Settings.send(field.to_s.pluralize).to_h.values.first) if user.read_attribute(field).blank?
      end

      next unless user.changed?
      user.save
    end

    puts "#{num} users were updated."
  end

  desc 'Activate a user'
  task activate: :environment do
    options = {}
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: rake app:users:activate [options]"
      opts.on("-u", "--user ARG", String) { |u| options[:user] = u }
    end

    parser.parse!
    parser.parse!

    abort('please specify a user') if options[:user].blank?

    user = CorevistAPI::User.find_by(username: options[:user])
    abort('user is not found') unless user

    user.active = true
    puts user.save ? "User #{user.username} activated!" : 'Error during activation'

    exit
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
        next if v.blank?

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

  desc 'Reset translations table'
  task create: :environment do
    default_translation_files = Dir[*File.join(CorevistAPI::Engine.root, "/config/locales/default.*.yml")]

    begin
      default_translation_files.each do |t_file|
        translations = YAML.load(File.read(t_file))
        locale = translations.keys.first
        translations[locale].each do |k, v|
          next if v.blank?

          @translation = CorevistAPI::Translation.find_or_initialize_by(key: k, locale: locale) do |t|
            t.df_translation =  v
            t.microsite_id = nil
            t.cst_translation = nil
            t.status = 1
          end

          @translation.save!
        end
      end

    rescue ActiveRecord::RecordNotSaved => e
      puts "There was in issue with translation key: #{@translation.key}, tr: #{@translation.df_translation}"
      puts e.message
    end

    num = CorevistAPI::Translation.count
    puts "#{num} translations have been created in database"
  end
end

namespace :permissions do
  desc 'Remove all permissions in database'
  task clear: :environment do
    num = CorevistAPI::Permission.delete_all
    puts "#{num} permissions have been removed from database"
  end

  desc 'Create permissions in database'
  task create: :environment do
    file = File.join(CorevistAPI::Engine.root, "/config/permissions.yml")

    permissions = YAML.load(File.read(file))['permissions']
    permissions.each do |title|
      permission = CorevistAPI::Permission.find_or_initialize_by(title: title)
      next unless permission.new_record?

      permission.save!
      puts "Permission #{title} created!"
    end
  end

  desc 'Recreate permissions in database'
  task reset: :environment do
    Rake::Task["app:permissions:clear"].invoke
    Rake::Task["app:permissions:create"].invoke

    num = CorevistAPI::Permission.count
    puts "#{num} permissions have been recreated in database"
  end

  desc 'add a permission to a user'
  task add: :environment do
    options = {}
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: rake app:permissions:add [options]"
      opts.on("-u", "--user ARG", String) { |u| options[:user] = u }
      opts.on("-p", "--permission ARG", String) { |p| options[:permission] = p }
    end

    parser.parse!
    parser.parse!

    abort('please specify both user AND permission to assign') if options[:user].blank? && options[:permission].blank?

    user = CorevistAPI::User.find_by(username: options[:user])
    abort('user not found') unless user

    permission = CorevistAPI::Permission.find_by(title: options[:permission])
    abort('permission not found') unless permission

    role = user.roles.first
    abort('user does not have any role assigned') unless role
    abort('permissions is already assigned') if role.permissions.include?(permission)

    role.permissions << permission
    puts "Permission #{permission.title} has been added to user #{user.name} to role #{role.title}"
    exit
  end

  desc 'remove permission a permission from a user'
  task remove: :environment do
    options = {}
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: rake app:permissions:remove [options]"
      opts.on("-u", "--user ARG", String) { |u| options[:user] = u }
      opts.on("-p", "--permission ARG", String) { |p| options[:permission] = p }
    end

    parser.parse!
    parser.parse!

    abort('please specify both user AND permission to assign') if options[:user].blank? && options[:permission].blank?

    user = CorevistAPI::User.find_by(username: options[:user])
    abort('user not found') unless user

    permission = CorevistAPI::Permission.find_by(title: options[:permission])
    abort('permission not found') unless permission

    removed = nil
    user.roles.each do |role|
      role.permissions.delete(permission) and (removed = true) if role.permissions.include?(permission)
      puts "Permission #{permission.title} has been removed from user #{user.name} from role #{role.title}"
    end

    abort('The user does not have the permission') unless removed
    exit
  end
end

namespace :sap_downtimes do
  desc 'Delete all SAP downtimes'
  task clear: :environment do
    size = CorevistAPI::SAPDowntime.delete_all
    puts "#{size} donwtimes has been removed"
  end
end
