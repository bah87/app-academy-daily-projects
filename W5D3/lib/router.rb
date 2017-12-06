require 'byebug'

class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern = pattern
    @http_method = http_method
    @controller_class = controller_class
    @action_name = action_name
  end

  # checks if pattern matches path and method matches request method
  def matches?(req)
    self.pattern.match(req.path) &&
    req.request_method == self.http_method.to_s.upcase
  end
  
  def route_params(req)
    regex = Regexp.new(self.pattern)
    match_data = regex.match(req.path)
    names = match_data.names.map { |str| str.to_sym }
    
    params = {}
    names.each do |param|
      params[param] = match_data[param]
    end
    
    params
  end

  # use pattern to pull out route params (save for later?)
  # instantiate controller and call controller action
  def run(req, res)
    controller = self.controller_class.new(req, res, self.route_params(req))
    res.write(controller.params)
    controller.invoke_action(self.action_name)
  end
end

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  # simply adds a new route to the list of routes
  def add_route(pattern, method, controller_class, action_name)
    self.routes << Route.new(pattern, method, controller_class, action_name)
  end

  # evaluate the proc in the context of the instance
  # for syntactic sugar :)
  def draw(&proc)
    self.instance_eval(&proc)
  end

  # make each of these methods that
  # when called add route
  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method) do |pattern, controller_class, action_name|
      add_route(pattern, http_method, controller_class, action_name)
    end
  end

  # should return the route that matches this request
  def match(req)
    self.routes.each do |route|
      return route if route.matches?(req)
    end
    
    nil
  end

  # either throw 404 or call run on a matched route
  def run(req, res)
    matched_route = self.match(req)
    if matched_route
      matched_route.run(req, res)
    else
      res.status = 404
    end
  end
end
