class Payment:
    from_user = None
    to_user = None
    amount = 0.0

    def __init__(self, from_user, to_user, amount):
        self.from_user = from_user
        self.to_user = to_user
        self.amount = amount
