require 'spec_helper'
@@SUCCESS = 1
@@ERR_BAD_CREDENTIALS = -1
@@ERR_USER_EXISTS = -2
@@ERR_BAD_USERNAME = -3
@@ERR_BAD_PASSWORD = -4

describe User do
  it "makes sure database works" do
    expect{User.create({username: "meow",password: "mix"})}.to change{User.count}.by(1)
  end

  it "makes sure users can be added" do
    @@SUCCESS.should equal(User.add("user1","password1"))
  end

  it "makes sure empty usernames throw errors" do 
    @@ERR_BAD_USERNAME.should eq(User.add("", "password"))
  end

  it "makes sure too long usernames throw errors" do
    @@ERR_BAD_USERNAME.should eq(User.add("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", "pass"))
  end

  it "makes sure empty passwords throw errors" do
    @@ERR_BAD_PASSWORD.should eq(User.add("hi", ""))
  end

  it "makes sure too long passwords throw errors" do
    @@ERR_BAD_PASSWORD.should eq(User.add("usher", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"))
  end

  it "makes sure you can't add more than one of the same username" do
    User.add("sameguy", "pass")
    @@ERR_USER_EXISTS.should eq(User.add("sameguy", "pass"))
  end

  it "makes sure bad username throws error" do
    @@ERR_BAD_CREDENTIALS.should eq(User.login("unknown", "wood"))
  end

  it "makes sure bad password throws error" do
    User.add("newkid", "ontheblock")
    @@ERR_BAD_CREDENTIALS.should eq(User.login("newkid", "password"))
  end

  it "tests to make sure the reset button works" do
    User.add("hithar", "derp")
    User.add("kitens", "moww")
    expect{User.TESTAPI_resetFixture()}.to change{User.count}.to(0)
  end
  
end
