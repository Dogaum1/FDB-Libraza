from webbrowser import get
from flask import Blueprint, request, redirect, abort, jsonify
from Util.Template import *

verify_core = Blueprint("verify", __name__, url_prefix="/verify")

@verify_core.route("/add/<path:path>/", methods=["GET", "POST"])
def verifyAddForm(path):
    if request.method == 'POST':        
        
        title = 'Formulário inválido'
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
                    return jsonify({"title": title, "subtitle": "O CPF informado já se encontra cadastrado!", "msg": "", "status": 0})
            
            elif path == 'book':
                object = dao.execute(f""" SELECT barcode from "Book" WHERE barcode = '{request.form['barcode']}' """, get_object = True)
            
                if object:
                    return jsonify({"title": title, "subtitle": "O ISBN informado já se encontra cadastrado!", "msg": "", "status": 0})
            
            elif path == 'loan':
                script = mountScript(list(request.form), request, f""" SELECT loan_validate( """)
                erro_list = dao.execute(script, get_object = True)
                erro_list = list(erro_list.values())[0]

                erro_dict = {
                    'borrow_limit': 'Quantidade maxíma de livros permitidos para emprestimo atingida pelo usuário!',
                    'available_limit': 'O livro selecionado não está disponivel para emprestimo!',
                    'invalid_start_date': 'Data de inicio inválida!',
                    'invalid_return_period': 'Data de validade inválida!'
                }

                if erro_list:
                    msg = '<ul>'
                    for e in erro_list:
                        msg += f'<li>{erro_dict[e]}</li> '
                    msg += '</ul>'
                    return jsonify({"title": title, "subtitle": "O empréstimo não pode ser realizado pelos seguintes motivos:", "msg": msg, "status": 0})

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
        return jsonify({"title": title, "subtitle": subtitle, "msg": msg})
    
def validateLoan():
    pass