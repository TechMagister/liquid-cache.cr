require "liquid"
require "../src/liquid-cache/redis"

require "benchmark"

template = Liquid::Template.parse File.read("./bench/template.liquid")
cached =  Liquid::Template.parse File.read "./bench/cached.liquid"
ctx = Liquid::Context.new
ctx.set "myarray", (0..1000).to_a

Benchmark.ips do |x|
  x.report("without cache") do
    template.render ctx
  end

  x.report("with redis cache") do
    cached.render ctx
  end
end
