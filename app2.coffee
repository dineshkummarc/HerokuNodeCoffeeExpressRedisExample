express = require('express')


RedisStore = require('connect-redis')(express)
uri = URI.parse(ENV["REDISTOGO_URL"])

REDIS = {host: uri.host, port: uri.port, password: uri.password}

app = express.createServer()
 
# Setup configuration
app.use express.static(__dirname + '/public')
app.use express.cookieParser()
app.use express.session {secret: "Coffeebreak", store: new RedisStore(REDIS), cookie: { maxAge: 60000 } }
app.set 'view engine', 'jade'
  
# App Routes
app.get '/', (request, response) ->
  request.session.views++
  response.render 'index', { title: request.session.views + ': Express with Coffee and sessions' }

# Listen
app.listen 3000
console.log "Express22 server listening on port %d", app.address().port
