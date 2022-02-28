# !/usr/bin/env ruby

module HMap
  class HMapConstructor
    def initialize
      @bucket = Hash.new
    end

    # header_mapping : [Hash{FileAccessor => Hash}] Hash of file accessors by header mappings.
    def add_hmap_with_header_mapping(header_mapping, target_name = nil)
      #puts 'add_hmap_with_header_mapping--- start ' +  target_name
      header_mapping.each do |accessor, headers|
        headers.each do |key, paths|
          paths.each do |path|
            pn = Pathname.new(path)
            basename = pn.basename.to_s
            dirname = pn.dirname.to_s + '/'
            # construct hmap hash info
            bucket = Hash['suffix' => basename, 'prefix' => dirname]
            # puts 'prefix: ' + dirname + ' suffix: '+ basename
            # prefix: /Users/styf/Downloads/meituan/MyAPP/MyMainAPP/Pods/SDWebImage/SDWebImage/Private/ suffix: SDAsyncBlockOperation.h
            # 不能打开$use_strict_mode，开了就hmap
            if $use_strict_mode == false
              @bucket[basename] = bucket
            end
            if target_name != nil
              @bucket["#{target_name}/#{basename}"] = bucket
            end
          end
        end
      end
      #puts 'add_hmap_with_header_mapping--- end ' +  target_name
    end

    # @path : path/to/xxx.hmap
    # @return : success
    def save_to(path)
      if path != nil && @bucket.empty? == false
        pn = Pathname(path)
        json_path = pn.dirname.to_s + '/temp.json'
        # write hmap json to file
        File.open(json_path, 'w') { |file| file << @bucket.to_json }
        # json to hmap
        # 记得安装命令 https://github.com/milend/hmap

        success = system("hmap-v1.0.4/hmap convert #{json_path} #{path}")
        #success = system("hmap convert #{json_path} #{path}")
        # delete json file
        File.delete(json_path)
        success
      else
        false
      end
    end
  end
end
