class Project < ApplicationRecord
  has_rich_text :description
  has_one_attached :featured_image

  validates :title, presence: true
  validate :acceptable_image

  def acceptable_image
    return unless featured_image.attached?

    unless featured_image.blob.byte_size <= 5.megabytes
      errors.add(:featured_image, "is too big (max 5MB)")
    end

    acceptable_types = [ "image/jpeg", "image/jpg", "image/png", "image/gif" ]
    unless acceptable_types.include?(featured_image.content_type)
      errors.add(:featured_image, "must be a JPEG, PNG, or GIF")
    end
  end
end
