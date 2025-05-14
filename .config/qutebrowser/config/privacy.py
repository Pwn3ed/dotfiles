def setup(c):
    c.content.cookies.accept = 'no-3rdparty'
    c.content.autoplay = False
    c.content.blocking.method = 'both'
    c.content.blocking.enabled = True
