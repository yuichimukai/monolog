# メインのサンプルユーザーを1人作成する
User.create!(
	username: 'Example User',
	email: 'example@gmail.com',
	password: 'example',
	password_confirmation: 'example',
	admin: true,
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

# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(6)
50.times do
	content = Faker::Lorem.sentence(word_count: 5)
	users.each { |user| user.microposts.create!(content: content) }
end

# 以下のリレーションシップを作成する
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
