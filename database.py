# database.py
# Handles all the methods interacting with the database of the application.
# Students must implement their own methods here to meet the project requirements.

import array
import os
from tkinter import Variable
from turtle import clear
import pymysql.cursors

db_host = "remotemysql.com"
db_username = "nH2MoFjX0X"
db_password = "hctY2gFAim"
db_name = "nH2MoFjX0X"

# your code here


def connect():
    try:
        conn = pymysql.connect(
            host=db_host,
            port=3306,
            user=db_username,
            password=db_password,
            db=db_name,
            charset="utf8mb4",
            cursorclass=pymysql.cursors.DictCursor,
        )
        # print("Bot connected to database {}".format(db_name))
        return conn
    except:
        print(
            "Bot failed to create a connection with your database because your secret environment variables "
            + "(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) are not set".format(db_name)
        )
        print("\n")


def response(msg):
    db_response = None
    command_parts = msg.split()
    bot_command = command_parts[0]
    if "find_book_date_cat" in bot_command:
        start_date = command_parts[1]
        end_date = command_parts[2]
        cate = command_parts[3]
        db_response = find_book_btwn_date(start_date, end_date, cate)
        # print(db_response)
    elif "storage" in bot_command:
        db_response = storage()
    elif "change_password" in bot_command:
        userId = command_parts[1]
        newPassword = command_parts[2]
        db_response = change_password(userId, newPassword)
    elif "late_users" in bot_command:
        db_response = late_users()
    elif "user_spent" in bot_command:
        spent_user_id = command_parts[1]
        db_response = user_spent(spent_user_id)
    elif "aveg_spent" in bot_command:
        db_response = aveg_spent()
    elif "create_user" in bot_command:
        f_name = command_parts[1]
        l_name = command_parts[2]
        u_email = command_parts[3]
        u_password = command_parts[4]
        u_gender = command_parts[5]
        u_num = command_parts[6]
        dob = command_parts[7]
        db_response = create_user(
            f_name, l_name, u_email, u_password, u_gender, u_num, dob
        )
    return db_response


def find_book_btwn_date(startDate, endDate, category):
    try:
        result = []
        con = connect()
        if con:
            cur = con.cursor()
            # execute query
            query = """SELECT b.* FROM book b JOIN 
        category c on c.category_id = b.categories_categories_id JOIN 
        book_author ba on b.book_id=ba.book_id join author a on a.author_id=ba.author_id
        WHERE b.pub_date > %s and b.pub_date < %s and c.cateogry_name like %s"""
            variables = (startDate, endDate, category)
            cur.execute(query, variables)
            sqlResult = cur.fetchall()

            for answer in sqlResult:
                # print(answer["title"])
                result.append(
                    "Title: " + answer["title"] + " Date: " + answer["pub_date"]
                )
        con.close
    except:
        result = -1
    return result


def storage():
    try:
        result = []
        con = connect()
        if con:

            cur = con.cursor()
            # execute query
            print("executing query")
            query = """SELECT s.stored_id as "Building #",Count(b.book_id) as "Total Books" FROM book b 
JOIN storage s on s.stored_id = b.stored_stored_id
GROUP BY s.stored_id;"""
            cur.execute(query)
            sqlResult = cur.fetchall()

            for answer in sqlResult:
                # print(answer["title"])
                result.append(answer)
                # print(result)
        con.close
    except:
        result = -1
    return result


def borrowed_twice():
    try:
        result = []
        con = connect()
        if con:
            cur = con.cursor()
            # execute query
            print("executing borrow query")
            query = """Select r.* from registered_member r join borrows b on r.registered_member_id = b.registered_member_id 
group by b.book_id
having count(b.book_id) > 1"""
            cur.execute(query)
            sqlResult = cur.fetchall()
            print(sqlResult)

            for answer in sqlResult:
                result = answer
                print(sqlResult)

        con.close
    except:
        result = -1
    return result


def change_password(userId, password):
    try:
        user_id = userId
        new_password = password
        result = []
        con = connect()
        if con:
            cur = con.cursor()
            # execute query
            print("executing change password query")
            query = """UPDATE user
SET password = %s
WHERE user_id = %s"""
            variables = (new_password, user_id)
            cur.execute(query, variables)
            con.commit()
            # print("executed")
            sqlResult = cur.fetchall()
            # print(sqlResult)
            # print("password changed")
            result = "password changed!"
        con.close
    except:
        result = -1
    return result


def late_users():
    try:
        result = []
        con = connect()
        if con:
            cur = con.cursor()
            # execute query
            print("executing late_users query")
            query = """SELECT u.email FROM user u 
JOIN registered_member r on u.user_id=r.user_id 
JOIN borrows b on r.registered_member_id = b.registered_member_id
WHERE b.returned_date IS NULL"""
            cur.execute(query)
            sqlResult = cur.fetchall()
            print("executed")
            # print(sqlResult)
            # print("password changed")
            for email in sqlResult:
                result.append(email)
        con.close
    except:
        result = -1
    return result


def user_spent(id):
    try:
        result = []
        user_spent_id = id
        con = connect()
        if con:
            cur = con.cursor()
            # execute query
            print("executing user_spent query")
            query = """SELECT amount as 'Total spent: ' FROM invoice where user_user_id=%s"""
            cur.execute(query, user_spent_id)
            sqlResult = cur.fetchall()
            print("executed")
            result = sqlResult

            print(sqlResult)
            # print("password changed")
        con.close
    except:
        result = -1
    return result


def aveg_spent():
    try:
        result = []
        con = connect()
        if con:
            cur = con.cursor()
            # execute query
            print("executing avg_spent query")
            query = """SELECT avg(amount) as 'Avg. spent by a user' FROM invoice;"""
            cur.execute(query)
            sqlResult = cur.fetchall()
            print("executed")
            result = sqlResult

            print(sqlResult)
        con.close
    except:
        result = -1
    return result


def create_user(fn, ln, em, ps, ge, ph, dob):
    try:
        result = []
        c_name = fn
        c_lname = ln
        c_email = em
        c_pswd = ps
        c_gender = ge
        c_phnum = ph
        c_dob = dob
        result = []
        con = connect()
        if con:
            cur = con.cursor()
            # execute query
            print("executing create_user query")
            query = """INSERT INTO user ( first_name, last_name, email, password, gender, phone_number, DOB) 
VALUES (%s, %s, %s, %s,%s, %s, %s)"""
            variables = (c_name, c_lname, c_email, c_pswd, c_gender, c_phnum, c_dob)
            cur.execute(query, variables)
            con.commit()
            sqlResult = cur.fetchall()
            print("executed")
            result.append("------User created------")

            # print(sqlResult)
        con.close
    except:
        result = -1
    return result


# answer = response("find_book_date_cat 1980 1990 comic")

# print("\n".join(answer))
# print(borrowed_twice())
# print(change_password(111, "ndpqwehfdwe"))
# print("\n".join(map(str, late_users())))
# print(user_spent(111))
# print(avg_spent())
# response("avg_spent")
# print(create_user())
# response("create_user discord example test@mail.com newpasswords M 4155156934 1999-1-1")
