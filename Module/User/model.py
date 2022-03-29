class User:
    def __init__(self, id, name, cpf, phone, address, email, confiability, birth_date ):
        self.id = id
        self.name = name
        self.cpf = cpf
        self.phone = phone
        self.address = address
        self.email = email
        self.confiability = confiability
        self.birth_date = birth_date
    
    def getJson(self):
        return {
            'id': self.id,
            'name': self.name,
            'cpf': self.cpf,
            'phone':self.phone,
            'address':self.address,
            'email':self.email,
            'confiability':self.confiability,
            'birth_date':self.birth_date
        }

