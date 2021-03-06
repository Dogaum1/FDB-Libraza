from flask import Blueprint, request, session, abort, redirect, url_for, jsonify
from Util.Template import *
from Util.Attributes import *

edit_core = Blueprint("edit", __name__, url_prefix="/edit")


@edit_core.route("/<path:path>/<int:id>/", methods=["GET", "POST"])
def edit(path, id):
    dao = getDao(path)
    if not dao or path in forbidden:
        return abort(404)
    
    if not session.get("user"):
        return abort(403)

    return renderForm(
        dao=dao,
        mode="edit",
        id=id,
        exclude=["Confiabilidade"],
        method="POST",
    )


@edit_core.route("/modify/<path:path>/", methods=["GET", "POST"])
def modify(path):
    verifySession()
    
    if request.method == "POST":
        dao = getDao(path)
        form_keys = list(request.form)

        get_object_script = (
            f""" select * from "{path.title()}_edit" WHERE id = {request.form['id']} """
        )
        object = dao.execute(get_object_script, get_object=True)

        script = mountScript(form_keys, request, f""" SELECT {path}_update(""")
        dao.execute(script, commit=True)
        
        after_object = dao.execute(get_object_script, get_object=True)

        return renderData(
            path,
            object,
            "atualizado",
            after_object,
            update=True,
        )


@edit_core.route("/loan/<int:id>/return", methods=["GET", "POST"])
def loanReturn(id):
    verifySession()
    
    dao = getDao("loan")
    script = f""" SELECT loan_return({id})  """
    dao.execute(script, commit=True)
    return redirect(url_for("show.getOne", path="loan", id=id) )

@edit_core.route("/loan/<int:id>/renew", methods=["GET", "POST"])
def loanRenew(id):
    verifySession()
    
    dao = getDao("loan")
    script = f""" SELECT loan_renew({id})  """
    dao.execute(script, commit=True)
    
    return redirect(url_for("show.getOne", path="loan", id=id))
