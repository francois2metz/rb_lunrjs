root = exports ? this

try
  root.console = root.console or {}
  names = [
    "log", "debug", "info", "warn", "error", "assert", "dir",
    "dirxml", "group", "groupEnd", "time", "timeEnd", "count",
    "trace", "profile", "profileEnd"
  ]
  nada = ->
  for name in names
    root.console[name] = root.console[name] or nada

class Search
  constructor: (@options, @data) ->
    console.debug('Initializing search...')
    _this = @
    @idx = lunr(->
      for field in _this.options
        console.debug("Adding field #{field.name}...")
        @field field.name, field.options
      @ref('id')
      return
    )
    if @data?
      for obj in @data
        console.debug("Adding object #{_j+1}...")
        @idx.add obj
    return @

  add: (object) ->
    @idx.add object

  index: ->
    @idx

  search: (query) ->
    console.debug('Search for #{query}...')
    @idx.search query

  toJSON: ->
    console.debug("Dumping to JSON...")
    JSON.stringify(@idx.toJSON())

root.Search = Search
