from Module.UniversalDao import UniversalDao

class EmployeeDao(UniversalDao):
    def __init__(self, connection):
        self.connection = connection
        self.cursor = connection.cursor()
        self.table_name = 'Employee'
        super()

