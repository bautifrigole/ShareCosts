import database.db as db
import domain.user as user


def search_group_by_user(user: user.User):
    try:
        sql: str = f"Select ID_group from User where ID_user = {user.id};"
        data = db.get_data(sql)
        return data[0][0]
    except Exception:
        print("Error")

def exists_group(group_id: str):
    try:
        sql: str = f"SELECT * from User_group where ID_group = '{group_id}';"
        data = db.get_data(sql)
        if len(data) > 0:
            return True
        return False
    except Exception:
        print("Error")

def get_group_info(group_id: str):
    try:
        sql_get_users: str = f"SELECT ID_user,User.Name FROM User INNER JOIN User_group on User.ID_group = User_group.ID_group where User_group.ID_group = '{group_id}';"
        sql_get_expenses: str = f"SELECT ID_expense,Description,ID_user,Amount FROM Expense INNER JOIN User_group on Expense.ID_group = User_group.ID_group where User_group.ID_group = '{group_id}';"
        users = db.get_data(sql_get_users)
        expenses = db.get_data(sql_get_expenses)
        return users,expenses
    except Exception:
        print("Error")

def exists_user_in_group(group_id: str, user_name: str):
    try:
        sql: str = f"SELECT ID_user FROM User INNER JOIN User_group on User.ID_group = User_group.ID_group where User_group.ID_group = '{group_id}' AND User.Name = '{user_name}';"
        data = db.get_data(sql)
        if len(data) > 0:
            return True
        return False
    except Exception:
        print("Error")


def insert_group(id_group: str, name: str):
    try:
        sql: str = f"INSERT INTO User_group (ID_group,Name) VALUES ('{id_group}','{name}');"
        db.post_data(sql)
    except Exception:
        print("Error")