import mysql.connector as mysql
import sys

def connect():
    try:
        conn = mysql.connect(
            host = "localhost",
            user = "root",
            password = "1022",
            port = 3306,
            database = "CalculateCost"
        )
    except mysql.Error as e:
        print(f"Error en la conexion de base de datos: {e}")
        sys.exit(1)
    return conn

def post_data(sql: str):
    try:
        connection: mysql.Connection = connect()
        connection.autocommit = False
        cursor: mysql.Cursor = connection.cursor()
        cursor.execute(sql)
    except mysql.Error as e:
        connection.rollback()
        connection.close()
        print(f"Error: {e}")
    connection.commit()
    #print(f"Last inserted ID: {cursor.lastrowid}")
    connection.close()
    return True

def get_data(sql: str):
    try:
        connection: mysql.Connection = connect()
        cursor: mysql.Cursor = connection.cursor()
        cursor.execute(sql)
        data = cursor.fetchall()
    except mysql.Error as e:
        connection.close()
        print(f"Error: {e}")
    connection.close()
    return data