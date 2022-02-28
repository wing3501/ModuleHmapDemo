
require 'cocoapods-hmap-prebuilt/hmap_writer'
require 'cocoapods-hmap-prebuilt/pod_context_hook'

module HMapPrebuiltHook
  Pod::HooksManager.register('cocoapods-hmap-prebuilt', :post_install) do |context|
    HMap::HMapFileWriter.new(context)
  end
  Pod::HooksManager.register('cocoapods-hmap-prebuilt', :post_update) do |context|
    HMap::HMapFileWriter.new(context)
  end
end
