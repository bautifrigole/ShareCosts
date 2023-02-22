class User:
    id = 0
    name = ""
    balance = 0.0

    def __init__(self, new_id: int, name: str):
        self.id = new_id
        self.name = name

    def to_json(self):
        return {"id": self.id, "name": self.name, "balance": self.balance}

    def add_balance(self, money):
        self.balance += money
