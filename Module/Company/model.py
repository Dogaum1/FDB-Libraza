class Company:
    def __init__(self, id, name, cnpj):
        self.id = id
        self.name = name
        self.cnpj = cnpj
        
    def getValues(self):
        return self.getJson().values()