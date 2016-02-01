#_*_ coding:utf-8 _*_

from wsgiref.simple_server import make_server, demo_app

httpd = make_server('',8086,demo_app)
sa = httpd.socket.getsockname()
print 'http://{0}:{1}'.format(*sa)
httpd.serve_forever()
