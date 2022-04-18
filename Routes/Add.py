from flask import Blueprint
from Util.Template import *

add_core = Blueprint('add', __name__, url_prefix='/add')

@add_core.route("/<path:path>", methods=['GET', 'POST'])
def add(path):
    dao = getDao(path)
    if not dao or path in forbidden: return render_template('erro_404_template.html'), 404 
    return renderForm( dao = dao, 
                       mode = 'add', 
                       exclude = ['Id'],
                       only_keys = True
                     )