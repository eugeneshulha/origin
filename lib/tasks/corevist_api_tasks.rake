namespace :db do
  desc 'Re-create database'
  task :rebuild do
    %i[drop create migrate seed].each do |task|
      Rake::Task["db:#{task}"].invoke
    end
  end
end
