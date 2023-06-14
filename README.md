## テーブル

task
| カラム名 | データ型 |
----|---- 
| id | inteher |
| user_id | integer |
| title | string |
| content | text |
| create_at | timestamp |
| update_at | timestamp |


User
| カラム名 | データ型 |
----|---- 
| id | inteher |
| name | string |
| email | string |
| password_digest | string |
| create_at | timestamp |
| update_at | timestamp |

Label
| カラム名 | データ型 |
----|---- 
| id | inteher |
| name | string |
| create_at | timestamp |
| update_at | timestamp |


task_label
| カラム名 | データ型 |
----|---- 
| id | inteher |
| label_id | integer |
| task_id | inteher |
| create_at | timestamp |
| update_at | timestamp |

## ▪️Herokuへのデプロイ方法

Herokuに新しいアプリケーションを作成 
$ heroku create

.Gemfileに以下のgemを追加し、bundle installを実行
gem 'net-smtp’ 
gem 'net-imap’
gem 'net-pop’

.コミットする 
$ git add .
$ git commit -m “コミットメッセージ” 

.Heroku buildpackを追加する
$ heroku buildpacks:set heroku/ruby 
$ heroku buildpacks:add --index 1 heroku/nodejs

.HerokuにPostgreSQLのアドオンを追加
$ heroku addons:create heroku-postgresql

. Herokuにデプロイをする (今回はstep2ブランチから)
$ git push heroku step2:master

.データベースの移行
$ heroku run rails db:migrate