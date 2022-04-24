from Module.UniversalDao import UniversalDao

class LoanDao(UniversalDao):
    def __init__(self, connection):
        super(LoanDao, self).__init__('Loan', connection)

