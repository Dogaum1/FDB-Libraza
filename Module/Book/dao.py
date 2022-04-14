from Module.UniversalDao import UniversalDao

class BookDao(UniversalDao):
    def __init__(self, connection):
        self.connection = connection
        self.cursor = connection.cursor()
        self.table_name = 'Book'
        super()
