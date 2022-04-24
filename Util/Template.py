from flask import render_template, session
from Module.DaoModules import *
from .Translate import *
from .Attributes import *

def getDao(path):
    path = path.replace('/', '')
    object_dao = []
    try:
        exec(f"object_dao.append({path.title()}Dao(ConnectBD().getConection()))")
    except:
        return False      
    return object_dao[0]

def renderForm(dao, mode = None, id = None, exclude = None, only_keys = False, method = None, read_only = ('id')):
    object = dao.getAll(mode = mode, only_keys = only_keys)
    values = []
    if mode ==  'edit':
        object  = dao.getOne(id = id, mode = mode)
        values  = list(dao.getOne(id = id, mode = mode).values())
        
    return render_template( 'form_template.html',
                            values        = values, 
                            keys          = [k for k in dao.getAll(mode = mode, only_keys = True)],
                            keys_br       = [Translate().translate(k).title() for k in dao.getAll(mode = mode, only_keys = True)],
                            title         = Translate().translate(dao.table_name).title(),
                            path          = dao.table_name.title(), 
                            mode          = Translate().translate(mode).title(), 
                            method        = method,
                            exclude       = exclude,
                            date          = date, 
                            big_text      = big_text, 
                            only_numbers  = only_numbers,
                            read_only     = read_only,
                            username = session.get('user'), 
                        )

def renderList(dao):
    template  = 'list_template.html'
    exclude = []
    if dao.table_name == 'User': 
        template = 'user_list_template.html'
        exclude = ['Id', 'Confiabilidade']
    elif dao.table_name == 'Book':    
        template = 'book_list_template.html'
        
    return render_template( template, 
                            objects = dao.getAll(mode = 'list'), 
                            keys = [Translate().translate(k).title() for k in dao.getAll(mode = 'list', only_keys = True)], 
                            path = dao.table_name.lower(),
                            exclude = exclude,
                            title = Translate().translate(dao.table_name.lower()),
                            username = session.get('user'),
                        )

def renderDetails(dao, id, mode = None, invalid = False):
    return render_template( f"{dao.table_name.lower()}_details_template.html", 
                            object = dao.getOne(id = id, mode = mode), 
                            title = Translate().translate(dao.table_name).title(),
                            path = dao.table_name.lower(),
                            username = session.get('user'),
                            invalid = invalid
                          )
    
def renderResult(dao, script, method = ''):
    template  = 'list_template.html'
    exclusive_templates = ['User', 'Book']
    exclude = []
    if dao.table_name in exclusive_templates: 
        template = f'{dao.table_name.title()}_list_template.html'
        
    return render_template( template, 
                            objects = dao.getSearch(script = script), 
                            keys = [Translate().translate(k).title() for k in dao.getAll(mode = 'list', only_keys = True, script = script)], 
                            path = dao.table_name.lower(),
                            title = Translate().translate(dao.table_name.lower()),
                            method = method,
                            username = session.get('user'),
                        )

def renderData(path, object, mode, after_object = None, update = False):
    return render_template( 'data_result_template.html',
                            path = Translate().translate(path).title(),
                            keys_br = [Translate().translate(k).title() for k in object.keys()],
                            keys = list(object.keys()),
                            object = object,
                            after_object = after_object,
                            update = update,
                            mode = mode,
                            username = session.get('user'),
                          )
    