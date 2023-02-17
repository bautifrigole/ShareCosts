import json
from flask import Flask, request
from domain.user import User

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
        users[user_id].add_money(spent_money)
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
    d['costs'] = "calculanding..."
    return d


def exists_user(users_list, user_id):
    for u in users_list:
        if u.id == user_id:
            return True
    return False


if __name__ == '__main__':
    app.run()
