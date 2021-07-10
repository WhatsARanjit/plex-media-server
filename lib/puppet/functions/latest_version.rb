Puppet::Functions.create_function(:latest_version) do
  dispatch :latest_version do
    param 'STRING', :distro
    return_type 'Hash[String, String, 2, 2]'
  end

  def latest_version(distro)
    require 'json'
    require 'net/http'

    uri = URI.parse("https://plex.tv/downloads/latest/5?channel=16&build=linux-x86_64&distro=#{distro}")
    res = Net::HTTP.get_response(uri)

    case res
    when Net::HTTPSuccess then
    when Net::HTTPRedirection then
      uri = URI.parse(res['location'])
    else
      raise "Invalid response: #{res.class}"
    end

    uri_split = uri.to_s.rpartition('/')
    { 'url' => uri_split[0], 'pkg' => uri_split[2] }
  end
end