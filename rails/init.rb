require File.join(File.dirname(__FILE__), *%w[.. lib yui-on-rails])
ActionView::Base.send :include, YuiOnRails::Tabs