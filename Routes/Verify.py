from flask import Blueprint, request, redirect, abort, jsonify
from Util.Template import *

verify_core = Blueprint("verify", __name__, url_prefix="/verify")

@verify_core.route("/add/<path:path>/", methods=["GET", "POST"])
def verifyAddForm(path):
    verifySession()
    
    if request.method == 'POST':        
        title = 'Erro'
        subtitle = 'Para prosseguir preencha: '
        
        msg = '<ul>'
        for k in request.form:
            if not request.form[k]:
                msg += f'<li> {Translate().translate(k).title()} </li> '
        msg += '</ul>'
     
        if msg != '<ul></ul>':
            return jsonify({"title": title, "subtitle": subtitle, "msg": msg, "status": 0})
        else:
            dao = getDao(path)
            if path == 'user':
                object = dao.execute(f""" SELECT cpf from "User" WHERE cpf = '{request.form['cpf']}' """, get_object = True)
                print("==>> object: ", object)
                
                if object:
                    return jsonify({"title": title, "subtitle": 'O CPF informado já se encontra cadastrado!', "msg": "", "status": 0})
            
            elif path == 'book':
                object = dao.execute(f""" SELECT barcode from "Book" WHERE barcode = '{request.form['barcode']}' """, get_object = True)
            
                if object:
                    return jsonify({"title": title, "subtitle": 'O ISBN informado já se encontra cadastrado!', "msg": "", "status": 0})
            
            elif path == 'loan':
                script = mountScript(list(request.form), request, f""" SELECT loan_validate( """)
                erro_list = dao.execute(script, get_object = True)
                erro_list = list(erro_list.values())[0]

                erro_dict = {
                    'borrow_limit': 'Quantidade maxíma de livros permitidos para empréstimo atingida pelo usuário!',
                    'available_limit': 'O livro selecionado não está disponivel para empréstimo!',
                    'already_borrowed': 'Usuário com empréstimo ativo do livro solicitado!'
                }

                if erro_list:
                    msg = '<ul>'
                    for e in erro_list:
                        msg += f'<li>{erro_dict[e]}</li> '
                    msg += '</ul>'
                    return jsonify({"title": title, "subtitle": 'O empréstimo não pode ser realizado pelos seguintes motivos:', "msg": msg, "status": 0})

        return jsonify({"status": 1})
        
@verify_core.route("/search/<path:path>/", methods=["GET", "POST"])
def verifySearchForm(path):    
    if request.method == 'GET':        
        
        title = 'Formulário insuficiente'
        subtitle = 'Preencha no minimo uma opção para realizar a pesquisa.'
        msg = ''
    
        empty = True
        for k in request.args:
            if request.args[k] != '':
                empty = False
                break
     
        if empty:
            return jsonify({"title": title, "subtitle": subtitle, "msg": msg, "status": 0})
        return jsonify({"status": 1})

@verify_core.route("/edit/<path:path>/<int:id>", methods=["GET", "POST"])
def verifyEditForm(path, id):
    verifySession()
    
    if request.method == 'POST':    
        dao = getDao(path)
        script = f""" SELECT * FROM "{path.title()}" WHERE id = {id} """
        object = dao.execute(script, get_object = True)
        
        if path == 'user':
            if object['cpf'] != request.form['cpf']:
                script = f""" SELECT * FROM "User" WHERE cpf = '{request.form['cpf']}' """
                cpf_verify = dao.execute(script, get_object = True)
                if cpf_verify:
                    return jsonify({"title": 'Erro', "subtitle": 'O CPF informado já se encontra cadastrado!', "msg": '', "status": 0})
                
        elif path == 'book':
            if object['barcode'] != request.form['barcode']:
                script = f""" SELECT * FROM "Book" WHERE barcode = '{request.form['barcode']}' """
                barcode_verify = dao.execute(script, get_object = True)
                if barcode_verify:
                    return jsonify({"title": 'Erro', "subtitle": 'O ISBN informado já se encontra cadastrado!', "msg": '', "status": 0})
        
        return jsonify({"status": 1})
    
@verify_core.route("/remove/<path:path>/<int:id>", methods=["GET", "POST"])
def verifyRemoveForm(path, id):
    verifySession()
    
    if request.method == 'POST':
        dao = getDao(path)
        
        if path == 'user':
            script = f""" SELECT cpf FROM "User" WHERE id = {id} """
            verify = dao.execute(script, get_object = True)
            if not verify['cpf'] == request.form['cpf']:
                return jsonify({"title": 'Erro', "subtitle": 'O CPF informado não corresponde ao do usuário a ser removido!', "msg": '', "status": 2})
            
            script = f"""SELECT count(id) as "open_loan" FROM "Loan" where "user" = (SELECT id FROM "User" WHERE cpf = '920.253.568-03') AND "return_date" IS NULL"""
            verify = dao.execute(script, get_object = True)
            if verify['open_loan'] > 0:
                return jsonify({"title": 'Erro', "subtitle": 'Não é possível remover usuários com empréstimo ativo!', "msg": '', "status": 2})    
                
        if path == 'book':
            script = f""" SELECT barcode FROM "Book" WHERE id = {id} """
            verify = dao.execute(script, get_object = True)
            if not verify['barcode'] == request.form['barcode']:
                return jsonify({"title": 'Erro', "subtitle": 'O ISBN informado não corresponde ao do livro a ser removido!', "msg": '', "status": 2})
            
        return jsonify({"status": 3})

@verify_core.route("/loan/<int:id>/return", methods=["GET", "POST"])
def verifyLoanReturn(id):
    verifySession()
    return jsonify({"status": 1})

@verify_core.route("/loan/<int:id>/renew", methods=["GET", "POST"])
def verifyLoanRenew(id):
    verifySession()
    
    dao = getDao("loan")
    script = f""" SELECT loan_renew_validate({id})  """
    valid = list(dao.execute(script, get_object = True).values())[0]
        
    if not valid:
        return jsonify({"title": "Erro", "subtitle": "A renovação só poderá ser solicitada a partir de 2 dias antes do vencimento!", "msg": "", "status": 0})
    return jsonify({"status": 1})
        
                