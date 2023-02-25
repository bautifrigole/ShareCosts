class Payment:
    from_user = None
    to_user = None
    amount = 0.0

    def __init__(self, from_user: int, to_user: int, amount: float):
        self.from_user = from_user
        self.to_user = to_user
        self.amount = amount

    def to_json(self):
        return {"from_user_id": self.from_user, "to_user_id": self.to_user, "amount": self.amount}
