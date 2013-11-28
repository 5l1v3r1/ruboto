require 'ruboto/activity'
require 'ruboto/widget'

ruboto_import_widgets :Button, :LinearLayout, :ScrollView, :TextView

class NavigationActivity
  def onCreate(bundle)
    super
    set_title File.basename(__FILE__).chomp('_activity.rb').split('_').map { |s| "#{s[0..0].upcase}#{s[1..-1]}" }.join(' ')

    self.content_view =
        linear_layout :orientation => :vertical, :gravity => :center_horizontal do
          text_view :text => 'Navigation', :id => 42, :layout => {:width => :match_parent},
                    :gravity => :center, :text_size => 48.0
          scroll_view :layout => {:weight= => 1} do
            linear_layout :orientation => :vertical do
              button :text => 'Java backed by Java class', :layout => {:width => :match_parent}, :id => 43, :on_click_listener => proc { java_backed_by_java_class }
              button :text => 'Java backed by Ruby class', :layout => {:width => :match_parent}, :id => 44, :on_click_listener => proc { java_backed_by_ruby_class }
              button :text => 'Java backed by script name', :layout => {:width => :match_parent}, :id => 45, :on_click_listener => proc { java_backed_by_script_name }
              button :text => 'Inline block', :layout => {:width => :match_parent}, :id => 46, :on_click_listener => proc { start_inline_activity }
              button :text => 'Inline block with options', :layout => {:width => :match_parent}, :id => 47, :on_click_listener => proc { start_inline_activity_with_options }
              button :text => 'Infile class', :layout => {:width => :match_parent}, :id => 48, :on_click_listener => proc { start_infile_activity }
              button :text => 'Ruby file activity', :layout => {:width => :match_parent}, :id => 49, :on_click_listener => proc { start_ruby_file_activity }
              button :text => 'RubotoActivity no config', :layout => {:width => :match_parent}, :id => 50, :on_click_listener => proc { start_ruboto_activity_no_config }
              button :text => 'RubotoActivity', :layout => {:width => :match_parent}, :id => 51, :on_click_listener => proc { start_ruboto_activity('RubyFileActivity') }
              button :text => 'RubotoActivity with Extras', :layout => {:width => :match_parent}, :id => 52, :on_click_listener => proc { start_ruboto_activity('RubyFileActivity', :extras => {:extra_string => 'Started with string extra.'}) }
            end
          end
        end
  end

  private

  def java_backed_by_java_class
    i = android.content.Intent.new
    i.setClassName($package_name, 'org.ruboto.test_app.NavigationTargetActivity')
    startActivity(i)
  end

  def java_backed_by_ruby_class
    i = android.content.Intent.new
    i.setClassName($package_name, 'org.ruboto.RubotoActivity')
    i.putExtra(Ruboto::CLASS_NAME_KEY, 'NavigationTargetActivity')
    startActivity(i)
  end

  def java_backed_by_script_name
    i = android.content.Intent.new
    i.setClassName($package_name, 'org.ruboto.RubotoActivity')
    i.putExtra(Ruboto::SCRIPT_NAME_KEY, 'navigation_target_activity.rb')
    startActivity(i)
  end

  def start_inline_activity
    start_ruboto_activity do
      def onCreate(bundle)
        super
        set_title 'Inline Activity'
        self.content_view =
            linear_layout :orientation => :vertical, :gravity => :center_horizontal do
              text_view :text => 'This is an inline activity.', 
                        :id => 42, :layout => {:width => :match_parent},
                        :gravity => :center, :text_size => 48.0
            end
      end
    end
  end

  def start_inline_activity_with_options
    start_ruboto_activity(:class_name => 'InlineActivity') do
      def onCreate(bundle)
        super
        set_title 'Inline Activity'
        self.content_view =
            linear_layout :orientation => :vertical, :gravity => :center_horizontal do
              text_view :text => 'This is an inline activity.', 
                        :id => 42, :layout => {:width => :match_parent},
                        :gravity => :center, :text_size => 48.0
            end
      end
    end
  end

  def start_infile_activity
    i = android.content.Intent.new
    i.setClassName($package_name, 'org.ruboto.RubotoActivity')
    i.putExtra(Ruboto::CLASS_NAME_KEY, 'InfileActivity')
    startActivity(i)
  end

  def start_ruby_file_activity
    i = android.content.Intent.new
    i.setClassName($package_name, 'org.ruboto.RubotoActivity')
    i.putExtra(Ruboto::CLASS_NAME_KEY, 'RubyFileActivity')
    startActivity(i)
  end

  def start_ruboto_activity_no_config
    i = android.content.Intent.new
    i.setClassName($package_name, 'org.ruboto.RubotoActivity')
    startActivity(i)
  end

end

class InfileActivity
  def onCreate(bundle)
    super
    set_title 'Infile Activity'
    self.content_view =
        linear_layout :orientation => :vertical, :gravity => :center_horizontal do
          text_view :text => 'This is an infile activity.', 
                    :id => 42, :layout => {:width => :match_parent},
                    :gravity => :center, :text_size => 48.0
        end
  end
end
