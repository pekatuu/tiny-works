#!/usr/bin/ruby
WIDTH = 20
SLEEP = 1
def get_proc
  open("/proc/stat", "r"){|f|f.gets}.strip.split.drop(1).map(&:to_f) 
end

p = 0
a = get_proc
sleep SLEEP
b = get_proc
idle = 0
b.zip(a).map{|d,c| d - c}.tap{|r| idle = r[3]}.reduce(:+).tap{|t| p = 1 - idle/t}

a =  `free`.split("\n")[1].split.map(&:to_f)
b = 1 - a[3] / a[1]

def gen_bar(prefix, used, color = "ww")
  color_start = WIDTH - (WIDTH * used).round
  percent = "#{format("% 3d", used * 100)}%"
  base = prefix + percent + ' ' * (WIDTH - prefix.size - percent.size)
  unless color_start >= WIDTH
    base[color_start] = "\005{= #{color}}#{base[color_start].chr}"
  end
  "[#{base}\005{-}]"
end

print "#{gen_bar("CPU:", p, "bw")}  #{gen_bar("MEM:", b, "gw")}"
