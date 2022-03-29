import imp
from Module.Address.model import Address

class AddressDao:
    def __init__(self, connection):
        self.connection = connection
    
    def getAll(self):
        address_list = []
        script = "select * from Address"
        cursor = self.connection.cursor()
        cursor.execute(script)
        query = cursor.fetchone()
        col_names = [d[0] for d in cursor.description]
        while not query:
            mapping = dict(zip(col_names, query))
            address_list.append(Address(**mapping))
            query = cursor.fetchone()
        return address_list