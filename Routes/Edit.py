from flask import Blueprint, redirect, url_for
from Util.Template import *

edit_core = Blueprint('edit', __name__, url_prefix='/edit')

@edit_core.route("/<path:path>/<int:id>/")
def edit(path, id):
    if path in forbidden: return redirect(url_for('home'))
    return renderForm(getDao(path), path, 'Editar', id)
