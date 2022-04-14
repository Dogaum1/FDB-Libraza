import os
from flask import Flask, render_template, Blueprint
from Module.DaoModules import *
from Util.Translate import Translate

app = Flask('')

@app.route("/")
def home():
    return render_template('home.html')

@app.route("/<path:path>/")
def getAll(path):
    # return render_template('home.html')
    object_dao = []
    exec(f"object_dao.append({path.title()}Dao(ConnectBD().getConection()))")
    return renderList(object_dao[0])
    # keys = object_dao[0].getKeys(True)
    # values = object_dao[0].getValues()
    # len_values = len(values)
    # ids = [list(id)[0] for id in values]
    # return render_template('all_items_template.html', keys = keys, values = values, len_values = len_values, title = Translate().translate(path).title(), path = path, ids=ids)
    
@app.route("/<path:path>/<int:id>/")
def getOne(path, id):
    object_dao = []
    exec(f"object_dao.append({path.title()}Dao(ConnectBD().getConection()))")
    if object:
        return renderDetails(object_dao[0], id)
        # return render_template('one_item_template.html', keys = object_dao[0].getKeys(True), values = object_dao[0].getOneValue(id), title = Translate().translate(path).title())
    return {}

@app.route("/add/<path:path>/")
def add(path):
    object_dao = []
    exec(f"object_dao.append({path.title()}Dao(ConnectBD().getConection()))")
    return render_template('add_item_template.html', keys = object_dao[0].getKeys(), title = Translate().translate(path).title())

@app.route("/search/<path:path>/")
def search(path):
    object_dao = []
    exec(f"object_dao.append({path.title()}Dao(ConnectBD().getConection()))")
    keys = object_dao[0].getKeys(True)
    return render_template('search_item_template.html', keys = keys, len = len(keys), title = Translate().translate(path).title())

def renderDetails(dao, id):
    if dao.table_name == 'Book':
        return render_template('book_details_template.html', book = dao.getOne(id), title = Translate().translate('book').title())

def renderList(dao):
    if dao.table_name == 'Book':
        objects = dao.getAll()
        keys = dao.getKeys()
        exclude = ['Capa', 'cover']
        for obj in objects:
            exclude.append(obj.cover)
        
    return render_template('list_template.html', keys = keys, exclude = exclude, objects = [object.getJson() for object in objects], table = dao.table_name)

app.run()