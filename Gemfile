source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'jbuilder', '~> 2.7'
gem 'mysql2', '>= 0.4.4'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.5'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'
gem 'kaminari'
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', groups: %i[development test]
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
  # コーディングチェック
  # gem 'rubocop', require: false
  # gem 'rubocop-rails'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# authentication
gem 'devise'
# 日本語化devise
gem 'devise-i18n'
gem 'devise-i18n-views'
# 管理画面
gem 'activeadmin'
#bootstrap
gem 'bootstrap', '~> 4.5.0'
gem 'jquery-rails'
#ImageMagickをrailsで使うため
gem 'mini_magick'
#avatar
gem 'rails-i18n', '~> 6.0'
gem 'image_processing', '~> 1.2'
#amazon S3 storage gem
gem 'aws-sdk-s3', require: false

gem 'faker', '2.1.2'
#activestorage validation
gem 'active_storage_validations'
#楽天api
gem 'rakuten_web_service'
#compile
# gem 'sassc-rails'
