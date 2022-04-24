from Module.UniversalDao import UniversalDao

class ConfiabilityDao(UniversalDao):
    def __init__(self, connection):
        super(ConfiabilityDao, self).__init__('Confiability', connection)
