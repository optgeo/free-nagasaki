File.open('list.md', 'w') {|w|
  File.foreach('convert/dst/list.csv') {|l|
    r = l.strip.split(',')
    w.print <<-EOS
1. [#{r[0]} ipfs:#{r[1]}](https://viewer.copc.io/?copc=https://smb.optgeo.org/ipfs/#{r[1]})
    EOS
  }
}

