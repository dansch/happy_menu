require 'happy_menu/base'
require 'happy_menu/selector'

class ActionView::Base
  include HappyMenu::Base
end