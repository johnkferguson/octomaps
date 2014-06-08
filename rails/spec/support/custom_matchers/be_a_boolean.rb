RSpec::Matchers.define :be_a_boolean do |expected|
  match do |actual|
    actual == true || actual == false
  end
end
