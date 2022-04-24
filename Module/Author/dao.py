from Module.UniversalDao import UniversalDao

class AuthorDao(UniversalDao):
    def __init__(self, connection):
        super(AuthorDao, self).__init__('Author', connection)