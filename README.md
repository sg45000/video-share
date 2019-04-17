# VIDEO-SHARE
このアプリはRailsの基本的な機能を習得するため、Rails Tutorial（https://railstutorial.jp/）を終えた後、
作成したものです。
まずユーザー登録していただき、アカウント内で好きなyoutubeのURLをコピーして登録すれば自分のお気に入り動画として他のユーザーとシェアできます。


### Requirement
Ruby 2.5.3

Rails 5.2.3

Bundler 2.0.1

### Installation
1. Clone this repository

`$ git clone git@github.com:sg45000/video-share.git`

2. Move into your project

`$ cd video-share`

3. Install Ruby 2.5.3 (If nessesary)

`$ rbenv install 2.5.3`

4. Set Ruby version to 2.5.3(If nessesary)

`$ rbenv local 2.5.3`

5. Install Bundler 2.0.1(If nessesary)

`$ gem install bundler -v 2.0.1`

6. Install gems

`$ bundle install`

7. Exec migration

`$ bin/rails db:migrate RAILS_ENV=development`

8. Create sample data(If nessesary)

`$ rake db:seed`

9. Build & run server

`$ bin/rails s`

10. Then, you can see app in http://localhost:3000

### Heroku Deploy
https://video-share-3u289.herokuapp.com/