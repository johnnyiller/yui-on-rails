module YuiOnRails
  module RadioButtons
    def radio_buttons_for(*options, &block)
      radio_buttons = YuiOnRails::RadioButtons::RadioButtonsRenderer.new(*options, &block)
      radios_html = radio_buttons.render
      return concat(radios_html)
    end
    
    class RadioButtonsRenderer
    
      def initialize( options={}, &block )
        raise ArgumentError, "Missing block" unless block_given?
        @template = eval( 'self', block.binding )
        @options = options
        @radio_buttons = []
        yield self
      end
      
      def create(button_name,button_text,options={})
        raise "You must provide a button name dummy.#CREATE" if button_name.blank?
        @radio_buttons << [button_name,button_text, options]
      end
      
      def render
        content_tag(:div,render_bodies,{:id=>"button_group", :class=>"yui-buttongroup"}.merge(@options))
      end
      
      private # ---------------------------------------------------------------------------
      def render_bodies
        #content_tag :div, :class=>"yui-content" do
          @radio_buttons.collect do |radio_button|
            radio_button_tag(radio_button[0], radio_button[1], false, radio_button[2])
          end.join.to_s
        #end
      end
      def method_missing( *args, &block )
        @template.send( *args, &block )
      end
      
    end
  end
end