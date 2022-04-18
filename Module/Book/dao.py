from Module.UniversalDao import UniversalDao
from Module.Book.model import Book

class BookDao(UniversalDao):
    def __init__(self, connection):
        super(BookDao, self).__init__('Book', connection.cursor())