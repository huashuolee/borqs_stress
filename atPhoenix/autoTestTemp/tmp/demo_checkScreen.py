from uiautomatorplug.android import device as d
import time

d.server.jsonrpc.sleep()
if d.screen == "off":  # of d.screen != "on"
    d.wakeup()
    time.sleep(2)
    d.press("menu")
