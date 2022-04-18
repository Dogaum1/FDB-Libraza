from Module.UniversalDao import UniversalDao

class AddressDao(UniversalDao):
    def __init__(self, connection):
        super(AddressDao, self).__init__('Address', connection.cursor())
