class Muskrat < ActiveRecord::Base
  belongs_to :hole

  def destroy(*args)
    puts 'about to destroy'
    r = super
    puts "destroyed :#{reload.deleted_at}"
    r
  end
end
