require "../liquid-cache"
module Liquid::Cache
  abstract class Base < BeginBlock
    getter var : String

    def initialize(str : String)
      if match = str.match(Liquid::Cache::BLOCK_REGEXP)
        @var = match["var"]
      else
        raise Liquid::InvalidNode.new "Invalid cache block : {% #{str} %}"
      end
    end
  end
end
