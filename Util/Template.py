from flask import render_template, session
from Module.DaoModules import *
from .Translate import *
from .Attributes import *


def getDao(path):
    path = path.replace("/", "")
    object_dao = []

    try:
        exec(f"object_dao.append({path.title()}Dao(ConnectBD().getConection()))")
    except:
        return False

    return object_dao[0]

def mountScript(form_keys, request, script):
    for k in form_keys:
        if request.form[k]:
            if k in date:
                script += f""" DATE'{request.form[k]}' """
            elif k in only_numbers or k == "id":
                script += f""" {request.form[k]} """
            else:
                script += f""" CHARACTER'{request.form[k]}' """
        else:
            script += f""" NULL """
        if not form_keys.index(k) == len(form_keys) - 1:
            script += ", "
    script += f")"
    
    return script


def renderForm(
    dao,
    mode=None,
    id=None,
    exclude=None,
    method=None,
    read_only=("id"),
):
    values = []

    if mode == "edit":
        values = list(dao.getOne(id=id, mode=mode).values())

    return render_template(
        "form/form_template.html",
        values=values,
        keys=[k for k in dao.getAll(mode=mode, only_keys=True)],
        keys_br=[
            Translate().translate(k).title()
            for k in dao.getAll(mode=mode, only_keys=True)
        ],
        title=Translate().translate(dao.table_name).title(),
        path=dao.table_name.title(),
        mode=mode,
        mode_br=Translate().translate(mode).title(),
        method=method,
        exclude=exclude,
        date=date,
        big_text=big_text,
        only_numbers=only_numbers,
        read_only=read_only,
        username=session.get("user"),
    )


def renderLoanForm(dao, values={}):
    return render_template(
        "form/loan_add_form.html",
        keys=[k for k in dao.getAll(mode="add", only_keys=True)],
        keys_br=[
            Translate().translate(k).title()
            for k in dao.getAll(mode="add", only_keys=True)
        ],
        exclude=["Id", "Devolução"],
        read_only=["user", "book"],
        values=values,
        date=date,
        method="POST",
        username=session.get("user"),
    )


def renderList(dao):
    exclude = []

    if dao.table_name == "User":
        exclude = ["Id", "Confiabilidade"]

    return render_template(
        f"list/{dao.table_name.lower()}_list_template.html",
        objects=dao.getAll(mode="list"),
        keys=[
            Translate().translate(k).title()
            for k in dao.getAll(mode="list", only_keys=True)
        ],
        path=dao.table_name.lower(),
        exclude=exclude,
        title=Translate().translate(dao.table_name.lower()),
        username=session.get("user"),
    )


def renderDetails(dao, id, mode=None, invalid=False):
    object = dao.getOne(id=id, mode=mode)

    if dao.table_name == "User":
        script = f""" SELECT COUNT(*) as active_loan FROM "Loan" RIGHT JOIN "User" ON "Loan".user = "User".id WHERE "Loan".user = {id} and "Loan".return_date IS NULL """
        object["active_loan"] = dao.execute(script, get_object=True)["active_loan"]

    return render_template(
        f"details/{dao.table_name.lower()}_details_template.html",
        object=object,
        title=Translate().translate(dao.table_name).title(),
        path=dao.table_name.lower(),
        username=session.get("user"),
        invalid=invalid,
    )


def renderResult(dao, script, method=""):
    template = f"list/{dao.table_name.title()}_list_template.html"

    return render_template(
        template,
        objects=dao.getSearch(script=script),
        keys=[
            Translate().translate(k).title()
            for k in dao.getAll(mode="list", only_keys=True, script=script)
        ],
        path=dao.table_name.lower(),
        title=Translate().translate(dao.table_name.lower()),
        method=method,
        username=session.get("user"),
    )


def renderData(path, object, mode, after_object=None, update=False, exclude=[]):
    return render_template(
        "data_result_template.html",
        path=Translate().translate(path).title(),
        keys_br=[Translate().translate(k).title() for k in object.keys()],
        keys=list(object.keys()),
        object=object,
        after_object=after_object,
        update=update,
        mode=mode,
        exclude=exclude,
        username=session.get("user"),
    )
