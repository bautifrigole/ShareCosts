class User:
    id = 0
    name = ""
    balance = 0.0

    def __init__(self, new_id, name):
        self.id = new_id
        self.name = name

    def add_balance(self, money):
        self.balance += money