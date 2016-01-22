class Task < ActiveRecord::Base
  include AASM
  belongs_to :user
  has_many :attachments, dependent: :destroy

  enum state: {
    added: 0,
    started: 1,
    finished: 2
  }

  aasm :column => :state, :enum => true do
    state :added, :initial => true
    state :started
    state :finished

    event :start do
      transitions :from => :added, :to => :started
    end

    event :finish do
      transitions :from => :started, :to => :finished
    end
  end
end
