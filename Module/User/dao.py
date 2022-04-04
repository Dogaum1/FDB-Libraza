from Module.UniversalDao import UniversalDao

class UserDao:
    def __init__(self, connection):
        self.connection = connection
        self.table = 'User'
    
    def getAll(self):
        return UniversalDao().getAll(self.connection.cursor(), self.table)

    def getOne(self, id):
        return UniversalDao().getOne(self.connection.cursor(), self.table, id)
