# encoding: utf-8

class Product < ActiveRecord::Base
  attr_accessible :image_url, :description, :price, :title
  
  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  
  private
    # この商品を参照している品目がないことを確認する。
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, '品目が存在します')
        return false
      end
    end
  
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 1}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)$}i,
    message: 'はGIF, JPG, PNG画像のURLでなければなりません。'
  }
end
