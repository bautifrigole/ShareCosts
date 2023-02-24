import db
import mariadb
import domain.user as user

def create_user(user:user.User):
    try:
        sql: str = f"INSERT INTO User (ID_user,Name,ID_group) VALUES ({user.id},'{user.name}',3)"
        db.post_data(sql)
    except Exception:
        print("Error")

def search_user(user:user.User):
    try:
        sql: str = f"SELECT * from User where ID_user= {user.id}"
        data = db.get_data(sql)
        return data[0]
    except Exception:
        print("Error")

def search_users_by_group(group: int):
    try:
        sql: str = f"SELECT * from User where ID_group= {group}"
        data = db.get_data(sql)
        return data
    except Exception:
        print("Error")
    
def search_users_by_name(name: str):
    try:
        sql: str = f"SELECT * from User where Name = '{name}'"
        data = db.get_data(sql)
        return data
    except Exception:
        print("Error")
