# FlickadayYui
module YuiOnRails
  module Tabs
      @@tab_content = []
      @@tab_titles = []
    
      def yui_tabs(id,&block)
        raise ArgumentError, "Missing block" unless block_given?
        capture(&block)
        concat(content_tag(:div, :class=>"yui-navset tabber", :id=>id) do
          content_tag(:ul, yui_get_links, :class=>"yui-nav")+content_tag(:div,yui_get_content,:class=>"yui-content")
        end,block.binding)  
        @@tab_content = []
        @@tab_titles = []
      end
      def yui_get_links
        links = ""
        @@tab_titles.each_with_index do |title,index|
          links += content_tag(:li,link_to(content_tag(:em, title), "#tab#{index}"),:class=>"#{index==0 ? "selected" : ""}")
        end
        return links
      end
      def yui_get_content
        content = ""
        @@tab_content.each_with_index do |cont, index|
          content += content_tag(:div, cont.to_s, :id=>"tab#{index}")
        end
        return content
      end
      def yui_tab(title, &block)
        raise ArgumentError, "Missing block" if title.blank?
        raise ArgumentError, "Missing block" unless block_given?
        @@tab_content << capture(&block)
        @@tab_titles << title
      end
  end
end