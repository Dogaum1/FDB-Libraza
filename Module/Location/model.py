class Location:
    def __init__(self, id, stand, shelf):
        self.id = id
        self.stand = stand
        self.shelf = shelf

    def getJson(self):
        return {
            'id': self.id,
            'stand': self.stand,
            'shelf': self.shelf
        }