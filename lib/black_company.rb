require "black_company/pool"
require "black_company/version"

module BlackCompany
  def self.start(*args)
    Pool.new(*args)
  end
end
