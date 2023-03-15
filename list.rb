list = File.open('list.md', 'w')
pin = File.open('pin.sh', 'w')
rmpin = File.open('rmpin.sh', 'w')

count = 0
File.foreach('convert/dst/list.csv') {|l|
  count += 1
  r = l.strip.split(',')
  (fn, cid) = r
  list.print <<-EOS
1. [#{fn} ipfs:#{cid}](https://viewer.copc.io/?copc=https://smb.optgeo.org/ipfs/#{cid})
  EOS
  pin.print <<-EOS
echo [#{count}] adding #{fn} - #{cid}
ipfs pin add --progress #{cid}
  EOS
  rmpin.print <<-EOS
echo [#{count}] removing #{fn} - #{cid}
ipfs pin rm #{cid}
  EOS
}

list.close
pin.close
rmpin.close
