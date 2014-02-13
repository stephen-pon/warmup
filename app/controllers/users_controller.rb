class UsersController < ApplicationController
  def new
  end

  def TESTAPI_unitTests
    system('rspec --out tests.txt')
    File.open('tests.txt', 'r') do |results|
      results.each_line do |line|
        if (line.include? "examples" and line.include? "failures")
        @linetoarray = line.split
        @numTests = @linetoarray[0]
        @numFails = @linetoarray[2]
        end
      end
      @output = results.read
    end
    @numFails = @numFails.to_i
    @numTests = @numTests.to_i
    hash = {nrFailed: @numFails, output: @output, totalTests: @numTests}
    hash.to_json
    render :json => hash
  end

  def add
    user = params[:user]
    passwrd = params[:password]
    code = User.add(user, passwrd)
    if code > 0
      hash = {:errCode => code, :count => 1}
    else
      hash = {:errCode => code}
    end
    hash.to_json
    render :json => hash
  end 

  def login
    user = params[:user]
    passwrd = params[:password]
    code = User.login(user, passwrd)
    if code > 0
      hash = {:errCode => 1, :count => code}
    else
      hash = {:errCode => code}
    end
    hash.to_json
    render :json => hash
  end

  def TESTAPI_resetFixture
    code = User.TESTAPI_resetFixture()
    hash = {:errCode => code}
    hash.to_json
    render :json => hash
  end
end
