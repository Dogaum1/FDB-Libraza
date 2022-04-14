from Module.UniversalDao import UniversalDao

class SealDao:
    def __init__(self, connection):
        self.connection = connection
        self.table = 'Seal'
    
    def getAll(self):
        return UniversalDao().getAll(self.connection.cursor(), self.table)

    def getOne(self, id):
        return UniversalDao().getOne(self.connection.cursor(), self.table, id)

    def getKeys(self):
        return UniversalDao().getKeys(self.connection.cursor(), self.table)
    
    def getValues(self):
        return UniversalDao().getValues(self.connection.cursor(), self.table)
