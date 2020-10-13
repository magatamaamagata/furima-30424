# テーブル設計
## usersテーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| nickname     | string | null: false |
| email    | string | null: false |
| password | string | null: false |
| family_name_kanji| string | null: false |
| first_name_kanji| string | null: false |
| family_name_katakana| string | null: false |
| first_name_katakana| string | null: false |
| birthday_id| date | null: false |

### Association

- has_many :items
- has_many :customers

## items テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| name    | string | null: false |
| description | text | null: false |
| category_id| integer | null: false |
| status_id| integer | null: false |
| prefecture_id| integer | null: false |
| shipment_fee_id| integer | null: false |
| day_to_ship_id| integer | null: false |
| price| integer | null: false |
| user| references | foreign_key: true |

### Association

- belongs_to :user
- has_one :customer

## customers テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| user | references | foreign_key: true |
| item | references | foreign_key: true |


### Association

- belongs_to :user
- belongs_to :customer
- has_one :address

## addresses テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| postcode     | string | null: false |
| prefecture_id    | integer | null: false |
| city | string | null: false |
| address | string | null: false |
| building | string | |
| phone_number | integer | null: false |
| customer | references | foreign_key: true |


### Association
- belongs_to :customer