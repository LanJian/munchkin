#### Routes
module.exports = (app) ->
  require('./controllers/index')(app)
  require('./controllers/ping')(app)
