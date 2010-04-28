require File.join(File.dirname(__FILE__), *%w[.. lib yui-on-rails])
ActionView::Base.send :include, YuiOnRails::Tabs
ActionView::Base.send :include, YuiOnRails::RadioButtons
#ActionView::Helpers::PrototypeHelper.send :include, YuiOnRails::PrototypeHelper