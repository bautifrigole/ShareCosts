class Expense:
    description = ""
    payer_user = None
    amount = 0.0

    def __init__(self, description, payer_user, amount):
        self.description = description
        self.payer_user = payer_user
        self.amount = amount

    def to_json(self):
        return {"description": self.description, "payer_user": self.payer_user.to_json(), "amount": self.amount}
