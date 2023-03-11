import database.db as db
import random

def create_user(user_name:str, id_group: str):
    try:
        #TODO: generar en la db el user id
        user_id = random.randint(0, 999999)
        sql: str = f"INSERT INTO User (ID_user,Name,ID_group) VALUES ({user_id},'{user_name}','{id_group}')"
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
        # TODO: retornar una lista de User
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
        