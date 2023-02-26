import json
import string
import random
from flask import Flask, request
from copy import deepcopy

from database.db_group import insert_group
from domain.user import User
from domain.payment import Payment
from domain.expense import Expense

app = Flask(__name__)
d = {}
users = []
expenses = []
payments = []


@app.route('/info', methods=['GET'])
def get_info():
    return get_dict_info()


@app.route('/clear_info', methods=['GET'])
def clear_info():
    users.clear()
    expenses.clear()
    payments.clear()
    return get_dict_info()


@app.route('/add_user', methods=['GET'])
def add_user():
    name = request.args.get('name', None)
    if name is None or exists_name(users, name):
        return d

    current_id = len(users)
    new_user = User(current_id, name)
    users.append(new_user)

    return get_dict_info()


@app.route('/add_expense', methods=['GET'])
def add_expense():
    user_id = request.args.get('id', None)
    amount = request.args.get('amount', None)
    description = request.args.get('description', None)

    try:
        user_id = int(user_id)
        amount = float(amount)
    except ValueError:
        print("Value error!")

    user_index = exists_user(users, user_id)
    if user_index is not None:
        expenses.append(Expense(description, users[user_index], amount))
        divided_value = round(amount/len(users), 6)
        for i in range(len(users)):
            if i != user_index:
                users[i].add_balance(-divided_value)
            else:
                users[user_index].add_balance(round(amount - divided_value, 2))
    else:
        return

    return get_dict_info()


@app.route('/calculate', methods=['GET'])
def calculate():
    payments.clear()
    add_payments(deepcopy(users), payments)
    return get_dict_info()


@app.route('/clear_balances', methods=['GET'])
def clear_balances():
    for user in users:
        user.balance = 0
    return get_dict_info()


def get_dict_info():
    return {'users': list_to_json(users), 'expenses': list_to_json(expenses), 'payments': list_to_json(payments)}


def exists_user(users_list, user_id: int):
    for i in range(len(users)):
        if users_list[i].id == user_id:
            return i
    return None


def exists_name(users_list, name: str):
    for u in users_list:
        if u.name == name:
            return True
    return False


def list_to_json(obj_list):
    json_list = []
    for obj in obj_list:
        json_list.append(json.dumps(obj.to_json()))
    return json.dumps(json_list)


def add_payments(users_list, payments):
    users_by_money = sorted(users_list, key=lambda x: x.balance)
    error = 0.0001
    for user in users_by_money:
        if abs(user.balance) <= error:
            users_by_money.remove(user)

    if len(users_by_money) < 2:
        return payments

    payments.append(create_payment(users_by_money[0], users_by_money[-1]))
    add_payments(users_by_money, payments)


def create_payment(from_user: User, to_user: User):
    difference = round((to_user.balance + from_user.balance), 6)

    if difference >= 0:
        amount = -from_user.balance
        from_user.balance = 0
        to_user.balance = difference
    else:
        amount = to_user.balance
        from_user.balance = difference
        to_user.balance = 0

    return Payment(from_user.id, to_user.id, amount)


def generate_id(size=6, chars=string.ascii_uppercase + string.digits):
    return ''.join(random.SystemRandom().choice(chars) for _ in range(size))


group_id = generate_id() #chequear si existe ese id
#insert_group(group_id, "Morado")


if __name__ == '__main__':
    app.run()
