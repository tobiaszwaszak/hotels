namespace :hotels do
  desc "Imports all hotel information"
  task :import => :environment do
    suppliers = [
      Suppliers::Patagonia.new,
      Suppliers::PaperFlies.new,
      Suppliers::Acme.new
    ]
    Actions::Hotels::Import.new(suppliers: suppliers).call
  end
end
