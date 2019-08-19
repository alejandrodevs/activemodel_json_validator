RSpec.describe ActiveModel::JsonValidator do
  it 'has a valid version number' do
    expect(described_class::VERSION).not_to be nil
    expect(described_class::VERSION).to be_an_instance_of(String)
  end

  class User
    include ActiveModel::Model
    include ActiveModel::Validations
    attr_accessor :data
  end

  let(:validator) { { schema: schema } }
  let(:schema)    { File.join('spec', 'schemas', 'data.json') }
  let(:user)      { User.new(data: data) }
  let(:data)      { {} }

  before(:example) do
    validator.tap do |validator|
      User.class_eval do
        validates :data, json: validator
      end
    end
  end

  context 'when json is valid' do
    let(:data) do
      {
        locale: 'en',
        currency: 'USD'
      }
    end

    it 'does not add error in json attribute' do
      expect(user).to be_valid
    end
  end

  context 'when json is invalid' do
    let(:data) do
      {
        locale: 'en',
        currency: 1_000,
        subscribed: 'Invalid'
      }
    end

    it 'adds error in json attribute' do
      expect(user).to be_invalid
      scope = [:activemodel, :errors, :models, :user, :attributes, :data]
      expect(user.errors[:data]).to include I18n.t(:invalid_json, scope: scope)
    end

    context 'when message is specified' do
      let(:validator) do
        {
          schema: schema,
          message: :other_error
        }
      end

      it 'adds custom error in json attribute' do
        expect(user).to be_invalid
        scope = [:activemodel, :errors, :models, :user, :attributes, :data]
        expect(user.errors[:data]).to include I18n.t(:other_error, scope: scope)
      end
    end
  end
end
