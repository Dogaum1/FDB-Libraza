class Mook:
    def __init__(self, id, title, author, edition, publisher, year_publication, num_pages, bar_code, genre, location):
        self.id = id
        self.title = title
        self.author = author
        self.edition = edition
        self.publisher = publisher
        self.year_publication = year_publication
        self.num_pages = num_pages
        self.bar_code = bar_code
        self.genre = genre
        self.location = location

    def getJson(self):
        return {
            'id': self.id,
            'title': self.title, 
            'author': self.author, 
            'edition': self.edition,
            'publisher': self.publisher, 
            'year_publication': self.year_publication, 
            'num_pages': self.num_pages,
            'bar_code': self.bar_code,
            'genre': self.genre,
            'location': self.location
        }