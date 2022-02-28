require 'cocoapods'
require_relative 'hmap_constructor'
require_relative 'pod_xcconfig'
require_relative 'pod_target'
require_relative 'podfile_dsl'
require_relative 'pod_context_hook'

module HMap
  class HMapFileWriter
    def initialize(context)
      hmap_dir = context.sandbox_root + '/Headers/HMap'
      aggregate_targets = context.aggregate_targets
      FileUtils.rm_rf(hmap_dir) if File.exist?(hmap_dir)
      Dir.mkdir(hmap_dir)
      puts '目标hmap路径：' + hmap_dir
      gen_hmapfile(aggregate_targets, hmap_dir)
    end

    def gen_hmapfile(aggregate_targets, hmap_dir)
      aggregate_targets.each do |aggregate_target| # Pod::AggregateTarget
        pods_hmap = HMap::HMapConstructor.new   #hmapfile of target :Pods-MyMainAPP
        aggregate_target.pod_targets.each do |target|
          #puts 'target.name:' + target.name
          #处理lottie-ios  Lottie 这种名称不一致的情况
          # 导致生成的hmap为 lottie-ios/xxx.h    实际项目中使用的是 <Lottie/Lottie.h>
          target_name = target.name
          product_module_name = target.product_module_name
          if target_name != product_module_name
            target_name = product_module_name
          end

          pods_hmap.add_hmap_with_header_mapping(target.public_header_mappings_by_file_accessor, target_name)

          unless $skip_hmap_for_pods.include?(target.name)
            target_hmap = HMap::HMapConstructor.new
            dependent_target_header_search_path_setting = Array.new
            #写入tartet自己的头文件路径
            target_hmap.add_hmap_with_header_mapping(target.header_mappings_by_file_accessor, target_name)

            #遍历所有依赖的target
            target.dependent_targets.each do |dependent_target|
              #依赖的target头文件路径写入target_hmap

              #处理lottie-ios  Lottie 这种名称不一致的情况
              dependent_target_name = dependent_target.name
              dependent_target_product_module_name = dependent_target.product_module_name
              if dependent_target_name != dependent_target_product_module_name
                dependent_target_name = dependent_target_product_module_name
              end
              
              target_hmap.add_hmap_with_header_mapping(dependent_target.public_header_mappings_by_file_accessor, dependent_target_name)
              #收集 依赖的target的xconfig里的HEADER_SEARCH_PATHS的特殊路径到dependent_target_header_search_path_setting
              # 比如这种 ${PODS_ROOT}/TXIMSDK_iOS/TXIMSDK_iOS/ImSDK.framework/Headers/
              dependent_target.build_settings.each do |config, setting|
                dependent_target_xcconfig = setting.xcconfig
                dependent_target_header_search_paths = dependent_target_xcconfig.attributes['HEADER_SEARCH_PATHS']
                #排除${PODS_ROOT}/Headers和$(inherited)之外的特殊路径
                dependent_target_header_search_paths.split(' ').each do |path|
                  unless (path.include?('${PODS_ROOT}/Headers') || path.include?('$(inherited)'))
                    dependent_target_header_search_path_setting << path
                  end
                end
              end
              #收集了一些特殊路径
              target.dependent_target_header_search_path_setting = dependent_target_header_search_path_setting.uniq
            end

            target_hmap_name = "#{target.name}-prebuilt.hmap"
            target_hmap_path = hmap_dir + "/#{target_hmap_name}"
            relative_hmap_path = "Headers/HMap/#{target_hmap_name}"
            if target_hmap.save_to(target_hmap_path)
              puts "- hmapfile of target :#{target.name} save to :#{target_hmap_path}".yellow
              target.reset_header_search_with_relative_hmap_path(relative_hmap_path)
            else
              puts "hmap写入失败---" + target_hmap_path
              $fail_generate_hmap_pods << target.name
            end
          else
            puts "- skip generate hmapfile of target :#{target.name}"
          end
        end

        pods_hmap_name = "#{aggregate_target.name}-prebuilt.hmap"
        pods_hmap_path = hmap_dir + "/#{pods_hmap_name}"
        relative_hmap_path = "Headers/HMap/#{pods_hmap_name}"
        if pods_hmap.save_to(pods_hmap_path)
          puts "- hmapfile of target :#{aggregate_target.name} save to :#{pods_hmap_path}".green
          aggregate_target.reset_header_search_with_relative_hmap_path(relative_hmap_path)
        end
      end
    end
  end
end
