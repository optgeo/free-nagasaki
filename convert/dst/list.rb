def read(path)
  list = {}
  File.foreach(path) {|l|
    r = l.strip.split(',')
    list[r[0]] = r[1]
  }
  list
end

def write(list, path)
  File.open(path, 'w') {|w|
    list.each {|r|
      w.print "#{r.join(',')}\n"
    }
  }
end

list = read('list.csv')
print "initial list size: #{list.size}\n"

Dir.glob("*.copc.laz").sort.each {|fn|
#  next if list[fn]
  next if Time.now - File.mtime(fn) < 60
  r = `ipfs add #{fn}`.split(' ')
  list[r[2]] = r[1]
  write(list, 'list.csv')
}

