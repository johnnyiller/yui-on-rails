module YuiOnRails
  module RadioButtons
    def radio_buttons_for(name,*options, &block)
      radio_buttons = YuiOnRails::RadioButtons::RadioButtonsRenderer.new(name,*options, &block)
      radios_html = radio_buttons.render
      return concat(radios_html)
    end
    
    class RadioButtonsRenderer
    
      def initialize(name, options={}, &block )
        raise ArgumentError, "Missing block" unless block_given?
        @template = eval( 'self', block.binding )
        @options = options
        @name = name
        @radio_buttons = []
        yield self
      end
      
      def create(button_text,options={})
        raise "You must provide a button name dummy.#CREATE" if button_name.blank?
        @radio_buttons << [button_text, options]
      end
      
      def render
        content_tag(:div,render_bodies,{:id=>"button_group", :class=>"yui-buttongroup"}.merge(@options))
      end
      
      private # ---------------------------------------------------------------------------
      def render_bodies
        #content_tag :div, :class=>"yui-content" do
          @radio_buttons.collect do |radio_button|
            radio_button_tag(@name, radio_button[0], false, radio_button[1])
          end.join.to_s
        #end
      end
      def method_missing( *args, &block )
        @template.send( *args, &block )
      end
      
    end
  end
end