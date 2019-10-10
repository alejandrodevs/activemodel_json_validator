class JsonValidator < ActiveModel::EachValidator
  DEFAULT_SCHEMAS_PATH = %w(app models schemas).freeze

  def initialize(options)
    @model = options[:class]
    super
  end

  def validate_each(model, attribute, value)
    schema = options.fetch(:schema, default_schema(attribute))
    errors = JSON::Validator.fully_validate(schema, value)
    model.errors.add(attribute, message(errors)) if errors.any?
  end

  private

  def message(errors)
    message = options.fetch(:message, :invalid_json)
    return message unless message.respond_to?(:call)
    message.call(errors)
  end

  def default_root_path
    require 'rails'
    Rails.root.join.to_s
  rescue LoadError
    File.join.to_s
  end

  def default_schemas_path
    DEFAULT_SCHEMAS_PATH
  end

  def default_model_path
    @model.model_name.singular
  end

  def default_schema(attribute)
    File.join(
      default_root_path,
      default_schemas_path,
      default_model_path,
      "#{attribute}.json"
    ).to_s
  end
end
