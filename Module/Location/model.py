class Location:
    def __init__(self, id, stand, shelf):
        self.id = id
        self.stand = stand
        self.shelf = shelf
    
    def getValues(self):
        return self.__dict__.values()