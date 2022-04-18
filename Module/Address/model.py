class Address:
    def __init__(self, id, type, logradouro, number, district, city, state, zip_code):
        self.id = id
        self.type = type
        self.logradouro = logradouro
        self.number = number
        self.district = district
        self.city = city
        self.state = state
        self.zip_code = zip_code
        
    def getValues(self):
        return self.__dict__.values()
