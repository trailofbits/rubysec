require 'secure_db/user'
require 'secure_db/document'

require 'virtus'

module SecureDB
  class Authorization

    include Virtus

    attribute :authorizer, User

    attribute :authorized, User

    attribute :document, Document

  end
end
