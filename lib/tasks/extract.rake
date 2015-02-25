namespace :extract do
  desc "Task description"
  task :events => :environment do
    EventExtractor.perform
  end
end
