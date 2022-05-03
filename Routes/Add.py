from webbrowser import get
from flask import Blueprint, request, redirect, abort, jsonify, url_for
from Util.Template import *

add_core = Blueprint("add", __name__, url_prefix="/add")


@add_core.route("/loan", methods=["GET", "POST"])
def addLoan():
    verifySession()
      
    dao = getDao("loan")

    if request.method == "POST":
        if request.form["cpf"] != "":
            user_script = (
                f""" SELECT * FROM "User" WHERE cpf = '{request.form['cpf']}'  """
            )
            user = dao.execute(user_script, get_object=True)
            if user:
                user = user["name"]
            else:
                user = ""
        else:
            user = ""

        if request.form["barcode"]:
            book_script = f""" SELECT * FROM "Book" WHERE barcode = '{request.form['barcode']}'  """
            book = dao.execute(book_script, get_object=True)
            if book:
                book = book["title"]
            else:
                book = ""
        else:
            book = ""

        return jsonify({"user": user, "book": book})

    return renderLoanForm(dao)

@add_core.route("/<path:path>", methods=["GET", "POST"])
def add(path):
    verifySession()
      
    dao = getDao(path)
    if not dao or path in forbidden:
        return abort(404)
      
    return renderForm(
        dao=dao,
        mode="add",
        exclude=["Id"],
        method="POST",
    )


@add_core.route("insert/<path:path>", methods=["GET", "POST"])
def insert(path):
    
    verifySession()
    
    if request.method == "POST":
        dao = getDao(path)
        form_keys = list(request.form)
        exclude = []
  
        script = mountScript(form_keys, request, f""" SELECT {path}_insert( """)
          
        object_id = dao.execute(script, get_object=True, commit=True)
        object_id = list(object_id.values())[0]
        
        get_object_script = (
            f""" select * from "{path.title()}_edit" WHERE id = {object_id}"""
        )
        
        object = dao.execute(get_object_script, get_object=True)

    return renderData(path, object, mode="inserido", exclude=exclude)
