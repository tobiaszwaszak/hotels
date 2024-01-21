namespace :hotels do
  desc "Imports all hotel information"
  task :import => :environment do
    Actions::Hotels::Import.new.call
  end
end
