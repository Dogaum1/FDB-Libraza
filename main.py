import os
from flask import Flask, render_template
from Util.Attributes import *
from Routes.Add import add_core
from Routes.Search import search_core
from Routes.Edit import edit_core
from Routes.Show import show_core

os.system('cls')

def create_app():
    app = Flask(__name__)
    app.register_blueprint(add_core)
    app.register_blueprint(search_core)
    app.register_blueprint(edit_core)
    app.register_blueprint(show_core)
    return app

app = create_app()

@app.route("/")
def home():
    return render_template('home.html')

app.run()
