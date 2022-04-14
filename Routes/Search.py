from flask import Blueprint, redirect, url_for
from Util.Template import *

search_core = Blueprint('search', __name__, url_prefix='/search')

@search_core.route("/<path:path>/")
def search(path):
    if path in forbidden: return redirect(url_for('home'))
    return renderForm(getDao(path), path)
