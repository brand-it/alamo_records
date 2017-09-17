# frozen_string_literal: true

# This is a hot fix for a bootstrap 4. Basicly after doing some work I found that
# there is no way to add a error class to the input directly. However by overwriting the
# merge_wrapper_options method we can get this to work. However it requires me to get a bit down dirty
#
# TODO: This code should be removed once they have resolved the issues in simple_form that let you
# add the error class to the input dirrectly.
# lib/simple_form/inputs/custom_base.rb
module SimpleForm
  module Inputs
    module CustomBase
      def self.included(base) # rubocop:disable AbcSize, MethodLength,
        base.class_eval do
          def merge_wrapper_options(options, wrapper_options) # rubocop:disable MethodLength, AbcSize
            Rails.logger.debug("[OPTIONS] #{options.inspect}")
            Rails.logger.debug("[WRAPPER OPTIONS] #{wrapper_options.inspect}")
            Rails.logger.debug("[HAS ERROR?] #{has_errors?}")
            Rails.logger.debug("[ERROR CLASS] #{wrapper_options[:error_class]}")
            # Credit for solution thanks Charlie Hawker
            # https://github.com/plataformatec/simple_form/issues/1475
            if wrapper_options.key?(:error_class) && has_errors?
              wrapper_options = wrapper_options.dup
              wrapper_options[:class] ||= ''
              wrapper_options[:class] += " #{wrapper_options.delete(:error_class)}"
            end
            if wrapper_options
              wrapper_options.merge(options) do |key, oldval, newval|
                case key.to_s
                when 'class'
                  Array(oldval) + Array(newval)
                when 'data', 'aria'
                  oldval.merge(newval)
                else
                  newval
                end
              end
            else
              options
            end
          end
        end
      end
    end
  end
end
SimpleForm::Inputs::Base.send(:include, SimpleForm::Inputs::CustomBase)
