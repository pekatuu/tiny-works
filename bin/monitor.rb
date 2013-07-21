#!/usr/bin/env ruby
WIDTH = 15
SLEEP = 0.1
def get_proc
  open("/proc/stat", "r"){|f|f.gets}.strip.split.drop(1).map(&:to_f) 
end

p = 0
a = get_proc
sleep SLEEP
b = get_proc
idle = 0
b.zip(a).map{|d,c| d - c}.tap{|r| idle = r[3]}.reduce(:+).tap{|t| p = 1 - idle/t}

free_out =  `free -m`.split("\n")
total = free_out[1].split[1].to_f
used = free_out[2].split[2].to_f
b = used / total

def gen_bar(prefix, used, color = "ww")
  color_start = WIDTH - (WIDTH * used).round
  percent = "#{format("% 4d", used * 100)}%"
  base = prefix + percent + ' ' * (WIDTH - prefix.size - percent.size)

  unless color_start >= WIDTH
    base.insert color_start, "\005{= #{color}}"
  end
  "[#{base}\005{-}]"
end

used_str = "RAM" + format("% 5d", used) + "MB"
print "#{gen_bar("CPU", p, "bW")} #{gen_bar(used_str, b, "gK")}"
