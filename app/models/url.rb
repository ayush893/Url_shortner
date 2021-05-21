class Url < ApplicationRecord
  validates :long_url, presence: true, length: { minimum: 30}
  before_create :generate_short_url, :sanitize
  def generate_short_url
    rand(36**8).to_s(36)
  end
  def sanitize
    long_url.strip!
    sanitize_url = self.long_url.downcase.gsub(/(https?:\/\/)|(www\.)/,"")
    "http://#{sanitize_url}"
  end
  # def generate_complete_short
  #   self.complete_short = "#{self.base_url}/#{short}"
  # end
end
