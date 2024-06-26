class Timeformat

  DEST = {'year'=> '%Y', 'month'=> '%m', 'day'=> '%d', 'hour'=> '%H', 'minute'=> '%m', 'second'=> '%S'}
  
  attr_reader :params

  def initialize(params)
    @params = params.split(',')
  end

  def time
    body = self.params.reduce('') { |body_box, param| body_box << DEST[param] }
    p "DEBUG BODY #{body}"
    body = body.split('').join('-')
    Time.now.strftime(body)
  end

  def invalid_params
    self.params - DEST.keys
  end

  def valid?
    invalid_params.empty?
  end
end