from domain.user import User


class Payment:
    from_user = None
    to_user = None
    amount = 0.0

    def __init__(self, from_user: User, to_user: User, amount: float):
        self.from_user = from_user
        self.to_user = to_user
        self.amount = amount

    def to_json(self):
        return {"from_user": self.from_user.to_json(), "to_user": self.to_user.to_json(), "amount": self.amount}
