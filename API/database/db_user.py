import db
import domain.user as user

def create_user(user:user.User, id_group: str):
    try:
        sql: str = f"INSERT INTO User (ID_user,Name,ID_group) VALUES ({user.id},'{user.name}','{id_group}')"
        db.post_data(sql)
    except Exception:
        print("Error")

def search_user_by_ID(id_user: int):
    try:
        sql: str = f"SELECT * from User where ID_user= {id_user}"
        data = db.get_data(sql)
        return data[0]
    except Exception:
        print("Error")

def search_users_by_group(group: str):
    try:
        sql: str = f"SELECT * from User where ID_group= '{group}'"
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
        