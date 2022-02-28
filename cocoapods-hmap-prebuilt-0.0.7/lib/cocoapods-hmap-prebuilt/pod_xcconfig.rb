# !/usr/bin/env ruby

module Xcodeproj
  class Config
    def remove_attr_with_key(key)
      if key != nil
        @attributes.delete(key)
      end
    end

    #移除xcconfig中除了特殊路径以外的路径
    def remove_header_search_path
      header_search_paths = @attributes['HEADER_SEARCH_PATHS']
      if header_search_paths
        new_paths = Array.new
        header_search_paths.split(' ').each do |path|
          # 跳过 这些路径
          # 保留了 $(SDKROOT)/usr/include/libxml2 ${PODS_ROOT}/TXIMSDK_iOS/TXIMSDK_iOS/ImSDK.framework/Headers/
          # Pods-target中的"${PODS_CONFIGURATION_BUILD_DIR}/SDCycleScrollView/SDCycleScrollView.framework/Headers"也被保留了
          #
          # 当pod是framework时， 我觉得这些多余的${PODS_CONFIGURATION_BUILD_DIR}/XXX的路径也可以去掉，加速搜索头文件速度
          unless (path.include?('${PODS_ROOT}/Headers/Public') || path.include?('${PODS_ROOT}/Headers/Private') || path.include?('$(inherited)') || path.include?('${PODS_CONFIGURATION_BUILD_DIR}/'))
            new_paths << path
          end
        end
        if new_paths.size > 0
          @attributes['HEADER_SEARCH_PATHS'] = new_paths.join(' ')
        else
          remove_attr_with_key('HEADER_SEARCH_PATHS')
        end
      end
      remove_system_options_in_other_cflags
    end
    #移除xcconfig中除了特殊路径以外的路径
    def remove_system_options_in_other_cflags
      flags = @attributes['OTHER_CFLAGS']
      if flags
        new_flags = ''
        skip = false
        flags.split(' ').each do |substr|
          if skip
            skip = false
            next
          end
          # 跳过-isystem
          #-isystem "${PODS_ROOT}/Headers/Public" -isystem "${PODS_ROOT}/Headers/Public/AFNetworking" -isystem "${PODS_ROOT}/Headers/Public/CaptainHook"
          if substr == '-isystem'
            skip = true
            next
          end
          # 保留了 -iframework "${PODS_ROOT}/Bugly" -iframework "${PODS_ROOT}/BytedanceOpenPlatformSDK"
          if new_flags.length > 0
            new_flags += ' '
          end
          new_flags += substr
        end
        if new_flags.length > 0
          @attributes['OTHER_CFLAGS'] = new_flags
        else
          remove_attr_with_key('OTHER_CFLAGS')
        end
      end
    end

    #重设xcconfig的header search path
    # 1.hmap的路径
    # 2.本target的特殊路径
    # 3.依赖的target的特殊路径
    def reset_header_search_with_relative_hmap_path(hmap_path, dependent_header_search_path_setting = nil)
      remove_header_search_path
      # add build flags
      new_paths = Array.new
      new_paths << "${PODS_ROOT}/#{hmap_path}"
      header_search_paths = @attributes['HEADER_SEARCH_PATHS'] #清理完之后，剩余的一些特殊路径
      if header_search_paths
        new_paths.concat(header_search_paths.split(' '))
      end
      new_paths.concat(dependent_header_search_path_setting) if dependent_header_search_path_setting  #如果本target依赖的的target也有特殊路径，也加入进来
      @attributes['HEADER_SEARCH_PATHS'] = new_paths.join(' ')
    end
    #把Pods-MyMainAPP的hmap路径也加入到每个子Pod的target的headersearchpath中
    def addition_aggregate_hmapfile_to_pod_target(hmap_path)
      new_paths = Array.new
      header_search_paths = @attributes['HEADER_SEARCH_PATHS']
      if header_search_paths
        new_paths.concat(header_search_paths.split(' '))
      end
      new_paths << "${PODS_ROOT}/#{hmap_path}"
      @attributes['HEADER_SEARCH_PATHS'] = new_paths.join(' ')
    end

    def set_use_hmap(use_hmap = false)
      @attributes['USE_HEADERMAP'] = (use_hmap ? 'YES' : 'NO')
    end
  end
end
