require 'virtus'

module SecureDB
  class User

    include Virtus

    # User name
    attribute :name, String

    # The security clearance for the user (1 - 10)
    attribute :clearance, Integer, default: 1

    # Authorizations to documents
    #
    # @return [Array<Authorization>]
    attribute :authorizations, Array

    #
    # The documents the user is authorized to read.
    #
    # @return [Array<Document>]
    #   The list of documents.
    #
    def documents
      authorizations.map(&:document)
    end

    alias to_s name

  end
end
