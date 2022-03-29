class Address:
    def __init__(self, id, type, name, number, district, city, state, postal_code):
        self.id = id
        self.type = type
        self.name = name
        self.number = number
        self.district = district
        self.city = city
        self.state = state
        self.zip_code = postal_code

    def getJson(self):
        return {
            'id': self.id,
            'type': self.type,
            'name': self.name,
            'number': self.number,
            'district': self.district,
            'city': self.city,
            'state': self.state,
            'zip_code': self.zip_code
        }
