FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@test.com"}
    password "password"
    password_confirmation "password"
    # active_symptoms [1, 2, 3, 4, 5]
    # active_treatments [1, 2, 3, 4, 5]
    locale "en"

    before(:create) do
      User.skip_callback(:create, :after, :touch_with_version)
    end
    after(:create) do |user|
      Timecop.travel(user.created_at)
      user.touch_with_version
      Timecop.return
    end
  end
end
