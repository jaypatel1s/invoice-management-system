# frozen_string_literal: true

# :nodoc:
module FormatHelper
  def show_date(val)
    return if val.blank?

    val.strftime('%d-%m-%Y')
  rescue StandardError
    ''
  end
end
