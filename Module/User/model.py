class User:
    def __init__(self, id, name, cpf, phone, address, email, birth_date, confiability):
        self.id = id
        self.name = name
        self.cpf = cpf
        self.phone = phone
        self.email = email
        self.birth_date = birth_date
        self.confiability = confiability
        self.address = address
    
    def getValues(self):
        return self.__dict__.values()

