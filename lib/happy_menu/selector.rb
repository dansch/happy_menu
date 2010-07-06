module HappyMenu
  class Selector
    attr_accessor :template, :selectors, :options

    # Selector class to compute actual css_class
    #
    #

    def initialize(template, options, selectors)
      @selectors = selectors.to_a
      @template = template
      @options = options
    end

    def result
      selectors.each do |selector|
        if selector.is_a?(Hash) and template.controller_name.to_sym == selector.keys.first
          if selector.values.first.is_a?(Symbol) and template.action_name.to_sym == selector.values.first
            return options[:active_class]
          elsif selector.values.first.blank?
            return options[:active_class]
          elsif selector.values.first.is_a?(Array) and selector.values.first.include?(template.action_name.to_sym)
            return options[:active_class]
          else
            return options[:inactive_class]
          end
        elsif selector.is_a?(Symbol) or selector.is_a?(String)
          return template.controller_name.to_sym == selector ? options[:active_class] : options[:inactive_class]
        else
          return options[:inactive_class]
        end
      end
    end
  end
end