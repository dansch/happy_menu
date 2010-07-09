require 'test_helper'

class HappyMenuTest < ActionView::TestCase
  include HappyMenuTestHelper
  
  def setup
    mock_everything
  end
  
  test "global settings" do
    assert_equal :ul, HappyMenu::Base.menu_options[:menu_tag]
    assert_equal :li, HappyMenu::Base.menu_options[:menu_item_tag]
    assert_equal 'selected', HappyMenu::Base.menu_options[:active_class]
    assert_equal true, HappyMenu::Base.menu_options[:active_link_wrapper]
  end
  
  test "basic happy_menu" do
    assert_equal "<ul></ul>", happy_menu{}
  end
  
  test "happy_menu with html attributes" do
    expected = "<ul class=\"test_class\" id=\"test_id\"></ul>"
    assert_equal expected, happy_menu({:class => "test_class", :id => "test_id"}){}
  end
  
  test "happy_menu with menu options" do
    expected = "<ol></ol>"
    assert_equal expected, happy_menu({}, {:menu_tag => 'ol'}){}
  end
  
  test "happy_menu with global setting" do
    HappyMenu::Base.menu_options[:menu_tag] = :ol
    expected = "<ol></ol>"
    assert_equal expected, happy_menu{}
    HappyMenu::Base.menu_options[:menu_tag] = :ul
  end
  
  test "basic happy_menu_item" do
    expected = "<li><a href=\"/projects\">Test</a></li>"
    assert_equal expected, happy_menu_item("Test", projects_path, nil)
  end
  
  test "happy_menu_item with html attributes" do
    expected = "<li class=\"test_class\" id=\"test_id\"><a href=\"/projects\">Test</a></li>"
    assert_equal expected, happy_menu_item("Test", projects_path, nil, {:id => "test_id", :class => "test_class"})
  end
  
  test "happy_menu_item with link options" do
    expected = "<li><a href=\"/projects\" id=\"test_id\">Test</a></li>"
    assert_equal expected, happy_menu_item("Test", projects_path, nil, {}, {:id => "test_id"})
  end
  
  test "happy_menu_item with menu options" do
    expected = "<h2><a href=\"/projects\">Test</a></h2>"
    assert_equal expected, happy_menu_item("Test", projects_path, nil, {}, {}, {:menu_item_tag => 'h2'})
  end
  
  test "happy_menu_item with global setting" do
    HappyMenu::Base.menu_options[:menu_item_tag] = :h2
    expected = "<h2><a href=\"/projects\">Test</a></h2>"
    assert_equal expected, happy_menu_item("Test", projects_path, nil, {}, {}, {:menu_item_tag => 'h2'})
    HappyMenu::Base.menu_options[:menu_item_tag] = :li
  end
  
  test "happy_menu_item with submenu" do
    expected = "<li><a href=\"/projects\">Test</a><ul></ul></li>"
    assert_equal expected, happy_menu_item("Test", projects_path, nil){happy_menu{}}
  end
  
  # TODO test for selection (setting the css_class)
  
  #test "happy_menu_item with selection" do
    # stub controller_name
    # expected = "<li><a href=\"/projects\">Test</a></li>"
    # assert_equal expected, happy_menu_item("Test", projects_path, [:projects])
  #end
  
end
