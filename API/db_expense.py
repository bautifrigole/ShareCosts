import db
import mariadb
import domain.expense as expense
import domain.user as user
import db_group as db_g

def create_expense(expense: expense.Expense):
    try:
        group: int = db_g.search_group_by_user(expense.payer_user)
        sql: str = f"INSERT INTO Expense (Description,ID_user,amount,ID_group) VALUES ({expense.description},{expense.payer_user},{expense.amount},{group})"
        db.post_data(sql)
    except Exception:
        print("Error")

def search_expense_by_ID(id_expense: expense.Expense):
    try:
        sql: str = f"SELECT * FROM Expense where ID_expense = {id_expense}"
        data = db.get_data(sql)
        return data[0]
    except Exception:
        print("Error")

def search_expenses_by_user(user: user.User):
    try:
        sql: str = f"SELECT * FROM Expense where ID_user = {user.id}"
        data = db.get_data(sql)
        return data
    except Exception:
        print("Error")

def search_expenses_by_group(group: int):
    try:
        sql: str = f"SELECT * FROM Expense where ID_group = {group}"
        data = db.get_data(sql)
        return data
    except Exception:
        print("Error")