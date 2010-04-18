module YuiOnRails
  module PrototypeHelper
    alias :original_link_to_remote :link_to_remote
    
    def link_to_remote(name, options = {}, html_options = nil)
      options.merge!(:before=>"alert('blah blah')")
      original_link_to_remote name, options, html_options
    end
    
  end
end