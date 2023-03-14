list = File.open('list.md', 'w')
pin = File.open('pin.sh', 'w')

File.foreach('convert/dst/list.csv') {|l|
  r = l.strip.split(',')
  (fn, cid) = r
  list.print <<-EOS
1. [#{fn} ipfs:#{cid}](https://viewer.copc.io/?copc=https://smb.optgeo.org/ipfs/#{cid})
  EOS
  pin.print <<-EOS
ipfs pin add --progress #{cid}
  EOS
}

list.close
pin.close
