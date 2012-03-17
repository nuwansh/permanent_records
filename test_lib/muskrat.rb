class Muskrat < ActiveRecord::Base
  belongs_to :hole

  def destroy(*args)
    puts 'about to destroy'
    super
    puts "destroyed :#{reload.deleted_at}"
  end
end
