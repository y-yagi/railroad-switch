require "test_helper"
require "rack/test"

class AppOne
  def call(_env)
    [200, { }, ["AppOne"]]
  end
end

class AppTwo
  def call(_env)
    [200, { }, ["AppTwo"]]
  end
end

class AppThird
  def call(_env)
    [200, { }, ["AppThird"]]
  end
end

class Railroad::SwitchTest < Minitest::Test
  include Rack::Test::Methods

  attr_reader :app

  def setup
    Railroad::Switch.fallback_to = nil
  end

  def test_nothing_specified
    @app = Railroad::Switch.app

    get '/'
    refute last_response.ok?
    assert_equal 404, last_response.status
  end

  def test_swith_app
    Railroad::Switch.fallback_to = AppThird.new
    Railroad::Switch.register(path: "/one", app: AppOne.new)
    Railroad::Switch.register(path: "/two", app: AppTwo.new)

    @app = Railroad::Switch.app

    get '/'
    assert last_response.ok?
    assert_equal "AppThird", last_response.body

    get '/one'
    assert last_response.ok?
    assert_equal "AppOne", last_response.body

    get '/two'
    assert last_response.ok?
    assert_equal "AppTwo", last_response.body
  end
end
