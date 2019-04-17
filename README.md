# VIDEO-SHARE
このアプリはRailsの基本的な機能を習得するため、Rails Tutorial（https://railstutorial.jp/）を終えた後、
作成したものです。
まずユーザー登録していただき、アカウント内で好きなyoutubeのURLをコピーして登録すれば自分のお気に入り動画として他のユーザーとシェアできます。


### Requirement
Ruby 2.5.3

Rails 5.2.3

Bundler 2.0.1

### Installation
Clone this repository
`$ git clone git@github.com:sg45000/video-share.git`
Move into your project
`$ cd video-share`
Install Ruby 2.5.3 (If nessesary)
`$ rbenv install 2.5.3`
Set Ruby version to 2.5.3(If nessesary)
`$ rbenv local 2.5.3`
Install Bundler 2.0.1(If nessesary)
`$ gem install bundler -v 2.0.1`
Install gems
`$ bundle install`
Exec migration
`$ bin/rails db:migrate RAILS_ENV=development`
Create sample data(If nessesary)
`$ rake db:seed`
Build & run server
`$ bin/rails s`
Then, you can see app in http://localhost:3000
