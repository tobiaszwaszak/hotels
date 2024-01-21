module Serializers; end
module Actions; end

Rails.autoloaders.main.push_dir("#{Rails.root}/app/serializers", namespace: Serializers)
Rails.autoloaders.main.push_dir("#{Rails.root}/app/actions", namespace: Actions)
