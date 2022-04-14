class Book:
    def __init__(self, id, title, author, edition, publisher, year_publication, num_pages, barcode, genre, location, cover, description):
        self.id = id
        self.title = title
        self.author = author
        self.edition = edition
        self.publisher = publisher
        self.year_publication = year_publication
        self.num_pages = num_pages
        self.barcode = barcode
        self.genre = genre
        self.location = location
        self.cover = cover
        self.description = description

    def getJson(self):
        return {
            'id': self.id,
            'title': self.title, 
            'author': self.author, 
            'edition': self.edition,
            'publisher': self.publisher, 
            'year_publication': self.year_publication, 
            'num_pages': self.num_pages,
            'bar_code': self.barcode,
            'genre': self.genre,
            'location': self.location,
            'cover': self.cover,
            'description': self.description,
        }
    
    def getValues(self):
        return self.getJson().values()