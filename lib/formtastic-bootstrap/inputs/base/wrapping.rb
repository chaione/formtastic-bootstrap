module FormtasticBootstrap
  module Inputs
    module Base
      module Wrapping

        include Formtastic::Inputs::Base::Wrapping

        def generic_input_wrapping(inline_or_block_errors = :inline, inline_or_block_hints = :inline, &block)
          control_group_div_wrapping do
            label_html <<
            input_div_wrapping(inline_or_block_errors, inline_or_block_hints) do
              yield
            end
          end
        end

        def control_group_div_wrapping(&block)
          template.content_tag(:div, wrapper_html_options) do
            yield
          end
        end

        def input_div_wrapping(inline_or_block_errors = :inline, inline_or_block_hints = :inline)
          template.content_tag(:div, :class => "controls") do
            [yield, error_html(inline_or_block_errors), hint_html(inline_or_block_hints)].join("\n").html_safe
          end
        end

        def inline_inputs_div_wrapping(&block)
          template.content_tag(:div, :class => "inline-inputs") do
            yield
          end
        end

        def wrapper_html_options
          opts = (options[:wrapper_html] || {}).dup
          opts[:class] =
            case opts[:class]
            when Array
              opts[:class].dup
            when nil
              []
            else
              [opts[:class].to_s]
            end
          opts[:class] << as
          opts[:class] << "control-group"
          # opts[:class] << "input"
          opts[:class] << "error" if errors?
          opts[:class] << "optional" if optional?
          opts[:class] << "required" if required?
          opts[:class] << "autofocus" if autofocus?
          opts[:class] = opts[:class].join(' ')

          opts[:id] ||= wrapper_dom_id

          opts
        end

      end
    end
  end
end
