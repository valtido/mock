// Generated by CoffeeScript 1.7.1
var extend;

exports.merge = function(options, overrides) {
  return extend(extend({}, options), overrides);
};

extend = exports.extend = function(object, properties) {
  var key, val;
  for (key in properties) {
    val = properties[key];
    object[key] = val;
  }
  return object;
};
