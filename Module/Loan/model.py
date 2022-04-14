class Loan:
    def __init__(self, id, user, book, start_date, return_period, return_date):
        self.id = id
        self.user = user
        self.book = book
        self.start_date = start_date
        self.return_period = return_period
        self.return_date = return_date
        
    def getValues(self):
        return self.getJson().values()