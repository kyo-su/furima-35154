# README

## usersテーブル

| Column            | Type    | Options     |
| ----------------- | ------- | ----------- |
| email             | string  | null: false |
| password          | string  | null: false |
| nickname          | string  | null: false |
| family_name_kanji | string  | null: false |
| first_name_kanji  | string  | null: false |
| family_name_kana  | string  | null: false |
| first_name_kana   | string  | null: false |
| birthday          | integer | null: false |

### Association
-has_many :items
-has_many :comments

## itemsテーブル

| Column         | Type       | Options                         |
| -------------- | ---------- | ------------------------------- |
| title          | string     | null: false                     |
| description    | text       | null: false                     |
| category       | string     | null: false                     |
| status         | string     | null: false                     |
| charge_burden  | string     | null: false                     |
| area           | string     | null: false                     |
| days           | string     | null: false                     |
| price          | integer    | null: false                     |
| user           | references | null: false, foreign_key: true  |

### Association
-belongs_to :user
-has_many :comments
-has_one :customer

## customersテーブル

| Column               | Type    | Options                           |
| -------------------- | ------- | --------------------------------- |
| card_number          | integer | null: false                       |
| card_expiration_date | integer | null: false                       |
| card_security_code   | integer | null: false                       |
| post_number          | integer | null: false                       |
| prefectures          | string  | null: false                       |
| municipality         | string  | null: false                       |
| address              | string  | null: false                       |
| building_name        | string  | null: false                       |
| phone_number         | integer | null: false                       |
| item                 | references | null: false, foreign_key: true |

### Association
-belongs_to :item

## commentsテーブル

| Column | Type       | Options                              |
| ------ | ---------- | ------------------------------------ |
| text   | text       | null: false                          |
| user   | references | null: false, foreign_key: true       |
| item   | references | null: false, foreign_key: true       |

### Association
-belongs_to :user
-belongs_to :item