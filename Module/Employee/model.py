import User.model as User
class Employee(User):
    def __init__(self, registration, password):
        User.__init__(self)
        self.registration = registration
        self.password = password

    def getJson(self):
        return {
            'id': self.id,
            'name': self.name,
            'cpf': self.cpf,
            'phone':self.phone,
            'address':self.address,
            'email':self.email,
            'confiability':self.confiability,
            'birth_date':self.birth_date,
            'registration': self.registration,
            'password': self.password
        }

