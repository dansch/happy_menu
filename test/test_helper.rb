require 'rubygems'
require 'test/unit'
require 'action_controller'
require 'action_view'
require 'action_controller/test_case'
require 'action_view/test_case'

require File.expand_path(File.join(File.dirname(__FILE__), '../lib/happy_menu'))


module HappyMenuTestHelper
  # include ActionView::Helpers::FormHelper
  # include ActionView::Helpers::FormTagHelper
  # include ActionView::Helpers::FormOptionsHelper
  # include ActionView::Helpers::UrlHelper
  # include ActionView::Helpers::TagHelper
  # include ActionView::Helpers::TextHelper
  # include ActionView::Helpers::ActiveRecordHelper
  # include ActionView::Helpers::RecordIdentificationHelper
  # include ActionView::Helpers::CaptureHelper
  # include ActiveSupport
  # include ActionController::PolymorphicRoutes
  
  include HappyMenu::Base
  
  class ::Project
    def id
    end
  end
  
  def mock_everything
    
    # Resource-oriented styles like form_for(@post) will expect a path method for the object,
    # so we're defining some here.
    def project_path(o); "/projects/1"; end
    def projects_path; "/projects"; end

    def user_path(o); "/users/1"; end
    def users_path; "/users"; end
    
  end
  
end
