module Github
  class Contributor
    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes.to_h
    end

    [:login, :id, :avatar_url, :gravatar_id, :contributions].each do |key|
      define_method(key) { attributes.fetch(key) }
    end
  end
end
