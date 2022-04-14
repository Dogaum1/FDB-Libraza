import os, sqlite3

class SqlForge:
    def __init__(self, input) -> None:
        self.input      = input
        self.title      = ""
<<<<<<< HEAD
        self.globalAtributes  = []
        self.prepare()
        self.getAtributes()
        self.forge()
=======
        self.globalAtributes  = {}
        self.prepare()
        self.getAtributes()
        self.forge()

    # Separa o titulo da tabela do resto. Exemplo:
        # Titulo(atributo_1, atrubuto_2) -> (atributo_1, atrubuto_2)
>>>>>>> dfd388df2b608eb0ea135d7646615fbbdcdab9cc
    
    def prepare(self):
        c = 0
        for letter in self.input:
            if not letter == "(":
                c = c + 1
                self.title = self.title + letter
            else:
                self.input = self.input[c::]
                break

<<<<<<< HEAD
    def getAtributes(self):
        attributeList = self.input
        
        exclude = ['(', ')', ' ', '\n']
=======
    # Transforma os atributos em dicionarios, tendo o dicionario "global" e os dicionarios "locais" para os Data Types. 
    # No caso de varchar é feito uma lista com o tipo na primeira posição e o tamanho na segunda.

    # Exemplo:
        # Autor(id:pk, nome:varchar:255)
            # dicionario global = {'0' = {'titulo' = 'id', 'atributo1' = 'pk'}, '1' = {'titulo' = 'nome', 'atributo1' = ['varchar', '255']}}
        
        # Localização(id:pk, estante:int, prateleira:int)
             # dicionario global = {'0' = {'titulo' = 'id', 'atributo1' = 'pk'}, '1' = {'titulo' = 'estante', 'atributo1' = 'int'}, '2' =  {'titulo' = 'prateleira', 'atributo1' = 'int'} }

    def getAtributes(self):
        attributeList = self.input
        
        exclude = ['(', ')', ' ']
>>>>>>> dfd388df2b608eb0ea135d7646615fbbdcdab9cc
        for e in exclude:
            attributeList = attributeList.replace(e, '')
        
        attributeList = attributeList.split(',')
<<<<<<< HEAD
        attributeInformation = []

        for attribute in attributeList:
            attribute  = attribute.split(':')
            attributeInformation.append(attribute[0])
            
            c = 1
            isVarchar = False

            for a in range(1, len(attribute)):
                if attribute[a] == 'varchar':
                    attributeInformation.append([attribute[a], attribute[a+1]])
=======
        attributeInformation = {}

        for attribute in attributeList:
            attribute  = attribute.split(':')
            attributeInformation["title"] = attribute[0]
            
            c = 1
            isVarchar = False
            for a in range(1, len(attribute)):
                if attribute[a] == 'varchar':
                    attributeInformation[f"attribute{c}"] = [attribute[a], attribute[a+1]]
>>>>>>> dfd388df2b608eb0ea135d7646615fbbdcdab9cc
                    a = a + 2
                    isVarchar = True
                
                elif isVarchar:
                    isVarchar = False
                    c = c - 1
                    pass
                
                else:
<<<<<<< HEAD
                    attributeInformation.append(attribute[a])
                c = c + 1

            self.globalAtributes.append(attributeInformation)
            attributeInformation = []

    def forge(self):
        obj     = sqlite3.connect('dataBase.db')
=======
                    attributeInformation[f"attribute{c}"] = attribute[a]
                c = c + 1

            self.globalAtributes[f"{len(self.globalAtributes)}"] = attributeInformation
            attributeInformation = {}

    def forge(self):
        obj     = sqlite3.connect('tables.db')
>>>>>>> dfd388df2b608eb0ea135d7646615fbbdcdab9cc
        cursor  = obj.cursor()
        start       = f"CREATE TABLE {self.title}(\n"
        midle       = ""
        final       = ");"

        for i in range(len(self.globalAtributes)):
<<<<<<< HEAD
            attributeTitle = self.globalAtributes[i][0] 
            a = attributeTitle
            
            for o in range(1, len(self.globalAtributes[i])):
                attribute = (self.globalAtributes[i][o])
=======
            attributeTitle = self.globalAtributes[f"{i}"]["title"] 
            
            for o in range(1, len(self.globalAtributes[f'{i}'])):
                attribute = (self.globalAtributes[f"{i}"][f"attribute{o}"])
                a = attributeTitle
>>>>>>> dfd388df2b608eb0ea135d7646615fbbdcdab9cc
                a = a + f" {SQL.convert(attribute)}"
            
            # caso seja o ultimo atributo, não adiciona a virgula
            if not i == len(self.globalAtributes)-1:
                a = a + ',\n'
            else:
                a = a + '\n'
            
            midle = f"{midle} {a}"
            a = ""
<<<<<<< HEAD

=======
            
>>>>>>> dfd388df2b608eb0ea135d7646615fbbdcdab9cc
        cursor.execute(f"{start}{midle}{final}")
        obj.close()

class SQL:
    @staticmethod
    def convert(value):
<<<<<<< HEAD

=======
>>>>>>> dfd388df2b608eb0ea135d7646615fbbdcdab9cc
        CONVERSION_TABLE = {
            "pk"        : "PRIMARY KEY",
            "fk"        : "FOREIGN KEY",
            "notNull"   : "NOT NULL",
            "unique"    : "UNIQUE",
            "varchar"   : "VARCHAR",
            "int"       : "INTEGER",
            "boolean"   : "BOOLEAN",
            "date"      : "DATE",
            "dateTime"  : "DATETIME"
        }
        try:
<<<<<<< HEAD
            if type(value) is list:
                if value[0] == "varchar":
                    return f"{CONVERSION_TABLE.get(value[0])}({value[1]})"
            return CONVERSION_TABLE.get(value)
        except:
            pass

os.system('cls')

with open('me.txt', 'r', encoding='utf-8') as file:
=======
            return CONVERSION_TABLE.get(value, "Erro")
        except:
            if type(value) is list:
                if value[0] == "varchar":
                    return f"{CONVERSION_TABLE.get(value[0])}({value[1]})"

os.system('cls')

with open('mer.txt', 'r', encoding='utf-8') as file:
>>>>>>> dfd388df2b608eb0ea135d7646615fbbdcdab9cc
    for line in file.readlines():
        if not line.isspace():
            SqlForge(line)