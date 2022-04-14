from Module.UniversalDao import UniversalDao

class AuthorDao(UniversalDao):
    def __init__(self, connection):
        self.connection = connection
        self.cursor = connection.cursor()
        self.table_name = 'Author'
        super()