class Seal:
    def __init__(self, id):
        self.id = id
        self.bronze = 0
        self.silver = 1
        self.gold = 2

    def getJson(self):
        return {
            'id': self.id,
            'bronze': self.bronze,
            'silver': self.silver,
            'gold': self.gold
        }
    
    def getValues(self):
        return self.getJson().values()