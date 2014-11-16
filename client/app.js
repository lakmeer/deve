(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var log, px, Connection, Player, me, field, ref$;
log = function(){
  console.log.apply(console, arguments);
  return arguments[0];
};
px = (function(it){
  return it + 'px';
});
Connection = (function(){
  Connection.displayName = 'Connection';
  var prototype = Connection.prototype, constructor = Connection;
  function Connection(port){
    this.port = port != null ? port : 3001;
  }
  return Connection;
}());
Player = (function(){
  Player.displayName = 'Player';
  var prototype = Player.prototype, constructor = Player;
  function Player(){
    var ref$;
    log("New Player");
    this.x = 0;
    this.y = 0;
    this.w = 20;
    this.h = 20;
    this.view = document.createElement('div');
    ref$ = this.view.style;
    ref$.backgroundColor = 'red';
    ref$.height = px(this.h);
    ref$.width = px(this.w);
    ref$.position = 'absolute';
  }
  prototype.install = function(host){
    return host.appendChild(this.view);
  };
  prototype.lookAt = function(arg$){
    var x, y;
    x = arg$.x, y = arg$.y;
  };
  prototype.moveTo = function(arg$){
    var x, y;
    x = arg$.x, y = arg$.y;
    log("Player::move-to", x, y);
    this.x = x;
    return this.y = y;
  };
  prototype.updateView = function(){
    log("Player:update-view", this.x, this.y);
    this.view.style.left = px(this.x - this.w / 2);
    return this.view.style.top = px(this.y - this.h / 2);
  };
  return Player;
}());
me = new Player;
field = document.createElement('div');
ref$ = field.style;
ref$.position = 'absolute';
ref$.height = '100%';
ref$.width = '100%';
ref$.backgroundColor = 'black';
me.install(field);
document.body.appendChild(field);
field.addEventListener('click', function(arg$){
  var x, y;
  x = arg$.clientX, y = arg$.clientY;
  log('clicked?');
  me.moveTo({
    x: x,
    y: y
  });
  return me.updateView();
});
},{}]},{},[1])
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyaWZ5L25vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIuL3NyYy9pbmRleC5scyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFBQTtBQ0FBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBIiwiZmlsZSI6ImdlbmVyYXRlZC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzQ29udGVudCI6WyIoZnVuY3Rpb24gZSh0LG4scil7ZnVuY3Rpb24gcyhvLHUpe2lmKCFuW29dKXtpZighdFtvXSl7dmFyIGE9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtpZighdSYmYSlyZXR1cm4gYShvLCEwKTtpZihpKXJldHVybiBpKG8sITApO3ZhciBmPW5ldyBFcnJvcihcIkNhbm5vdCBmaW5kIG1vZHVsZSAnXCIrbytcIidcIik7dGhyb3cgZi5jb2RlPVwiTU9EVUxFX05PVF9GT1VORFwiLGZ9dmFyIGw9bltvXT17ZXhwb3J0czp7fX07dFtvXVswXS5jYWxsKGwuZXhwb3J0cyxmdW5jdGlvbihlKXt2YXIgbj10W29dWzFdW2VdO3JldHVybiBzKG4/bjplKX0sbCxsLmV4cG9ydHMsZSx0LG4scil9cmV0dXJuIG5bb10uZXhwb3J0c312YXIgaT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2Zvcih2YXIgbz0wO288ci5sZW5ndGg7bysrKXMocltvXSk7cmV0dXJuIHN9KSIsInZhciBsb2csIHB4LCBDb25uZWN0aW9uLCBQbGF5ZXIsIG1lLCBmaWVsZCwgcmVmJDtcbmxvZyA9IGZ1bmN0aW9uKCl7XG4gIGNvbnNvbGUubG9nLmFwcGx5KGNvbnNvbGUsIGFyZ3VtZW50cyk7XG4gIHJldHVybiBhcmd1bWVudHNbMF07XG59O1xucHggPSAoZnVuY3Rpb24oaXQpe1xuICByZXR1cm4gaXQgKyAncHgnO1xufSk7XG5Db25uZWN0aW9uID0gKGZ1bmN0aW9uKCl7XG4gIENvbm5lY3Rpb24uZGlzcGxheU5hbWUgPSAnQ29ubmVjdGlvbic7XG4gIHZhciBwcm90b3R5cGUgPSBDb25uZWN0aW9uLnByb3RvdHlwZSwgY29uc3RydWN0b3IgPSBDb25uZWN0aW9uO1xuICBmdW5jdGlvbiBDb25uZWN0aW9uKHBvcnQpe1xuICAgIHRoaXMucG9ydCA9IHBvcnQgIT0gbnVsbCA/IHBvcnQgOiAzMDAxO1xuICB9XG4gIHJldHVybiBDb25uZWN0aW9uO1xufSgpKTtcblBsYXllciA9IChmdW5jdGlvbigpe1xuICBQbGF5ZXIuZGlzcGxheU5hbWUgPSAnUGxheWVyJztcbiAgdmFyIHByb3RvdHlwZSA9IFBsYXllci5wcm90b3R5cGUsIGNvbnN0cnVjdG9yID0gUGxheWVyO1xuICBmdW5jdGlvbiBQbGF5ZXIoKXtcbiAgICB2YXIgcmVmJDtcbiAgICBsb2coXCJOZXcgUGxheWVyXCIpO1xuICAgIHRoaXMueCA9IDA7XG4gICAgdGhpcy55ID0gMDtcbiAgICB0aGlzLncgPSAyMDtcbiAgICB0aGlzLmggPSAyMDtcbiAgICB0aGlzLnZpZXcgPSBkb2N1bWVudC5jcmVhdGVFbGVtZW50KCdkaXYnKTtcbiAgICByZWYkID0gdGhpcy52aWV3LnN0eWxlO1xuICAgIHJlZiQuYmFja2dyb3VuZENvbG9yID0gJ3JlZCc7XG4gICAgcmVmJC5oZWlnaHQgPSBweCh0aGlzLmgpO1xuICAgIHJlZiQud2lkdGggPSBweCh0aGlzLncpO1xuICAgIHJlZiQucG9zaXRpb24gPSAnYWJzb2x1dGUnO1xuICB9XG4gIHByb3RvdHlwZS5pbnN0YWxsID0gZnVuY3Rpb24oaG9zdCl7XG4gICAgcmV0dXJuIGhvc3QuYXBwZW5kQ2hpbGQodGhpcy52aWV3KTtcbiAgfTtcbiAgcHJvdG90eXBlLmxvb2tBdCA9IGZ1bmN0aW9uKGFyZyQpe1xuICAgIHZhciB4LCB5O1xuICAgIHggPSBhcmckLngsIHkgPSBhcmckLnk7XG4gIH07XG4gIHByb3RvdHlwZS5tb3ZlVG8gPSBmdW5jdGlvbihhcmckKXtcbiAgICB2YXIgeCwgeTtcbiAgICB4ID0gYXJnJC54LCB5ID0gYXJnJC55O1xuICAgIGxvZyhcIlBsYXllcjo6bW92ZS10b1wiLCB4LCB5KTtcbiAgICB0aGlzLnggPSB4O1xuICAgIHJldHVybiB0aGlzLnkgPSB5O1xuICB9O1xuICBwcm90b3R5cGUudXBkYXRlVmlldyA9IGZ1bmN0aW9uKCl7XG4gICAgbG9nKFwiUGxheWVyOnVwZGF0ZS12aWV3XCIsIHRoaXMueCwgdGhpcy55KTtcbiAgICB0aGlzLnZpZXcuc3R5bGUubGVmdCA9IHB4KHRoaXMueCAtIHRoaXMudyAvIDIpO1xuICAgIHJldHVybiB0aGlzLnZpZXcuc3R5bGUudG9wID0gcHgodGhpcy55IC0gdGhpcy5oIC8gMik7XG4gIH07XG4gIHJldHVybiBQbGF5ZXI7XG59KCkpO1xubWUgPSBuZXcgUGxheWVyO1xuZmllbGQgPSBkb2N1bWVudC5jcmVhdGVFbGVtZW50KCdkaXYnKTtcbnJlZiQgPSBmaWVsZC5zdHlsZTtcbnJlZiQucG9zaXRpb24gPSAnYWJzb2x1dGUnO1xucmVmJC5oZWlnaHQgPSAnMTAwJSc7XG5yZWYkLndpZHRoID0gJzEwMCUnO1xucmVmJC5iYWNrZ3JvdW5kQ29sb3IgPSAnYmxhY2snO1xubWUuaW5zdGFsbChmaWVsZCk7XG5kb2N1bWVudC5ib2R5LmFwcGVuZENoaWxkKGZpZWxkKTtcbmZpZWxkLmFkZEV2ZW50TGlzdGVuZXIoJ2NsaWNrJywgZnVuY3Rpb24oYXJnJCl7XG4gIHZhciB4LCB5O1xuICB4ID0gYXJnJC5jbGllbnRYLCB5ID0gYXJnJC5jbGllbnRZO1xuICBsb2coJ2NsaWNrZWQ/Jyk7XG4gIG1lLm1vdmVUbyh7XG4gICAgeDogeCxcbiAgICB5OiB5XG4gIH0pO1xuICByZXR1cm4gbWUudXBkYXRlVmlldygpO1xufSk7Il19
