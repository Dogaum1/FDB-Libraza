from flask import Blueprint
from Util.Template import *

edit_core = Blueprint('edit', __name__, url_prefix='/edit')

@edit_core.route("/<path:path>/<int:id>/")
def edit(path, id):
  dao = getDao(path)
  if not dao or path in forbidden: return render_template('erro_404_template.html'), 404 
  return renderForm( dao = dao, 
                    mode = 'edit', 
                    id = id, 
                    exclude = ['Id']
                  )
