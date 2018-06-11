class LendingForm < FormObjectBase
  attr_accessor :thing_id,
                :lender_id,
                :borrower_id,
                :borrowed_at,
                :return_planned_at,
                :notes,
                :lendable_things,
                :borrowers

  validates :thing_id,
            :borrower_id,
            :borrowed_at,
            :return_planned_at, presence: true

  validate :date_range

  def initialize(lender_id, params = {})
    super(params)
    set_lender(lender_id)
    load_lendable_things
    load_borrowers
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  attr_reader :lender

  def date_range
    return if borrowed_at.nil? || return_planned_at.nil?
    if borrowed_at > return_planned_at
      errors.add(:return_planned_at, 'should be later than the borrowing date')
    end
  end

  def set_lender(user_id)
    @lender = User.find(user_id)
  end

  def load_lendable_things
    @lendable_things = lender.things
  end

  def load_borrowers
    @borrowers = User.where.not(id: lender.id).decorate
  end

  def persist!
    Transaction.transaction do
      Transaction.create!(
        thing_id: thing_id,
        lender_id: lender.id,
        borrower_id: borrower_id,
        borrowed_at: borrowed_at,
        return_planned_at: return_planned_at,
        notes: notes
      )
      Thing.find(thing_id).update_attributes(borrower_id: borrower_id)
    end
  end
end
