import db
import domain.user as user


def search_group_by_user(user: user.User):
    try:
        sql: str = f"Select ID_group from User where ID_user = {user.id}"
        data = db.get_data(sql)
        return data[0][0]
    except Exception:
        print("Error")

def insert_group(id_group: str, name: str):
    try:
        sql: str = f"INSERT INTO User_group (ID_group,Name) VALUES ('{id_group}','{name}')"
        db.post_data(sql)
    except Exception:
        print("Error")