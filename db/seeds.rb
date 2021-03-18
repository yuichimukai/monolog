# メインのサンプルユーザーを1人作成する
User.create!(
	username: 'Example User',
	email: 'example@gmail.com',
	password: 'example',
	password_confirmation: 'example',
)

# 追加のユーザーをまとめて生成する
99.times do |n|
	username = Faker::Name.name
	email = "example-#{n + 1}@railstutorial.org"
	password = 'password'
	User.create!(
		username: username,
		email: email,
		password: password,
		password_confirmation: password,
	)
end
