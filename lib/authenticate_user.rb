class AuthenticateWithLDAP
  def self.authenticate( username, password )
    ldap = Net::LDAP.new( host: '192.168.176.20', auth: { method: :simple, email: username, password: password })
    ldap.bind
  end
end