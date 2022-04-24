from flask import Blueprint, request, redirect, abort
from Util.Template import *

add_core = Blueprint('add', __name__, url_prefix='/add')

@add_core.route("/<path:path>", methods=['GET','POST'])
def add(path):
    if not session.get('user'): return abort(403)
    dao = getDao(path)
    if not dao or path in forbidden: return abort(404)
    
    return renderForm( dao = dao, 
                       mode = 'add', 
                       exclude = ['Id'],
                       only_keys = True,
                       method = 'POST',
                     )

@add_core.route("insert/<path:path>", methods=['GET','POST'])
def insert(path):
  if not session.get('user'): return abort(403)
  if request.method == 'POST':
 
    dao = getDao(path)
    form_keys = list(request.form)
 
    script =  f""" SELECT {path}_insert( """    
    for k in form_keys:
        if request.form[k]:
          if k in date:
            script += f""" DATE'{request.form[k]}' """
          elif k in only_numbers:
            script += f""" {request.form[k]} """
          else:
            script += f""" CHARACTER'{request.form[k]}' """
        if not form_keys.index(k) == len(form_keys) - 1:
          script += ', '
    
    script += f")"
    
    dao.execute(script, commit = True)
    
    get_object_script = f""" select * from "{path.title()}_add" WHERE """
    for k in form_keys:
        if request.form[k]:
            get_object_script += f""" "{k}" = '{request.form[k]}' """    

            if not form_keys.index(k) == len(form_keys) - 1:
                get_object_script += 'and'
    
    object = dao.execute(get_object_script, get_object = True)
    
  return renderData(path, 
                    object, 
                    mode = 'inserido', 
                    username = session.get('user'),)