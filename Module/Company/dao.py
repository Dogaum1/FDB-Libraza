from Module.UniversalDao import UniversalDao

class CompanyDao(UniversalDao):
    def __init__(self, connection):
        super(CompanyDao, self).__init__('Company', connection.cursor())