class Label < ApplicationRecord
  include StringNormalizer

  belongs_to :user
  has_many :todo_labels, dependent: :destroy
  has_many :todos, through: :todo_labels
  has_many :shortcut_labels, dependent: :destroy
  has_many :shortcuts, through: :shortcut_labels

  scope :order_created_desc, -> { order(created_at: :desc) }

  before_validation do
    self.title = normalize_as_text(title)
    self.color = normalize_as_color(color)
  end

  validates :title, presence: true,
                    uniqueness: { scope: :user },
                    length: { maximum: 30 }
  validates :color, presence: true
  validate :label_color_must_be_hex_style
  validate :label_count_within_limit, if: -> { user.labels.size > 10 }

  private
  
  def label_color_must_be_hex_style
    hex_string_array = (0..9).to_a.map(&:to_s) + ('a'..'f').to_a

    if color
      color_array = color.split('')
      color_array.shift
      color_condition = color_array.all? do |i|
        hex_string_array.include?(i)
      end

      unless (color_array.length == 6 || color_array.length == 3) && color_condition
        errors.add(:color, 'エラー')
      end
    end
  end

  def label_count_within_limit
    errors.add(:base, 'ラベルが登録できるのは10個までです')
  end
end
