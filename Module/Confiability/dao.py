from Module.UniversalDao import UniversalDao

class ConfiabilityDao(UniversalDao):
    def __init__(self, connection):
        self.connection = connection
        self.cursor = connection.cursor()
        self.table_name = 'Confiability'
        super()
