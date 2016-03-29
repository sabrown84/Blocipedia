FactoryGirl.define do
  before do
    @user = create(:user)
    sign_in @user
  end
  factory :wiki do
    title "MyString"
    body "MyText"
    private false
    user nil
  end
end
