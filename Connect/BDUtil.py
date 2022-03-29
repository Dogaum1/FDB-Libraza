import psycopg2

class ConnectBD:
    def __init__(self):
        self.__connection = None
    
    def getConection(self):
        if not self.__connection:
            self.__connection = psycopg2.connect(
                host='localhost',
                user='postgres',
                password='postgres',
                database='dataBase',
            )
        return self.__connection
 