class User:
    id = 0
    name = ""
    spent_money = 0.0

    def __init__(self, new_id, name):
        self.id = new_id
        self.name = name

    def add_money(self, money):
        self.spent_money += money
