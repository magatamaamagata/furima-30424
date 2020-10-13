# テーブル設計
## usersテーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| nickname     | string | null: false |
| email    | string | null: false |
| password | string | null: false |
| name_kanji| string | null: false |
| name_katakana| string | null: false |
| birthday| date | null: false |
### Association

- has_many :items
- has_many :customers

## items テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| image     |  |  |
| name    | string | null: false |
| description | text | null: false |
| category| string | null: false |
| status| string | null: false |
| delivery| string | null: false |
| shipment_fee| string | null: false |
| day_to_ship| string | null: false |
| price| integer | null: false |
| user_id| references |  |

### Association

- belongs_to :user
- belongs_to :customer

## customers テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| card_number     | integer | null: false |
| expiration date    | date | null: false |
| security_code | integer | null: false |
| user_id  | references | |

### Association

- belongs_to :user
- belongs_to :customer
- has_one :addresses

## addresses テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| postcode     | integer | null: false |
| prefecture    | string | null: false |
| city | string | null: false |
| a_lot_number | integer | null: false |
| buiding | string | null: false |
| phone_number | integer | null: false |

### Association
- belongs_to :customer