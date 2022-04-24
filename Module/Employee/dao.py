from Module.UniversalDao import UniversalDao

class EmployeeDao(UniversalDao):
    def __init__(self, connection):
        super(EmployeeDao, self).__init__('Employee', connection)

