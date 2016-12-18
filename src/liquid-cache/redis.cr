require "liquid"
require "redis"

require "./base"

Liquid::BlockRegister.register "cache", Liquid::Cache::RedisCache

module Liquid::Cache

  class RedisCache < Base
    @@redis = ::Redis.new

    def self.is_cached?(h : Int64 | Int32)
      @@redis.exists(h)
    end

    def self.get(hash : Int64 | Int32)
      @@redis.get hash
    end

    def self.set(hash : Int64 | Int32, value : String)
      @@redis.set hash, value
    end

  end

end

module Liquid

  class RenderVisitor

    def visit(node : Cache::RedisCache)
      data = @data.get node.var
      hash = data.hash
      if Cache::RedisCache.is_cached? hash
        @io << Cache::RedisCache.get hash
      else
        io = IO::Memory.new
        visitor = RenderVisitor.new @data, io
        node.children.each &.accept(visitor)
        io.close
        result = io.to_s
        Cache::RedisCache.set hash, result
        @io << result
      end
    end

  end

end
