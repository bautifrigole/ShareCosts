import json
from flask import Flask, request
from domain.user import User
from domain.payment import Payment

app = Flask(__name__)
users = []


@app.route('/add_user', methods=['GET'])
def add_user():
    d = {}
    name = request.args.get('name', None)
    current_id = len(users)

    new_user = User(current_id, name)
    users.append(new_user)

    users_json = []
    for u in users:
        users_json.append(json.dumps(u.__dict__))
    d['users'] = json.dumps(users_json)
    return d


@app.route('/add_money', methods=['GET'])
def add_money():
    d = {}
    user_id = request.args.get('id', None)
    spent_money = request.args.get('spent_money', None)

    try:
        user_id = int(user_id)
        spent_money = int(spent_money)
    except ValueError:
        print("Value error!")

    if exists_user(users, user_id):
        divided_value = round(spent_money/len(users), 2)
        for i in range(len(users)):
            if i != user_id:
                users[i].add_money(-divided_value)
            else:
                users[user_id].add_money(round(spent_money-divided_value, 2))
    else:
        return

    users_json = []
    for u in users:
        users_json.append(json.dumps(u.__dict__))
    d['users'] = json.dumps(users_json)
    return d


@app.route('/calculate', methods=['GET'])
def calculate():
    d = {}
    payments = []
    add_payments(users, payments)

    payments_json = []
    for p in payments:
        p.from_user = p.from_user.__dict__
        p.to_user = p.to_user.__dict__
        payments_json.append(json.dumps(p.__dict__))

    d['reckoning'] = json.dumps(payments_json)
    return d


def exists_user(users_list, user_id):
    for u in users_list:
        if u.id == user_id:
            return True
    return False


def add_payments(users_list, payments):
    users_by_money = sorted(users_list, key=lambda x: x.spent_money)

    for user in users_by_money:
        if user.spent_money == 0:
            users_by_money.remove(user)

    if len(users_by_money) < 2:
        return payments

    from_user = users_by_money[0]
    to_user = users_by_money[-1]
    difference = to_user.spent_money+from_user.spent_money
    if difference >= 0:
        amount = -from_user.spent_money
        from_user.spent_money = 0
        to_user.spent_money = difference
    else:
        amount = to_user.spent_money
        from_user.spent_money = difference
        to_user.spent_money = 0

    payment = Payment(from_user, to_user, amount)
    payments.append(payment)
    add_payments(users_by_money, payments)


if __name__ == '__main__':
    app.run()
