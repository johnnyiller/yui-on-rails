module ActionView
  module Helpers
    module PrototypeHelper
      def link_to_remote(name, options = {}, html_options = nil)
        #myopts = {}
        [:before,:after,:loading, :loaded, :interactive,:success,:failure,:complete].each do |symb|
          options.merge!({symb=>"yui_default_#{symb.to_s}()"}) unless options.keys.include?(symb)
        end
        #options.merge!({:before=>"default_before()",:complete=>"alert('completed')"})
        link_to_function(name, remote_function(options), html_options || options.delete(:html))
      end
      def form_remote_tag(options = {}, &block)
        [:before,:after,:loading, :loaded, :interactive,:success,:failure,:complete].each do |symb|
          options.merge!({symb=>"yui_default_#{symb.to_s}()"}) unless options.keys.include?(symb)
        end
        options[:form] = true
        options[:html] ||= {}
        options[:html][:onsubmit] =
          (options[:html][:onsubmit] ? options[:html][:onsubmit] + "; " : "") +
          "#{remote_function(options)}; return false;"

        form_tag(options[:html].delete(:action) || url_for(options[:url]), options[:html], &block)
      end
    end
  end
end