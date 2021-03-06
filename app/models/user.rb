class User < ActiveRecord::Base
  @@SUCCESS = 1
  @@ERR_BAD_CREDENTIALS = -1
  @@ERR_USER_EXISTS = -2
  @@ERR_BAD_USERNAME = -3
  @@ERR_BAD_PASSWORD = -4
  @@MAX_USERNAME_LENGTH = 128
  @@MAX_PASSWORD_LENGTH = 128

  def self.add(usr, pass)
    if User.find_by(username:usr)
      return @@ERR_USER_EXISTS
    end
    if (usr.length > @@MAX_USERNAME_LENGTH) or (usr.length == 0)
      return @@ERR_BAD_USERNAME
    end
    if (pass.length > @@MAX_PASSWORD_LENGTH) or (pass.length == 0)
      return @@ERR_BAD_PASSWORD
    else
      User.create(username:usr, password:pass, count: 1)
      return @@SUCCESS
    end
  end

  def self.login(usr, pass)
    curr_user = find_by(username: usr)
    if (curr_user != nil && curr_user.password == pass)
      curr_user.count += 1
      curr_user.save
      return curr_user.count
    else
      return @@ERR_BAD_CREDENTIALS
    end
  end

  def self.TESTAPI_resetFixture()
    User.delete_all
    return @@SUCCESS
  end
end
