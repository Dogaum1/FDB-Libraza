from flask import Blueprint, redirect, url_for
from Util.Template import *

show_core = Blueprint('show', __name__, url_prefix='/show')

@show_core.route("/<path:path>/")
def getAll(path):
    if path in forbidden: return redirect(url_for('home'))
    object_dao = getDao(path, True)
    return renderList(object_dao)

@show_core.route("/<path:path>/<int:id>/")
def getOne(path, id):
    if path in forbidden: return redirect(url_for('home'))
    object_dao = []
    exec(f"object_dao.append({path.title()}Dao(ConnectBD().getConection()))")
    return renderDetails(object_dao[0], id)
