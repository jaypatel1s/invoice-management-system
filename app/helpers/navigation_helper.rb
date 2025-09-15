# frozen_string_literal: true

module NavigationHelper
  def path_for(resource)
    send("company_#{resource}_path")
  end
end
