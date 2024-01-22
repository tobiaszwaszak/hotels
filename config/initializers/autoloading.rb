module Serializers; end
module Actions; end
module Repositories; end
module Suppliers; end

Rails.autoloaders.main.push_dir("#{Rails.root}/app/serializers", namespace: Serializers)
Rails.autoloaders.main.push_dir("#{Rails.root}/app/actions", namespace: Actions)
Rails.autoloaders.main.push_dir("#{Rails.root}/app/repositories", namespace: Repositories)
Rails.autoloaders.main.push_dir("#{Rails.root}/app/suppliers", namespace: Suppliers)
