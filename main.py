from flask import Flask
from Connect.BDUtil import ConnectBD
from Module.Address.dao import AddressDao


app = Flask('')

@app.route("/address/")
def getAllAddress():
    address_dao = AddressDao(ConnectBD().getConection())
    address_list = address_dao.getAll()
    return {
        'status': True,
        'objects': [address.getJson() for address in address_list]
    }

app.run()
