module FormtasticBootstrap
  module Inputs
    module Base
      module Hints
        
        include Formtastic::Inputs::Base::Hints

        def hint_html(inline_or_block = :inline)
          if hint?
            hint_class = if inline_or_block == :inline
              options[:hint_class] || builder.default_inline_hint_class
            else
              options[:hint_class] || builder.default_block_hint_class
            end
            hint_tag = inline_or_block == :inline ? :span : :p
            template.content_tag(
              hint_tag, 
              Formtastic::Util.html_safe(hint_text), 
              :class => hint_class
            )
          end
        end

      end
    end
  end
end

