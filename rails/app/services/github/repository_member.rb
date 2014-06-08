module Github
  class RepositoryMember
    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes.to_h
    end

    [:login, :id, :avatar_url, :gravatar_id, :type].each do |key|
      define_method(key) { attributes.fetch(key) }
    end
  end
end