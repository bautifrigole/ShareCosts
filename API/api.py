import json
import string
import random
from flask import Flask, request
from copy import deepcopy

from database.db_expense import search_expenses_by_group
from database.db_group import insert_group, exists_group, get_group_info
from database.db_user import create_user, search_users_by_group, search_user_by_ID
from domain.user import User
from domain.payment import Payment
from domain.expense import Expense

app = Flask(__name__)
d = {}
group_ids = []
users = []
expenses = []
payments = []


@app.route('/info', methods=['GET'])
def get_info():
    """No parameters required. Returns info of all users, only for testing purposes."""
    return get_dict_info()


@app.route('/clear_info', methods=['GET'])
def clear_info():
    """No parameters required. Removes all the info stored in arrays, only for testing purposes."""
    users.clear()
    expenses.clear()
    payments.clear()
    return get_dict_info()


@app.route('/add_group', methods=['GET'])
def add_group():
    """Parameters required: name. Add a group with the name specified."""
    name = request.args.get('name', None)
    group_id = generate_id()
    while exists_group(group_id):
        group_id = generate_id()
    insert_group(group_id, name)
    group_ids.append(group_id)
    return get_group_info(group_id)


@app.route('/add_user', methods=['GET'])
def add_user():
    """Parameters required: name, group_id. Add a user with the name and in the group specified."""
    name = request.args.get('name', None)
    group_id = request.args.get('group_id', None)

    '''if name is None or exists_name(search_users_by_group(group_id), name):
        return d'''

    create_user(name, group_id)
    return get_dict_info()


@app.route('/add_expense', methods=['GET'])
def add_expense():
    """Parameters required: id, amount, description, group_id. Add an expense."""
    user_id = request.args.get('id', None)
    amount = request.args.get('amount', None)
    description = request.args.get('description', None)
    group_id = request.args.get('group_id', None)

    try:
        user_id = int(user_id)
        amount = float(amount)
    except ValueError:
        print("Value error!")

    user_index = search_user_by_ID(user_id)
    if user_index is not []:
        #expenses.append(Expense(description, users[user_index], amount))
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
    """No parameters required. Calculates all the payments to be done."""
    payments.clear()
    add_payments(deepcopy(users), payments)
    return get_dict_info()


@app.route('/clear_balances', methods=['GET'])
def clear_balances():
    """Parameters required: group_id. Clears all the users balances in that group."""
    for user in users:
        user.balance = 0
    return get_dict_info()


def get_dict_info():
    # TODO: recalcular los balances de los users
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


if __name__ == '__main__':
    app.run()
