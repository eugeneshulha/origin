namespace :db do
  desc 'Re-create database'
  task :rebuild do
    %i[drop create migrate seed].each do |task|
      Rake::Task["db:#{task}"].invoke
    end
  end
end

namespace :users do
  desc 'Remove stale jwt tokens'
  task remove_stale_tokens: :environment do
    CorevistAPI::JwtToken.where('refresh_exp < ?', Time.now.utc).delete_all
    CorevistAPI::JWTBlacklist.where('exp < ?', Time.now.utc).delete_all
  end
end
