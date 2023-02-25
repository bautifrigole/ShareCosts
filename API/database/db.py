import mariadb
import sys

def connect():

    try:
        conn = mariadb.connect(
            host = "localhost",
            user = "facu1",
            password = "1234",
            port = 3306,
            database = "CalculateCost"
        )
    except mariadb.Error as e:
        print(f"Error en la conexion de base de datos: {e}")
        sys.exit(1)
    return conn

def post_data(sql: str):
    try:
        connection: mariadb.Connection = connect()
        connection.autocommit = False
        cursor: mariadb.Cursor = connection.cursor()
        cursor.execute(sql)
    except mariadb.Error as e:
        connection.rollback()
        connection.close()
        print(f"Error: {e}")
    connection.commit()
    #print(f"Last inserted ID: {cursor.lastrowid}")
    connection.close()
    return True

def get_data(sql: str):
    try:
        connection: mariadb.Connection = connect()
        cursor: mariadb.Cursor = connection.cursor()
        cursor.execute(sql)
        data = cursor.fetchall()
    except mariadb.Error as e:
        connection.close()
        print(f"Error: {e}")
    connection.close()
    return data