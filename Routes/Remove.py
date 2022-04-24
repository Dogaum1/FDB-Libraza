from flask import Blueprint, session, abort, request
from Util.Template import *

remove_core = Blueprint('remove', __name__, url_prefix='/remove')

@remove_core.route("/<path:path>/<int:id>/", methods = ['GET', 'POST'])
def remove(path, id):
    if not session.get('user'): return abort(403)
    print("==>> request.form: ", request.form)
    
    if request.method == 'POST':
        dao = getDao(path)
        if not dao or path in forbidden: return abort(404)
        for k in request.form:
            if request.form[k]:
                get_object_script = f""" select * from "{path.title()}_edit" WHERE id = {id} """
                object = dao.execute(get_object_script, get_object = True)    
                script =  f""" SELECT "{path.title()}_remove"("""
                
                if path == 'user':
                    if request.form['cpf'] and request.form['cpf'] == object['cpf']:
                        script += f""" CHARACTER'{request.form['cpf']}' ) """
                        dao.execute(script, commit = True)
                        return renderData(
                            path, 
                            object, 
                            'removido', 
                        )
                
                if path == 'book':
                    if request.form['barcode'] and request.form['barcode'] == object['barcode']:
                        script += f""" CHARACTER'{request.form['barcode']}' ) """
                        dao.execute(script, commit = True)
                        return renderData(
                            path, 
                            object, 
                            'removido', 
                        )
            
            return renderDetails(dao = dao, 
                         id = id, 
                         mode = 'detail',
                         invalid = True)
                

