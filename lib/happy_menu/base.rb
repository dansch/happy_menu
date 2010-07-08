module HappyMenu
  module Base
    @@menu_options = {
      :active_class => 'selected',
      :menu_tag => :ul,
      :menu_item_tag => :li,
      :active_link_wrapper => true
    }
    mattr_reader :menu_options

    # creates an outer tag (defaults to ul-Tag)
    # accepcts block, which might contain menu_items or further menus
    # - html_options: must be an hash of html-attributes
    # - menu_options: must be an hash. Can be used to overwrite default values

    def happy_menu(html_options={}, menu_options={}, &block)
      return unless block_given?
      
      updated_menu_options = menu_options.symbolize_keys.reverse_merge HappyMenu::Base.menu_options
      
      html = content_tag updated_menu_options[:menu_tag].to_sym, html_options do
        capture(&block)
      end
      concat(html)
    end


    # creates an inner tag (defaults to li-Tag)
    # accepts block, so can be nested or filled with any html
    # - selectors: must be an array. Can contain Symbols, Strings and/or Hashes. Symbols and Strings will be 
    #              compared to the controller_name. The key of a hash will be compared to the controller_name, the value to the action_name.
    #              Value can either be an array of Symbols or nil for all actions.
    #              E.g. [:users, {:projects => [:index, :edit]}, :tasks]
    # - item_options: html attributes for item tag-element
    # - link_options: html attributes for a-element
    # - menu_options: must be an hash. Can be used to overwrite default values

    def happy_menu_item(item, path, selectors, item_options={}, link_options={}, menu_options={}, &block)
      updated_menu_options = menu_options.symbolize_keys.reverse_merge HappyMenu::Base.menu_options
      
      selector_class = HappyMenu::Selector.new(self, updated_menu_options, selectors).result
      selected = (selector_class == updated_menu_options[:active_class])
      
      if selected
        item_options[:class] = item_options[:class].blank? ? selector_class : item_options[:class].concat(" #{selector_class}")
        link_options[:class] = link_options[:class].blank? ? selector_class : link_options[:class].concat(" #{selector_class}")
      end

      html, inner_html = "", ""
      inner_html = capture(&block) if block_given?

      html += content_tag updated_menu_options[:menu_item_tag].to_sym, item_options do
        if selected and updated_menu_options[:active_link_wrapper]
          content_tag :strong, (link_to(item, path, link_options) + inner_html)
        else
          link_to(item, path, link_options) + inner_html
        end
      end
      html
    end
  end

end