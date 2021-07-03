# README

## usersテーブル

| Column             | Type    | Options                       |
| -----------------  | ------- | ----------------------------- |
| email              | string  | null: false, uniqueness: true |
| encrypted_password | string  | null: false                   |
| nickname           | string  | null: false                   |
| family_name_kanji  | string  | null: false                   |
| first_name_kanji   | string  | null: false                   |
| family_name_kana   | string  | null: false                   |
| first_name_kana    | string  | null: false                   |
| birthday           | date    | null: false                   |

### Association
-has_many :items
-has_many :comments
-has_many :purchase_history

## itemsテーブル

| Column            | Type       | Options                         |
| ----------------- | ---------- | ------------------------------- |
| title             | string     | null: false                     |
| description       | text       | null: false                     |
| category_id       | integer    | null: false                     |
| status_id         | integer    | null: false                     |
| charge_burden_id  | integer    | null: false                     |
| prefecture_id     | integer    | null: false                     |
| day_id            | integer    | null: false                     |
| price             | integer    | null: false                     |
| user              | references | null: false, foreign_key: true  |

### Association
-belongs_to :user
-has_many :comments
-has_one :customer
-has_one :purchase_history

## customersテーブル

| Column               | Type       | Options                           |
| -------------------- | ---------- | --------------------------------- |
| post_number          | string     | null: false                       |
| prefecture_id        | string     | null: false                       |
| municipality         | string     | null: false                       |
| address              | string     | null: false                       |
| building_name        | string     |                                   |
| phone_number         | string     | null: false                       |
| item                 | references | null: false, foreign_key: true    |

### Association
-belongs_to :item

## purchase_historyテーブル

| Column    | Type       | Options                         |
| --------- | ---------- | ------------------------------- |
| user      | references | null: false, foreign_key: true  |
| customer  | references | null: false, foreign_key: true  |

### Association
-belongs_to :user
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