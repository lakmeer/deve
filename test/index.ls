
{ log } = require \../common/helpers

# Require

require! \assert

log require \../app/client
log require \../app/socket-server

suite "Test runner" ->
  test "It runs" ->
    assert.equal 1, 1

