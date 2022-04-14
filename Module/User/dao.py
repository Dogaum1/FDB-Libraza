from Module.UniversalDao import UniversalDao

class UserDao(UniversalDao):
    def __init__(self, connection):
        self.connection = connection
        self.cursor = connection.cursor()
        self.table_name = 'User'
        super()

