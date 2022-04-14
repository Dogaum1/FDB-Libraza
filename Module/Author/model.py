class Author:
    def __init__(self, id, name):
        self.id = id
        self.name = name
    
    def getValues(self):
        return self.__dict__.values()