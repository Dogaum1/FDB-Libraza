from flask import Blueprint, request, session, abort
from Util.Template import *
from Util.Attributes import *

edit_core = Blueprint('edit', __name__, url_prefix='/edit')

@edit_core.route("/<path:path>/<int:id>/", methods = ['GET', 'POST'])
def edit(path, id):
  
  dao = getDao(path)
  if not dao or path in forbidden: return abort(404)
  if not session.get('user'): return abort(403)
  
  return renderForm( dao = dao, 
                     mode = 'edit', 
                     id = id, 
                     exclude = ['Confiabilidade'],
                     method = 'POST',
                  )

@edit_core.route("/modify/<path:path>/", methods = ['GET', 'POST'])
def modify(path):
  if not session.get('user'): return abort(403)
  if request.method == 'POST':
    dao = getDao(path)
    form_keys = list(request.form)
    
    get_object_script = f""" select * from "{path.title()}_edit" WHERE id = {request.form['id']} """
    object = dao.execute(get_object_script, get_object = True)
    
    script =  f""" SELECT {path}_update("""
    
    for k in form_keys:
        if request.form[k]:
          if k in date:
            script += f""" DATE'{request.form[k]}' """
          elif k in only_numbers or k == 'id':
            script += f""" {request.form[k]} """
          else:
            script += f""" CHARACTER'{request.form[k]}' """
        if not form_keys.index(k) == len(form_keys) - 1:
          script += ', '
    
    script += f")"
    
    dao.execute(script, commit = True)
    after_object = dao.execute(get_object_script, get_object = True)
    
    return renderData(path, 
                      object, 
                      'atualizado', 
                      after_object, 
                      update = True, 
                      )