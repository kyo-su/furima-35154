class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :purchase_histories

  with_options presence: true do
    validates :nickname
    validates :birthday
  end

  # 英数字混合であるかどうかを検証
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'is invalid. Include both letters and numbers', allow_blank: true

  # 全角のひらがなor漢字を使用していないかを検証
  with_options presence: true,
               format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters',
                         allow_blank: true } do
    validates :family_name_kanji
    validates :first_name_kanji
  end

  # 全角のカタカナを使用していないかを検証
  with_options presence: true,
               format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width katakana characters',
                         allow_blank: true } do
    validates :family_name_kana
    validates :first_name_kana
  end
end
