from flask import Blueprint, redirect, url_for
from Util.Template import *

add_core = Blueprint('add', __name__, url_prefix='/add')

@add_core.route("/<path:path>")
def add(path): 
    if path in forbidden: return redirect(url_for('home'))
    return renderForm(getDao(path), path, 'Cadastrar')