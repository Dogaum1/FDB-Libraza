from flask import Blueprint, session, abort
from Util.Template import *

show_core = Blueprint('show', __name__, url_prefix='/show')

@show_core.route("/<path:path>/")
def getAll(path):
    dao = getDao(path)
    if not dao or path in forbidden: return abort(404)
    return renderList(dao = dao)

@show_core.route("/<path:path>/<int:id>/")
def getOne(path, id):
    dao = getDao(path)
    if not dao or path in forbidden: return abort(404)
    if not path == 'book':
        if not session.get('user'): return abort(403)
    return renderDetails(dao = dao, 
                         id = id, 
                         mode = 'detail')