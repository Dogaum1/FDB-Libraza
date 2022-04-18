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

    def getAll(self, mode = None, only_keys = False, script = None):
        if not script: script = self.getAllScript(mode, only_keys)
        self.cursor.execute(script)
        query = self.cursor.fetchone()
        object_list = []
        col_names = [d[0] for d in self.cursor.description]
        if only_keys: return col_names
        
        while query is not None:
            mappings = dict(zip(col_names, query))
            object_list.append(mappings)
            query = self.cursor.fetchone()
        
        return object_list
    
    def getAllScript(self, mode = None, only_keys = False):
        if only_keys: return self.getAllScript(mode).replace(';', '') + f' WHERE false;'
        if type:
            return f'SELECT * FROM "{self.table_name}_{mode}"'
        return f'SELECT * FROM "{self.table_name}"'

    def getOne(self, id, mode = None):
        script = self.getOneScript(mode, id)
        self.cursor.execute(script)
        query = self.cursor.fetchone()
        col_names = [d[0] for d in self.cursor.description]

        if query:
            mappings = dict(zip(col_names, query))
            return mappings
    
    def getOneScript(self, type = None, id = None):
        if type:
            return f'SELECT * FROM "{self.table_name}_{type}" WHERE ID = {id}'
        return f'SELECT * FROM "{self.table_name}" WHERE ID = {id}'
    
    def getSearch(self, script):
        self.cursor.execute(script)
        query = self.cursor.fetchone()
        object_list = []
        col_names = [d[0] for d in self.cursor.description]
        
        while query is not None:
            mappings = dict(zip(col_names, query))
            object_list.append(mappings)
            query = self.cursor.fetchone()
        
        print(object_list)
        
        return object_list