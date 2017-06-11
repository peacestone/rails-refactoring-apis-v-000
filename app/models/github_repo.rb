class GithubRepo

  attr_reader :name, :url
  attr_accessor :access_token

  def initialize(hash)
    @name = hash["name"]
    @url = hash["html_url"]
    @access_token = hash[:access_token]
  end

  def authenticate!(client_id, client_secret, code)
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: client_id, client_secret: client_secret ,code: code}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    #session[:token] = access_hash["access_token"]
    access_hash["access_token"]
  end

  def get_username
    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    #session[:username] = user_json["login"]
    user_json["login"]
  end

  def get_repos
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}
    JSON.parse(response.body)
  end

end
