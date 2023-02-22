import json
from flask import Flask, request
from domain.user import User
from domain.payment import Payment
from domain.expense import Expense

app = Flask(__name__)
users = []
expenses = []


@app.route('/add_user', methods=['GET'])
def add_user():
    d = {}
    name = request.args.get('name', None)
    if name is None or exists_name(users, name):
        return d

    current_id = len(users)
    new_user = User(current_id, name)
    users.append(new_user)

    users_json = []
    for u in users:
        users_json.append(json.dumps(u.to_json()))
    d['users'] = json.dumps(users_json)
    return d


@app.route('/add_expense', methods=['GET'])
def add_expense():
    d = {}
    user_id = request.args.get('id', None)
    amount = request.args.get('balance', None)
    description = request.args.get('description', None)

    try:
        user_id = int(user_id)
        amount = int(amount)
    except ValueError:
        print("Value error!")

    if exists_user(users, user_id):
        expenses.append(Expense(description, users[user_id], amount))
        divided_value = round(amount/len(users), 6)
        for i in range(len(users)):
            if i != user_id:
                users[i].add_balance(-divided_value)
            else:
                users[user_id].add_balance(round(amount - divided_value, 2))
    else:
        return

    d['users'] = list_to_json(users)
    d['expenses'] = list_to_json(expenses)
    return d


@app.route('/calculate', methods=['GET'])
def calculate():
    d = {}
    payments = []
    add_payments(users, payments)

    payments_json = []
    for p in payments:
        p.from_user = p.from_user.to_json()
        p.to_user = p.to_user.to_json()
        payments_json.append(json.dumps(p.to_json()))

    d['payments'] = json.dumps(payments_json)
    return d


def exists_user(users_list, user_id: int):
    for u in users_list:
        if u.id == user_id:
            return True
    return False


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

    from_user = users_by_money[0]
    to_user = users_by_money[-1]
    difference = round((to_user.balance + from_user.balance), 6)
    if difference >= 0:
        amount = -from_user.balance
        from_user.balance = 0
        to_user.balance = difference
    else:
        amount = to_user.balance
        from_user.balance = difference
        to_user.balance = 0

    payment = Payment(from_user, to_user, amount)
    payments.append(payment)
    add_payments(users_by_money, payments)


if __name__ == '__main__':
    app.run()
