from Module.DaoModules import *
from flask import render_template
from .Translate import *
from .Attributes import *

def getDao(path, justOne = False):
    path = path.replace('/', '')
    object_dao = []
    exec(f"object_dao.append({path.title()}Dao(ConnectBD().getConection()))")
    if path == 'user' or path == 'employee':
        object_dao.append(AddressDao(ConnectBD().getConection()))
    elif path == 'book':
        object_dao.append(LocationDao(ConnectBD().getConection()))
    elif path == 'loan':
        object_dao.append(UserDao(ConnectBD().getConection()))
        object_dao.append(BookDao(ConnectBD().getConection()))
        
    if justOne: return object_dao[0]
    return object_dao

def renderForm(dao, path, mode = 'Pesquisar', id = None):
    if dao:
        exclude = []
        if mode == 'Cadastrar' or mode == 'Editar': exclude.append('Id')
        
        if path == 'book':
            if mode == 'Pesquisar': exclude.append('Capa')

        if mode == 'Editar':
            return render_template('edit_form_template.html', keys = [k.getKeys() for k in dao], values = [k.getOneValue(id) for k in dao], title = Translate().translate(dao[0].table_name).title(), sub_title = [Translate().translate(o.table_name).title() for o in dao], exclude = exclude, mode = mode.upper(), only_numbers = only_numbers, big_text = big_text, date = date)
        
        return render_template('form_template.html', keys = [k.getKeys() for k in dao], title = Translate().translate(dao[0].table_name).title(), sub_title = [Translate().translate(o.table_name).title() for o in dao], exclude = exclude, mode = mode.upper(), only_numbers = only_numbers, big_text = big_text, date = date)

def renderList(dao):
    objects = dao.getAll()
    keys = dao.getKeys()
    exclude = []
    if dao:
        if dao.table_name.lower() == 'book':
            exclude = ['Capa', 'Descrição']
            for obj in objects:
                exclude.append(obj.cover)
                exclude.append(obj.description)
        elif dao.table_name == 'User':
           pass
        
    return render_template('list_template.html', keys = keys, exclude = exclude, objects = [object.__dict__ for object in objects], table = dao.table_name.lower())

def renderDetails(dao, id):
    if dao:
        title = Translate().translate(dao.table_name).title()
        template = f"{dao.table_name.lower()}_details_template.html"
        return render_template(template, object = dao.getOne(id), title = title)