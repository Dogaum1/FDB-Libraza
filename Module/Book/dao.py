from Module.UniversalDao import UniversalDao

class BookDao:
    def __init__(self, connection):
        self.connection = connection
        self.table = 'Book'
    
    def getAll(self):
        return UniversalDao().getAll(self.connection.cursor(), self.table)

    def getOne(self, id):
        return UniversalDao().getOne(self.connection.cursor(), self.table, id)
