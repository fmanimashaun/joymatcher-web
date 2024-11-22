# frozen_string_literal: true
#
# Uncomment this and change the path if necessary to include your own
# components.
# See https://github.com/heartcombo/simple_form#custom-components to know
# more about custom components.
# Dir[Rails.root.join('lib/components/**/*.rb')].each { |f| require f }
#
# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # Wrappers are used by the form builder to generate a
  # complete input. Adjust the wrapper to use Tailwind classes.
  config.wrappers :default, class: "mb-4",
    hint_class: "text-gray-500 text-sm",
    error_class: "field-with-errors",
    valid_class: "field-without-errors" do |b|

    ## Extensions enabled by default
    b.use :html5
    b.use :placeholder

    ## Optional extensions
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    ## Inputs
    # Label and input wrapped together
    b.wrapper :label_input, class: "flex flex-col" do |ba|
      ba.use :label, class: "block text-sm font-medium text-gray-700 mb-2"
      ba.use :input, class: "form-input block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50",
        error_class: "border-red-500 focus:border-red-500"
    end

    ## Hint and Error
    b.use :hint, wrap_with: { tag: :span, class: "text-sm text-gray-500 mt-1" }
    b.use :error, wrap_with: { tag: :span, class: "text-sm text-red-600 mt-1" }
  end

  # Default wrapper
  config.default_wrapper = :default

  # Define the way to render check boxes / radio buttons with labels.
  config.boolean_style = :nested

  # Default class for buttons
  config.button_class = "px-4 py-2 bg-indigo-600 text-white font-semibold rounded-md hover:bg-indigo-700 focus:ring focus:ring-indigo-300 focus:ring-opacity-50"

  # Tag used for error notifications
  config.error_notification_tag = :div
  config.error_notification_class = "bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative"

  # Label text configuration
  config.label_text = lambda { |label, required, _explicit_label| "#{required} #{label}" }
end
