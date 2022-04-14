class Employee():
    def __init__(self, id, name, cpf, phone, address, email, birth_date, registration, password):
        self.id = id
        self.name = name
        self.cpf = cpf
        self.phone = phone
        self.address = address
        self.email = email
        self.birth_date = birth_date
        self.registration = registration
        self.password = password
        
    def getValues(self):
        return self.__dict__.values()

