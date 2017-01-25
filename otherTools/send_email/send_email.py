from email.mime.text import MIMEText
import time
import smtplib


class Sending(object):

    def __init__(self):
        self.body = "sending email every 10 minutes"
        self.msg = MIMEText(self.body, "plain", "utf-8")
        self.msg['Subject'] = "chaozhuo"
        self.msg["From"] = "test20100223@163.com"
        self.msg["To"] = "test2010022303@163.com"
        self.from_addr = "test20100223@163.com"
        self.password = "159753abcd"
        self.smtp_server = "smtp.163.com"
        self.to_addr = "test20100223@163.com"

    def start(self):
        for i in xrange(1000):
            print("Test round {}".format(i))
            server = smtplib.SMTP(self.smtp_server, port=25, timeout=30)
            server.set_debuglevel(0)
            server.login(self.from_addr, self.password)
            server.sendmail(self.from_addr, self.to_addr, self.msg.as_string())
            server.quit()
            #print("Successfully")
            #print self.msg.as_string()
            time.sleep(900)

if __name__ == "__main__":
    Sending().start()
