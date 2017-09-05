require 'rails_helper'

describe Resource do

  it "has a valid factory" do
    expect(build(:resource)).to be_valid
  end

  it { is_expected.to have_timestamps }
  it { is_expected.to belong_to(:user).of_type(User) }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to have_field(:hits).of_type(Integer).with_default_value_of(0) }
  it { is_expected.to have_field(:hidden).of_type(Mongoid::Boolean).with_default_value_of(false) }

end
