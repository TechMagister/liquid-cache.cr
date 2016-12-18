require "./spec_helper"

describe Liquid::Cache do

  it "should register the cache node" do
    Liquid::BlockRegister.for_name("cache").should_not be_nil
  end

  it "should render the cache node and cache it" do
    txt = "{%cache array%}Do stuff : {% for x in array %} Yes : {{x}}{%endfor%}{% endcache%}"
    tpl = Liquid::Template.parse txt
    ctx = Liquid::Context.new
    var = (0..10).to_a
    ctx.set "array", var
    tpl.render(ctx).should eq("Do stuff :  Yes : 0 Yes : 1 Yes : 2 Yes : 3 Yes : 4 Yes : 5 Yes : 6 Yes : 7 Yes : 8 Yes : 9 Yes : 10")

    Liquid::Cache::RedisCache.is_cached?(var.hash).should be_true

  end

end
