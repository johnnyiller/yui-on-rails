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
      
      def create(tab_id,tab_text,options={},&block)
        raise "Block needed for TabsRenderer#CREATE" unless block_given?
        @tabs << [ tab_id, tab_text, options, block ]
      end
      
      def render
        content_tag(:div,(render_tabs+render_bodies),{:id=>:tabs, :class=>"tabber"}.merge(@options))
      end
      
      private # ---------------------------------------------------------------------------
      def render_tabs
        content_tag :ul, :class=>"yui-nav" do
          @tabs.collect do |tab|
            content_tag(:li,link_to(content_tag(:em, tab[1] ), "##{tab[0]}"))
          end.join
        end
      end

      def render_bodies
        content_tag :div, :class=>"yui-content" do
          @tabs.collect do |tab|
            content_tag(:div,capture(&tab[3]),tab[2].merge(:id => tab[0]))
          end.join.to_s
        end
      end

      def method_missing( *args, &block )
        @template.send( *args, &block )
      end
    end
    
    
      #@@tab_content = []
      #@@tab_titles = []
    
      #def yui_tabs(id,&block)
      #  raise ArgumentError, "Missing block" unless block_given?
      #  capture(&block)
      #  concat(content_tag(:div, :class=>"yui-navset tabber", :id=>id) do
      #    content_tag(:ul, yui_get_links, :class=>"yui-nav")+content_tag(:div,yui_get_content,:class=>"yui-content")
      #  end,block.binding)  
      #  @@tab_content = []
      #  @@tab_titles = []
      #end
      #def yui_get_links
      #  links = ""
      #  @@tab_titles.each_with_index do |title,index|
      #    links += content_tag(:li,link_to(content_tag(:em, title), "#tab#{index}"),:class=>"#{index==0 ? "selected" : ""}")
      #  end
      #  return links
      #end
      #def yui_get_content
      #  content = ""
      #  @@tab_content.each_with_index do |cont, index|
      #    content += content_tag(:div, cont.to_s, :id=>"tab#{index}")
      #  end
      #  return content
      #end
      #def yui_tab(title, &block)
      #  raise ArgumentError, "Missing block" if title.blank?
      #  raise ArgumentError, "Missing block" unless block_given?
      #  @@tab_content << capture(&block)
      #  @@tab_titles << title
      #end
  end
end