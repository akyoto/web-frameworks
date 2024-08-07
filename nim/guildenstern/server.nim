import guildenstern/[dispatcher, httpserver]

proc handleGet(ctx: HttpContext) =
  if ctx.isUri("/") or not ctx.isMethod("GET"): ctx.reply(Http200)
  else:
    let id = ctx.getUri()[6 .. ^1]
    ctx.reply(id)

var server = new GuildenServer
server.initHeaderCtx(handleGet, 3000)

server.serve(loglevel = NONE)
