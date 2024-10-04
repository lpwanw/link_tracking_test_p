class DateRangeFromParamsService
  def initialize(from: nil, to: nil)
    @from = from
    @to = to
  end

  def call
    return if @from.blank? && @to.blank?

    (@from&.to_date&.beginning_of_day...@to&.to_date&.end_of_day)
  rescue
    nil
  end
end
