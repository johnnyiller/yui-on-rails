# FlickadayYui
module YuiOnRails
  module Tabs
    def tabs_for(*options, &block)
      tabs = YuiOnRails::Tabs::TabsRenderer.new(*options, &block)
      tabs_html = tabs.render
      return concat(tabs_html)
    end
    
    class TabsRenderer
    
      def initialize( options={}, &block )
        raise ArgumentError, "Missing block" unless block_given?
        @template = eval( 'self', block.binding )
        @options = options
        @tabs = []
        yield self
      end
      
      def create(tab_id,tab_text,li_options={},options={},&block)
        raise "Block needed for TabsRenderer#CREATE" unless block_given?
        @tabs << [ tab_id, tab_text, options, block, li_options ]
      end
      
      def render
        content_tag(:div,(render_tabs+render_bodies),{:id=>:tabs, :class=>"tabber"}.merge(@options))
      end
      
      private # ---------------------------------------------------------------------------
      def render_tabs
        content_tag :ul, :class=>"yui-nav" do
          @tabs.collect do |tab|
            content_tag(:li,link_to(content_tag(:em, tab[1]), "##{tab[0]}"),tab[4])
          end.reduce(&:+)
        end
      end

      def render_bodies
        content_tag :div, :class=>"yui-content" do
          @tabs.collect do |tab|
            content_tag(:div,capture(&tab[3]),tab[2].merge(:id => tab[0]))
          end.reduce(&:+)
        end
      end

      def method_missing( *args, &block )
        @template.send( *args, &block )
      end
    end
  end
end