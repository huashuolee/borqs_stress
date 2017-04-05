
class util(object):

    def a(self):
        print self.strpath

    def b(self):
        strpath = "44444444"
        self.strpath = "55555555"

        print self.strpath is strpath
        print self.strpath
        print strpath
        self.a()

if __name__=="__main__":
    util().b()
    #util().b()
