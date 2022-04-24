from Module.UniversalDao import UniversalDao

class UserDao(UniversalDao):
    def __init__(self, connection):
        super(UserDao, self).__init__('User', connection)

