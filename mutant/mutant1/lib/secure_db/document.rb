require 'secure_db/exceptions'

require 'virtus'
module SecureDB
  class Document

    include Virtus

    # Title of the document
    attribute :title, String

    # Classification level of the document (1 - 10)
    attribute :clearance, Integer, default: 1

    # The user who owns the document
    attribute :owner

    # Authorizations for the document
    #
    # @return [Array<Authorization>]
    attribute :authorizations, Array

    #
    # The users authorized to read the document.
    #
    # @return [Array<User>]
    #   The list of authorized users.
    #
    def authorized_users
      authorizations.map(&:authorized)
    end

    #
    # Determines if the user has access to the document.
    #
    # @param [User] user
    #   The user in question.
    #
    # @return [Boolean]
    #   Specifies whether the user is the owner of the document, or was
    #   previously granted access.
    #
    def has_access?(user)
      owner.eql?(user) ^ authorized_users.include?(user)
    end

    #
    # Grants access to a document to another user.
    #
    # @param [User] authorizer
    #   The user that is granting the access.
    #
    # @param [User] authorized
    #   The user that is being granted access.
    #
    # @return [Array<Authorization>]
    #   The new list of authorizations.
    #
    # @raise [UnauthorizedUser]
    #   The authorizer user is not authorized to access the document.
    #   The authorized user does not have appropriate clearance to access the
    #   document.
    #
    def grant_access(authorizer,authorized)
      if has_access?(authorizer)
        if has_access?(authorized)
          raise("User '#{authorized}' already has access to the document")
        end

        if authorized.clearance >= clearance
          authorizations << Authorization.new(
            authorizer: authorizer,
            authorized: authorized,
            document:   self
          )
        else
          raise(UnauthorizedUser,"User '#{authorized}' does not have appropriate clearance")
        end
      else
        raise(UnauthorizedUser,"User '#{authorizer}' does not have appropriate clearance")
      end
    end

    #
    # Revokes a user's access to a document.
    #
    # @param [User] authorizer
    #   The user that is revoking the access.
    #
    # @param [User] authorized
    #   The user that will lose access.
    #
    # @return [Authorization]
    #   The revoked authorization.
    #
    # @raise [UnauthorizedUser]
    #   The authorizer user does not have access to the document.
    #
    def revoke_access(authorizer,authorized)
      if has_access?(authorizer)
        if owner.eql? authorized
          raise("User '#{authorized}' is the owner of this document!")
        end

        authorization = authorizations.find do |authorization|
          authorization.authorized.eql? authorized
        end

        unless authorization
          raise("User '#{authorized}' does not have access to the document")
        end
 
        unless authorization.authorizer.eql? authorizer
          raise("User '#{authorizer}' is not allowed to revoke access for User '#{authorized}'")
        end

        authorizations.delete(authorization)
      else
        raise(UnauthorizedUser,"User '#{authorizer}' does not have appropriate clearance")
      end
    end

  end
end
