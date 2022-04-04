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

class UniversalDao:
    def __init__(self):
        pass

    def getAll(self, cursor, table):
        object_list = []
        script = f'SELECT * FROM "{table}"'
        cursor.execute(script)
        query = cursor.fetchone()
        col_names = [d[0] for d in cursor.description]
        
        while query is not None:
            mappings = dict(zip(col_names, query))
            exec(f"object_list.append({table}(**mappings))")
            query = cursor.fetchone()
        
        return object_list

    def getOne(self, cursor, table, id):
        script = f'SELECT * FROM "{table}" WHERE ID = {id}'
        cursor.execute(script)
        query = cursor.fetchone()
        col_names = [d[0] for d in cursor.description]

        if query:
            mappings = dict(zip(col_names, query))
            r =  []
            exec(f"r.append({table}(**mappings))")
            return r[0]
