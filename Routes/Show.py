from flask import Blueprint
from Util.Template import *

show_core = Blueprint('show', __name__, url_prefix='/show')

@show_core.route("/<path:path>/")
def getAll(path):
    dao = getDao(path)
    if not dao or path in forbidden: return render_template('erro_404_template.html'), 404 
    return renderList(dao = dao)

@show_core.route("/<path:path>/<int:id>/")
def getOne(path, id):
    dao = getDao(path)
    if not dao or path in forbidden: return render_template('erro_404_template.html'), 404  
    return renderDetails(dao = dao, id = id, mode = 'detail')