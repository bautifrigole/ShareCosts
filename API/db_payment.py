import db
import mariadb
import domain.payment as payment
import domain.user as user
import db_user as db_u
import db_group as db_g

def create_payment(payment: payment.Payment):
    try:
        user = db_u.search_user_by_ID(payment.from_user)
        group = db_g.search_group_by_user(user)
        sql: str = f"INSERT INTO Payment (ID_user_from,ID_user_to,ID_group,amount) VALUES ({payment.from_user},{payment.from_user},{group},{payment.amount})"
        db.post_data(sql)
    except Exception:
        print("Error")

def search_payment_by_ID(id_payment: int):
    try:
        sql: str = f"SELECT * FROM Payment where ID_payment = {id_payment}"
        data = db.get_data(sql)
        return data[0]
    except Exception:
        print("Error")

def search_payments_by_group(group: int):
    try:
        sql: str = f"SELECT * FROM Payment where ID_group = {group}"
        data = db.get_data(sql)
        return data
    except Exception:
        print("Error")

def search_payments_by_user(user: user.User):
    try:
        sql: str = f"SELECT * FROM Payment where ID_user_from = {user.id} OR ID_user_from = {user.id}"
        data = db.get_data(sql)
        return data
    except Exception:
        print("Error")