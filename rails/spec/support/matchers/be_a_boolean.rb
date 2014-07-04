RSpec::Matchers.define :be_a_boolean do
  match { |actual| actual == true || actual == false }
end
