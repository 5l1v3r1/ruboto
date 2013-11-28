class NavigationTargetActivity
  def onCreate(bundle)
    super
    set_title 'Navigation Target Activity'

    self.content_view =
        linear_layout :orientation => :vertical, :gravity => :center_horizontal do
          text_view :text => 'This is the navigation target activity.', 
                    :id => 42, :layout => {:width => :match_parent},
                    :gravity => :center, :text_size => 48.0
        end
  end
end
