from Module.UniversalDao import UniversalDao

class AddressDao(UniversalDao):
    def __init__(self, connection):
        self.connection = connection
        self.cursor = connection.cursor()
        self.table_name = 'Address'
        super()
