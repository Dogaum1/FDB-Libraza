import os, sqlite3

class SqlForge:
    def __init__(self, input) -> None:
        self.input      = input
        self.title      = ""
        self.globalAtributes  = {}
        self.prepare()
        self.getAtributes()
        self.forge()
        
    # Separa o titulo da tabela do resto. Exemplo:
        # Titulo(atributo_1, atrubuto_2) -> (atributo_1, atrubuto_2)
    def prepare(self):
        c = 0
        for letter in self.input:
            if not letter == "(":
                c = c + 1
                self.title = self.title + letter
            else:
                self.input = l[c::]
                break

    # transforma os atributos em dicionarios
    def getAtributes(self):
        attributeList = self.input
        
        exclude = ['(', ')', ' ']
        for e in exclude:
            attributeList = attributeList.replace(e, '')
        
        attributeList = attributeList.split(',')
        attributeInformation = {}

        for attribute in attributeList:
            
            attribute  = attribute.split(':')
            attributeInformation["title"] = attribute[0]
            
            c = 1
            isVarchar = False
            for a in range(1, len(attribute)):
                if attribute[a] == 'varchar':
                    attributeInformation[f"attribute{c}"] = [attribute[a], attribute[a+1]]
                    a = a + 2
                    isVarchar = True
                
                elif isVarchar:
                    isVarchar = False
                    c = c - 1
                    pass
                
                else:
                    attributeInformation[f"attribute{c}"] = attribute[a]
                c = c + 1

            self.globalAtributes[f"{len(self.globalAtributes)}"] = attributeInformation
            attributeInformation = {}

    def forge(self):
        obj     = sqlite3.connect('tables.db')
        cursor  = obj.cursor()

        action      = ""
        start       = f"CREATE TABLE {self.title}(\n"
        midle       = ""
        final       = ");"

        for i in range(len(self.globalAtributes)):
            attributeTitle = self.globalAtributes[f"{i}"]["title"] 
            
            for o in range(1, len(self.globalAtributes[f'{i}'])):
                attribute = (self.globalAtributes[f"{i}"][f"attribute{o}"])
                a = attributeTitle
                a = a + f" {SQL.convert(attribute)}"
            
            if not i == len(self.globalAtributes)-1:
                a = a + ',\n'
            else:
                a = a + '\n'
            
            midle = f"{midle} {a}"
            a = ""
            
        action = f"{start}{midle}{final}"

        print(action)
        cursor.execute(action)
        obj.close()

class SQL:
    @staticmethod
    def convert(value):
        CONVERSION_TABLE = {
            "pk" : "PRIMARY KEY",
            "notNull": "NOT NULL",
            "varchar" : "VARCHAR",
            "int" : "INTEGER",
        }
        try:
            return CONVERSION_TABLE.get(value, "Erro")
        except:
            if type(value) is list:
                if value[0] == "varchar":
                    return f"{CONVERSION_TABLE.get(value[0])}({value[1]})"

os.system('cls')
l = "Livro(id:pk, autor:varchar:255:notNull, titulo:varchar:255:notNull, edicao:int, editora:varchar:255, anoPublicacao:int, numPaginas:int, codBarras:varchar:255, genero:varchar:255)"
test = SqlForge(l)