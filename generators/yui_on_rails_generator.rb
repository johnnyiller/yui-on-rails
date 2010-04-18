class YuiOnRailsGenerator < Rails::Generator::Base

  def initialize(*runtime_args)
    super
  end
  def manifest
    record do |m|
      m.directory File.join('public','javascripts')
      m.template 'yui_on_rails.js', File.join('public','javascripts','yui_on_rails.js')
    end  
  end
  protected
  def banner
    %{Usage: #{$0} #{spec.name}\nCopies yui_on_rails.css to public/javascripts/}
  end
end