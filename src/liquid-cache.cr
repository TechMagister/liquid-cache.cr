require "liquid"

require "./liquid-cache/version"
require "./liquid-cache/redis"

module Liquid::Cache
  BLOCK_REGEXP = /^\s*cache (?<var>#{Liquid::Block::VAR})/
end
