class Confiability:
    def __init__(self, id, amt_allowed_books, amt_borrowed_books):
        self.id = id
        self.amt_allowed_books = amt_allowed_books
        self.amt_borrowed_books = amt_borrowed_books
        
    def getValues(self):
        return self.getJson().values()
