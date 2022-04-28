from flask import Flask, render_template, session, redirect, request, url_for
from flask_util_js import FlaskUtilJs
from Util.Attributes import *
from Util.Template import getDao
from Routes import Add, Search, Edit, Show, Remove, Verify
import os, secrets

os.system('cls')

def create_app():
    app = Flask(__name__)
    app.register_blueprint(Add.add_core)
    app.register_blueprint(Search.search_core)
    app.register_blueprint(Edit.edit_core)
    app.register_blueprint(Show.show_core)
    app.register_blueprint(Remove.remove_core)
    app.register_blueprint(Verify.verify_core)
    app.register_error_handler(404, page_not_found)
    app.register_error_handler(403,forbbidden_page)
    return app

def page_not_found(e):
    return render_template('erro/erro_404_template.html'), 404

def forbbidden_page(e):
    return render_template('erro/erro_403_template.html'), 404

app = create_app()
app.secret_key = secrets.token_urlsafe(16)

fujs = FlaskUtilJs(app)
@app.context_processor
def inject_fujs():
    return dict(fujs=fujs)


@app.route("/")
def home():
    return render_template('home.html', username = session.get('user'))

@app.route("/login", methods = ['GET', 'POST'])
def login():
    if request.method == 'POST':
        if request.form['cpf'] or request.form['password']:
            session.pop('user', None)
            
            dao = getDao('Employee')
            script = f""" SELECT * FROM "Employee" WHERE cpf = '{request.form['cpf']}' and password = '{request.form['password']}' """
            object = dao.execute(script, get_object = True)

            if object:
                if request.form['password'] == object['password']:
                    session['user'] =  object['name']            
                    return redirect(url_for('home'))
            return render_template('login.html', invalid = True)
          
    return render_template('login.html')

@app.route("/logout", methods = ['GET', 'POST'])
def logout():
    if session.get('user'):
        session.pop('user', None)
    return redirect(url_for('home'))

app.config['TEMPLATES_AUTO_RELOAD'] = True
app.run(debug = True)
