from Module.Address.model import Address
from Module.Book.model import Book
from Module.Author.model import Author
from Module.Company.model import Company
from Module.Confiability.model import Confiability
from Module.Employee.model import Employee
from Module.Loan.model import Loan
from Module.Location.model import Location
from Module.Seal.model import Seal
from Module.User.model import User
from Util.Translate import Translate

class UniversalDao:
    def __init__(self, table_name, cursor):
        self.table_name = table_name
        self.cursor = cursor

    def getAll(self):
        object_list = []
        script = f'SELECT * FROM "{self.table_name}"'
        self.cursor.execute(script)
        query = self.cursor.fetchone()
        col_names = [d[0] for d in self.cursor.description]
        
        while query is not None:
            mappings = dict(zip(col_names, query))
            exec(f"object_list.append({self.table_name}(**mappings))")
            query = self.cursor.fetchone()
        
        return object_list

    def getOne(self, id):
        script = f'SELECT * FROM "{self.table_name}" WHERE ID = {id}'
        self.cursor.execute(script)
        query = self.cursor.fetchone()
        col_names = [d[0] for d in self.cursor.description]

        if query:
            mappings = dict(zip(col_names, query))
            r =  []
            exec(f"r.append({self.table_name}(**mappings))")
            return r[0]
    
    def getKeys(self, with_id=False):
        script = f'SELECT * FROM "{self.table_name}"'
        self.cursor.execute(script)
        col_names = [Translate().translate(d[0]).title() for d in self.cursor.description]
        if with_id: return col_names
        else:
            return col_names
    
    def getValues(self):
        values_list = []
        script = f'SELECT * FROM "{self.table_name}"'
        self.cursor.execute(script)
        query = self.cursor.fetchone()
        
        while query is not None:
            mappings = list(query)
            exec(f"values_list.append({self.table_name}(*mappings).getValues())")
            query = self.cursor.fetchone()        
        return values_list

    def getOneValue(self, id):
        script = f'SELECT * FROM "{self.table_name}" WHERE ID = {id}'
        self.cursor.execute(script)
        query = self.cursor.fetchone()
        if query:
            r =  []
            exec(f"r.append({self.table_name}(*query))")
            return list(r[0].getValues())
