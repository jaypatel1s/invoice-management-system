ROLE_PERMISSIONS = {
  super_admin: {
    dashboard: %i[index],
    company: %i[index new create edit update show destroy],
    branches: %i[index new create edit update show destroy],
    users: %i[index new create edit update show destroy],
    customers: %i[index show],
    stocks: %i[index new create edit update show destroy],
    products: %i[index new create edit update show destroy]
  },
  branch: {
    dashboard: %i[index],
    company: %i[index show],
    branches: %i[index show],
    products: %i[index show],
    customers: %i[index new create edit update show destroy],
    branch_stocks: %i[index new create edit update show destroy],
    stock_transfer_requests: %i[index new create edit update show destroy approve reject]
  },
  branch_manager: {
    dashboard: %i[index],
    sessions: %i[index show],
    attendances: %i[new create]
  },
  branch_staff: {
    admissions: %i[index new create edit update show destroy]
  }
}
