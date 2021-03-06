// Generated by CoffeeScript 1.7.1
(function() {
  var EventEmitter;

  define(function() {
    return EventEmitter;
  });

  EventEmitter = (function() {
    EventEmitter.prototype._listeners = {};

    function EventEmitter() {}

    EventEmitter.prototype.addListener = EventEmitter.on;

    EventEmitter.prototype.on = function(type, listener) {
      if (!this._isFunc(listener)) {
        this._exception();
      }
      if (!this._isType(type)) {
        this._listeners[type] = [];
      }
      return this._listeners[type].push(listener);
    };

    EventEmitter.prototype.removeListener = function(type, listener) {
      var position;
      if (!this._isFunc(listener)) {
        this._exception();
      }
      if (!this._isType(type)) {
        return;
      }
      position = this._listeners[type].indexOf(listener);
      if (position !== -1) {
        return this._listeners[type].splice(position, 1);
      }
    };

    EventEmitter.prototype.removeAllListeners = function(type) {
      if (type) {
        return this._listeners[type] = [];
      } else {
        return this._listeners = {};
      }
    };

    EventEmitter.prototype.emit = function(type, event) {
      var t, _i, _len, _ref, _results;
      if (!(this._isType(type) && this._listeners[type].length)) {
        return;
      }
      _ref = this._listeners[type];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        t = _ref[_i];
        _results.push(t.apply(this, [event]));
      }
      return _results;
    };

    EventEmitter.prototype._exception = function() {
      throw 'Listener must be a function';
    };

    EventEmitter.prototype._isType = function(type) {
      return this._listeners[type] != null;
    };

    EventEmitter.prototype._isFunc = function(listener) {
      return typeof listener === 'function';
    };

    return EventEmitter;

  })();

}).call(this);
