require 'ruboto/widget'

ruboto_import_widgets :LinearLayout, :TextView

class StartupExceptionActivity
  def onCreate(bundle)
    super
    setTitle File.basename(__FILE__).chomp('_activity.rb').split('_').
                 map { |s| "#{s[0..0].upcase}#{s[1..-1]}" }.join(' ')

    self.content_view =
        linear_layout :orientation => :vertical, :gravity => :center do
          @text_view = text_view :id => 42, :text => title, :text_size => 48.0,
                                 :gravity => :center
        end
    intent = android.content.Intent.new
    intent.setClassName($package_name, 'com.example.UndeclaredActivity')
    startActivity(intent)
  rescue Exception
    puts "Expected exception creating activity: #{$!}"
    puts $!.backtrace.join("\n")
  end

  def onResume
    super
    @text_view.text = 'Startup OK'
  end
end
