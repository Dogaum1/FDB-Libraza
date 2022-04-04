from Module.Confiability.model import Confiability


class User:
    def __init__(self, id, name, cpf, phone, address, email, birth_date, confiability):
        self.id = id
        self.name = name
        self.cpf = cpf
        self.phone = phone
        self.address = address
        self.email = email
        self.birth_date = birth_date
        self.confiability = confiability
    
    def getJson(self):
        return {
            'id': self.id,
            'name': self.name,
            'cpf': self.cpf,
            'phone':self.phone,
            'address': self.address,
            'email':self.email,
            'birth_date':self.birth_date,
            'confiability': self.confiability
        }

