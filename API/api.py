import json

from flask import Flask, request, jsonify

app = Flask(__name__)
users = []


@app.route('/add', methods=['GET'])
def add_user():
    d = {}
    name_answer = request.args.get('name', None)
    spent_money = request.args.get('query', None)

    try:
        spent_money = int(spent_money)
    except ValueError:
        print("Value error!")

    new_user = User(name_answer, spent_money)
    if not search_user(users, new_user):
        users.append(new_user)
    else:
        add_spent_money(users, name_answer, spent_money)

    users_json = []
    for u in users:
        users_json.append(json.dumps(u.__dict__))
    d['output'] = json.dumps(users_json)
    return json.dumps(users_json)


@app.route('/calculate', methods=['GET'])
def calculate():
    d = {}
    d['output'] = "calculanding..."
    return d


def search_user(users_list, user):
    for u in users_list:
        if u.name == user.name: return True
    return False


def add_spent_money(users_list, name, money_to_add):
    for u in users_list:
        if u.name == name:
            u.spent_money += money_to_add


class User:
    name = ""
    spent_money = 0

    def __init__(self, name, spent_money):
        self.name = name
        self.spent_money = spent_money


if __name__ == '__main__':
    app.run()
