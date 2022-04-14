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
    
    def getValues(self):
        return self.__dict__.values()