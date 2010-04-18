module ActionView
  module Helpers
    module PrototypeHelper
    #alias :original_link_to_remote :link_to_remote
    
      def link_to_remote_with_yui(name, options = {}, html_options = nil)
        options.merge!(:before=>"alert('blah blah')")
        link_to_remote_without_yui(name, options, html_options)
      end
      alias_method_chain :link_to_remote, :yui
    end
  end
end