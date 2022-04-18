from flask import Blueprint, request
from Util.Template import *
from Util.Attributes import exact, like

search_core = Blueprint('search', __name__, url_prefix='/search')

@search_core.route("/<path:path>/", methods = ['GET', 'POST'])
def search(path):
    dao = getDao(path)
    if not dao or path in forbidden: return render_template('erro_404_template.html'), 404
    if request.method == 'GET': 
        if not len(list(request.args)) == 0: 
            return searchOne(list(request.args), path)
    exclude = []
    if path == 'book': exclude = ['Capa'] 
    return renderForm(  dao = dao, 
                        mode = 'search', 
                        only_keys = True, 
                        exclude = exclude
                     )

def searchOne(form_keys, path):
    dao = getDao(path)
    script =  f""" SELECT * FROM "{path.title()}_search" WHERE"""
    
    print(request.args)
    
    avaliable_keys = []
    
    for k in form_keys:
        if request.args[k]:
            avaliable_keys.append(k)
    
    for k in avaliable_keys:
        if request.args[k]:
            if form_keys[form_keys.index(k)] in like:
                script += f""" "{k}" ILIKE '{request.args[k]}%' """
                
            elif form_keys[form_keys.index(k)] in exact:
                script += f""" "{k}" = '{request.args[k]}' """
  
            if not avaliable_keys.index(k) == len(avaliable_keys) - 1:
                script += 'or'
    
    print("==>> script: ", script)

    return renderResult(dao = dao, script = script, method = 'GET')

