require_relative '../timeformat.rb'

class Timerequest
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    
    path = request.path
    
    params = request.params['format']

    status, headers, body = @app.call(env)
    
    return [404, headers, ["404\n"]] if path != '/time' 

    return [400, headers, ["invalid_format_name\n"]] if params.nil?

    time_format = Timeformat.new(params)
    if time_format.valid?
      body = time_format.time
      status = 200
    else
      invalid_params = time_format.invalid_params
      body = "Unknown time format #{invalid_params}"
      status = 400
    end

    [status, headers, ["#{body}\n"]]

  end
end