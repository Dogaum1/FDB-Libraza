from flask import render_template
from Module.DaoModules import *
from .Translate import *
from .Attributes import only_numbers, date, big_text, forbidden

def getDao(path, justOne = False):
    path = path.replace('/', '')
    object_dao = []
    try:
        exec(f"object_dao.append({path.title()}Dao(ConnectBD().getConection()))")
    except:
        return False      
    return object_dao[0]

def renderForm(dao, mode = None, id = None, exclude = None, only_keys = False):
    object = dao.getAll(mode = mode, only_keys = only_keys)
    values = []
    if mode ==  'edit':
        object  = dao.getOne(id = id, mode = mode)
        values  = list(dao.getOne(id = id, mode = mode).values())
        
    return render_template( 'form_template.html',
                            object        = object, 
                            values        = values, 
                            keys_br       = [Translate().translate(k).title() for k in dao.getAll(mode = mode, only_keys = True)],
                            title         = Translate().translate(dao.table_name).title(), 
                            mode          = Translate().translate(mode).title(), 
                            only_numbers  = only_numbers, 
                            big_text      = big_text, 
                            date          = date, 
                            exclude       = exclude
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
                            title = Translate().translate(dao.table_name.lower())
                        )

def renderDetails(dao, id, mode = None):
    return render_template( f"{dao.table_name.lower()}_details_template.html", 
                            object = dao.getOne(id = id, mode = mode), 
                            title = Translate().translate(dao.table_name).title(),
                            path = dao.table_name.lower(),
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
                            method = method
                        )