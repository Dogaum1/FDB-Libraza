from faulthandler import disable


forbidden = [
    'confiability', 
    'address', 
    'author',
    'location',
]

only_numbers = [
    'year_publication', 
    'num_pages', 
    'number', 
    'cnpj',
    'edition',
    'stand',
    'shelf'
]

big_text = [
    'description'
]

date = [
    'birth_date',
    'start_date',
    'return_date',
    'return_period'
]

like = [
    'name', 
    'title', 
    'publisher', 
    'author', 
    'user', 
    'book',
    'confiability'
]

exact = [
    'cpf', 
    'id', 
    'stand', 
    'shelf', 
    'year_publication', 
    'barcode', 
    'edition', 
    'birth_date', 
    'start_date', 
    'return_date',
    'return_period'
]