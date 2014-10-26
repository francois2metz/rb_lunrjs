(function() {
  var Search, nada, name, names, root, _i, _len;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  try {
    root.console = root.console || {};
    names = ["log", "debug", "info", "warn", "error", "assert", "dir", "dirxml", "group", "groupEnd", "time", "timeEnd", "count", "trace", "profile", "profileEnd"];
    nada = function() {};
    for (_i = 0, _len = names.length; _i < _len; _i++) {
      name = names[_i];
      root.console[name] = root.console[name] || nada;
    }
  } catch (_error) {}

  Search = (function() {
    function Search(options, data) {
      var obj, _j, _len1, _ref, _this;
      this.options = options;
      this.data = data;
      console.debug('Initializing search...');
      _this = this;
      this.idx = lunr(function() {
        var field, _j, _len1, _ref;
        _ref = _this.options;
        for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
          field = _ref[_j];
          console.debug("Adding field " + field.name + "...");
          this.field(field.name, field.options);
        }
        this.ref('id');
      });
      if (this.data != null) {
        _ref = this.data;
        for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
          obj = _ref[_j];
          console.debug("Adding object " + (_j + 1) + "...");
          this.idx.add(obj);
        }
      }
      return this;
    }

    Search.prototype.add = function(object) {
      return this.idx.add(object);
    };

    Search.prototype.index = function() {
      return this.idx;
    };

    Search.prototype.search = function(query) {
      console.debug('Search for #{query}...');
      return this.idx.search(query);
    };

    Search.prototype.toJSON = function() {
      console.debug("Dumping to JSON...");
      return JSON.stringify(this.idx.toJSON());
    };

    return Search;

  })();

  root.Search = Search;

}).call(this);
