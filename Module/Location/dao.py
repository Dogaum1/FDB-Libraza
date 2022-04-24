from Module.UniversalDao import UniversalDao

class LocationDao(UniversalDao):
    def __init__(self, connection):
        super(LocationDao, self).__init__('Location', connection)
