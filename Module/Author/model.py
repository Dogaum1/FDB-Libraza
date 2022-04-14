class Author:
    def __init__(self, id, name):
        self.id = id
        self.name = name
    
    def getJson(self):
        return {
            'id': self.id,
            'name': self.name
        }
    
    def getValues(self):
        return self.getJson().values()