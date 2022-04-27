class Translate:
    def __init__(self):
        self.words = {
            'id': 'id',
            #? Livro
            'book'                      : 'livro',
            'user'                      : 'usuário',
            'title'                     : 'titulo',
            'author'                    : 'autor',
            'edition'                   : 'edição',
            'publisher'                 : 'editora',
            'year_publication'          : 'ano de publicação',
            'num_pages'                 : 'número de paginas',
            'barcode'                   : 'ISBN',
            'genre'                     : 'genero',
            'location'                  : 'localização',
            'cover'                     : 'capa',
            'description'               : 'descrição',
            'amount'                    : 'quantidade',
            
            #? Usuario  	
            'cpf'                       : 'CPF',
            'phone'                     : 'telefone',	
            'address'                   : 'endereço',	 	
            'birth_date'                : 'data de nascimento',
            'confiability'              : 'confiabilidade',
            'email'                     : 'e-mail',
            
            #? Enderço
            'type'                      : 'tipo',
            'name'                      : 'nome',
            'number'                    : 'número',
            'district'                  : 'bairro',
            'city'                      : 'cidade',
            'state'                     : 'estado',
            'zip_code'                  : 'CEP',
            
            #? Empresa
            'company'                   :'empresa',
            
            #? Confiabilidade
            'amt_allowed_books'         :'livros permitidos',
            'amt_borrowed_books'        :'livros emprestados',
            
            #? Funcionario
            'employee'                  :'funcionário',
            'registration'              :'matricula',
            'password'                  :'senha',
            
            #? Empréstimo
            'loan'                      :'Empréstimo',
            'start_date'                :'início',
            'return_period'             :'validade',
            'return_date'               :'devolução',
            
            #? Localização
            'stand'                     : 'estante',
            'shelf'                     : 'prateleira',
            
            #? Outros
            'search'                    :'pesquisar',
            'edit'                      :'editar',
            'add'                       :'cadastrar',      
        }
    
    def translate(self, word):
        try:
            return self.words[word.lower()]
        except:
            return word.title()
        
