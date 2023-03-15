require 'json'
require 'tmpdir'

json = JSON.parse(File.open('list.json').read)
count = 0
skip = true
json['result'].each {|k, v|
  count += 1
  Dir.mktmpdir {|dir|
    path = v['path']
    url = "https://opennagasaki.nerc.or.jp/storage/" +
      path.sub('data/', '') + '.zip'
    dst_path = "#{dir}/#{url.split('/')[-1]}"
    out_path = "dst/#{File.basename(dst_path.sub('_org', '').sub('.las.zip', '.copc.laz'))}"
skip = false if out_path == "dst/01ke3543.copc.laz"
next if skip
    #next if File.exist?(out_path)
    pipeline = [
      "#{dst_path.sub('.zip', '')}",
      {
        :type => 'filters.reprojection',
        :in_srs => 'EPSG:6669',
        :out_srs => 'EPSG:3857'
      },
      {
        :type => 'writers.copc',
        :filename => "#{out_path}"
      }
    ]
    cmd = <<-EOS
curl -o #{dst_path} #{url}
unzip -d #{dir} #{dst_path}
echo '#{JSON.dump(pipeline)}' | pdal pipeline -s
    EOS
    print "[#{count}] #{Time.now}\n"
    print cmd
    system(cmd)
  }
}

