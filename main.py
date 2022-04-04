from flask import render_template
from Module.DaoModules import *
import os

app = Flask('')

@app.route("/<path:path>/")
def getAll(path):
    object_dao = []
    exec(f"object_dao.append({path.title()}Dao(ConnectBD().getConection()))")
    object_list = object_dao[0].getAll()
    object = {
        'status': True,
        'objects': [o.getJson() for o in object_list]
    }

    obj = object['objects']
    keys = object["objects"][0].keys()
    values = []
    for o in range (len(obj)):
        values.append(list(obj[o].values()))

    return render_template('template.html', obj = obj , obj_len = len(obj), keys = keys, keys_len = len(keys), values = values, values_len = len(values))
    # return f"{values}"

@app.route("/<path:path>/<int:id>/")
def getAddress(path, id):
    object_dao = []
    exec(f"object_dao.append({path.title()}Dao(ConnectBD().getConection()))")
    object = object_dao[0].getOne(id)
    if object:
        return object.getJson()
    return {}

@app.route("/template/")
def returnTemplate():
    return render_template('template.html', object)
    

app.run()
