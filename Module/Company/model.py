class Company:
    def __init__(self, id, name, cnpj):
        self.id = id
        self.name = name
        self.cnpj = cnpj

    def getJson(self):
        return {
            'id': self.id, 
            'name': self.name, 
            'cnpj': self.cnpj  
        }