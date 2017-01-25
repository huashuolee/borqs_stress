from email.mime.text import MIMEText
import getpass
import time
import smtplib

#msg = MIMEText('asdfjljalsdjf jalsdjf;laj kjfaksldjf kkasjdfla jaksdfj lkcase in chaozhuo technology', 'plain', "utf-8")
msg['Subject'] = ("chaozhuo")
msg["From"] = ("test20100223_163@sina.com")
msg["To"] = ("test201002230319@163.com")
Body = "sending email every 10 minutes"


from_addr = "test20100223_163@sina.com"
password = "159753a"
# password = getpass.getpass()
smtp_server = "smtp.sina.com"
# to_addr = raw_input("To: ")
to_addr = "test201002230319@163.com"

try:
    for i in xrange(100):
        server = smtplib.SMTP(smtp_server, port=25, timeout=30)
        server.set_debuglevel(0)
        server.login(from_addr, password)
        server.sendmail(from_addr, to_addr, msg.as_string())
        server.quit()
        print("Successfully")
        print msg.as_string()
        time.sleep(60)
except Exception:
    print("Error when sending")
