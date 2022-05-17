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
    # print(command_parts)
    bot_command = command_parts[0]
    # print(bot_command)
    if "find_book_date_cat" in bot_command:
        start_date = command_parts[1]
        end_date = command_parts[2]
        cate = command_parts[3]
        db_response = find_book_btwn_date(start_date, end_date, cate)
    elif "storage" in bot_command:
        db_response = storage()
    elif "borrowed_twice" in bot_command:
        db_response = borrowed_twice()
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
        # print(f_name)
        l_name = command_parts[2]
        u_email = command_parts[3]
        u_password = command_parts[4]
        u_gender = command_parts[5]
        u_num = command_parts[6]
        dob = command_parts[7]
        # print(dob)
        db_response = create_user(
            f_name, l_name, u_email, u_password, u_gender, u_num, dob
        )
    elif "book_total_sale" in bot_command:
        book_title = command_parts[1]
        db_response = book_total_sale(book_title)
    elif "popular_payment" in bot_command:
        db_response = popular_payment()
    elif "popular_book_by_age" in bot_command:
        from_age = command_parts[1]
        to_age = command_parts[2]
        categ = command_parts[3]
        db_response = popular_book_by_age(from_age, to_age, categ)
    elif "user_avg_borrow_days" in bot_command:
        userID = command_parts[1]
        db_response = user_avg_borrow_days(userID)
    elif "delete_payment_card" in bot_command:
        card = command_parts[1]
        db_response = delete_payment_card(card)
    elif "members_zip_code" in bot_command:
        db_response = members_zip_code()
    elif "user_invoice" in bot_command:
        invoiceId = command_parts[1]
        db_response = user_invoice(invoiceId)
    elif "num_book_borrowed" in bot_command:
        db_response = num_book_borrowed()
    elif "total_book" in bot_command:
        db_response = total_book()
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
group by b.book_id, r.registered_member_id
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
            query = """Select concat(user.first_name,' ', user.first_name) as 'User Name',  user.email from borrows
	Inner join registered_member on borrows.registered_member_id = registered_member.registered_member_id
	Inner join user on registered_member.user_id = user.user_id
	Where returned_date is null and curdate() > due_date"""
            #             query = """SELECT u.email FROM user u
            # JOIN registered_member r on u.user_id=r.user_id
            # JOIN borrows b on r.registered_member_id = b.registered_member_id
            # WHERE b.returned_date IS NULL"""
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
        print(c_dob)
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
            print("executed")

            sqlResult = cur.fetchall()
            result = "------User created------"
            print(result)

            # print(sqlResult)
        con.close
    except:
        result = "------Email already"
    return result


def book_total_sale(book):
    try:
        result = []
        book_name = book
        con = connect()
        if con:
            cur = con.cursor()
            # execute query
            print("executing book_sale query")
            query = """SELECT Sum(Amount)  FROM invoice
	INNER JOIN borrows ON invoice.borrows_id = borrows.borrows_id
	INNER JOIN book ON borrows.book_id = book.book_id
	Where book.title = %s"""
            cur.execute(query, book_name)
            sqlResult = cur.fetchall()
            print("executed")
            result = sqlResult

            print(sqlResult)
            # print("password changed")
        con.close
    except:
        result = -1
    return result


def popular_payment():
    try:
        result = []
        con = connect()
        if con:
            cur = con.cursor()
            # execute query
            print("executing popular_payment query")
            query = """SELECT p.payment_type_payment_type_id,count(*) as "Total Payments" FROM user_payment p JOIN payment_type t ON p.payment_type_payment_type_id=t.payment_type_id
GROUP BY p.payment_type_payment_type_id;"""
            cur.execute(query)
            sqlResult = cur.fetchall()
            print("executed")
            result = sqlResult

            print(sqlResult)
            # print("password changed")
        con.close
    except:
        result = -1
    return result


def popular_book_by_age(start_age, end_age, categ):
    try:
        result = []
        fage = start_age
        tage = end_age
        pcat = categ
        con = connect()
        if con:
            cur = con.cursor()
            # execute query
            print("executing popular_book_by_age query")
            query = """SELECT book.title , count(book.title) AS 'NumofBorrows' FROM borrows
INNER JOIN registered_member on borrows.registered_member_id = registered_member.registered_member_id
INNER JOIN user ON registered_member.user_id = user.user_id 
INNER JOIN book on borrows.book_id = book.book_id
INNER JOIN category on book.categories_categories_id = category.category_id
WHERE TIMESTAMPDIFF(YEAR, dob, CURDATE()) BETWEEN %s AND %s AND cateogry_name =%s
GROUP BY book.title
ORDER BY count(book.title) desc 
Limit 1"""
            variables = (fage, tage, pcat)
            cur.execute(query, variables)
            sqlResult = cur.fetchall()
            print("executed")
            result = sqlResult

            print(sqlResult)
            # print("password changed")
        con.close
    except:
        result = -1
    return result


def user_avg_borrow_days(userID):
    try:
        result = []
        user_id = userID
        con = connect()
        if con:
            cur = con.cursor()
            # execute query
            print("executing popular_book_by_age query")
            query = """SELECT concat(user.first_name, ' ', user.last_name) AS 'User Name', Avg(DATEDIFF(returned_date, issue_date)) AS 'average borrowed days' FROM borrows
INNER JOIN registered_member on borrows.registered_member_id = registered_member.registered_member_id
INNER JOIN user on registered_member.user_id = user.user_id
WHERE user.user_id=%s
GROUP BY user.first_name, user.last_name"""
            variables = user_id
            cur.execute(query, variables)
            sqlResult = cur.fetchall()
            print("executed")
            result = sqlResult

            print(sqlResult)
            # print("password changed")
        con.close
    except:
        result = -1
    return result


def delete_payment_card(cardId):
    try:
        result = []
        card = cardId
        con = connect()
        if con:
            cur = con.cursor()
            # execute query
            print("delete_user query executing")
            query = """DELETE FROM payment_card WHERE payment_card_id = %s"""
            cur.execute(query, card)
            sqlResult = cur.fetchall()
            cur.commit()
            print("executed")
            result = "PAYMENT CARD DELETED"

            # print(sqlResult)
            # print("password changed")
        con.close
    except:
        result = "Card Id does not exist"
    return result


def members_zip_code():
    try:
        result = []
        con = connect()
        if con:
            cur = con.cursor()
            # execute query
            print("memvbers_zip_code query executing")
            query = """SELECT * FROM
(SELECT count(a.zip_code) AS "Popular ZipCode Among Regular Member" FROM address a JOIN member_address m ON a.address_id=m.address_id JOIN registered_member r ON r.registered_member_id=m.registered_member_id
GROUP BY a.zip_code
ORDER BY count(a.zip_code) DESC
LIMIT 1) t,
(SELECT count(a.zip_code) AS "Popular Zipcode Among Premimum Member" FROM address a JOIN member_address m on a.address_id=m.address_id JOIN registered_member r ON r.registered_member_id=m.registered_member_id 
JOIN subscription s on r.registered_member_id=s.registered_member_id JOIN premium_member p ON p.premium_member_id = s.premium_member_id
GROUP BY a.zip_code
ORDER BY count(a.zip_code) DESC limit 1) m"""
            cur.execute(query)
            sqlResult = cur.fetchall()
            print("executed")
            result = sqlResult

            # print(sqlResult)
            # print("password changed")
        con.close
    except:
        result = -1
    return result


def user_invoice(userID):
    try:
        result = []
        user_id = userID
        con = connect()
        if con:
            cur = con.cursor()
            # execute query
            print("executing user_invoice....")
            query = """SELECT sum(Amount) AS 'Total Amount', book.title AS 'Borrowed Book',issue_date AS 'Date' FROM invoice
INNER JOIN user ON invoice.user_user_id = %s
INNER JOIN borrows ON invoice.borrows_id = borrows.borrows_id
INNER JOIN book ON book.book_id = borrows.book_id
GROUP BY book.title ,issue_date;
"""
            variables = user_id
            cur.execute(query, variables)
            sqlResult = cur.fetchall()
            print("executed")
            result = sqlResult

            # print(sqlResult)
            # print("password changed")
        con.close
    except:
        result = "------User invoice doesn't exist-------"
    return result


def num_book_borrowed():
    try:
        result = []
        con = connect()
        if con:
            cur = con.cursor()
            # execute query
            print("executing num_book_borrowed....")
            query = """SELECT book.title, count(borrows.book_id) as 'Times of Borrows' FROM borrows 
INNER JOIN book ON book.book_id = borrows.book_id
GROUP BY book.title
"""
            cur.execute(query)
            sqlResult = cur.fetchall()
            print("executed")
            result = sqlResult

            # print(sqlResult)
            # print("password changed")
        con.close
    except:
        result = -1
    return result


def total_book():
    try:
        result = []
        con = connect()
        if con:
            cur = con.cursor()
            # execute query
            print("executing total....")
            query = (
                """Select Count(book_id) as 'Total Number Of book stored' from book"""
            )
            cur.execute(query)
            sqlResult = cur.fetchall()
            print("executed")
            result = sqlResult

            # print(sqlResult)
            # print("password changed")
        con.close
    except:
        result = -1
    return result


# print (find_book_date_cat 1980 1990 comic('1980 1990 comic'))
# print("\n".join(answer))
# print(borrowed_twice())
# print(change_password(111, "ndpqwehfdwe"))
# print("\n".join(map(str, late_users())))
# print(user_spent(111))
# print(avg_spent())
# response("avg_spent")
# print(create_user())
# print(
#     response(
#         "create_user discord example test@mail.com newpasswords M 4155156934 1999-1-1"
#     )
# )
# create_user(
#     "work", "please", "emai12l@email.com", "password", "M", "4155151234", "1998-10-09"
# )
# response(
#     "create_user discord example test456@mail.com newpasswords M 4155156934 1999-1-1"
# )
# print(book_sale("hunt"))
# pupular_payment()
# print(popular_book_by_age(15, 19, "comic"))
# print(user_avg_borrow_days(111))
# print(delete_payment_card("2004"))
# print(members_zip_code())
# print(user_invoice("111"))
# print(response("user_invoice 111"))
# print(num_book_borrowed())
# print(response("num_book_borrowed"))
# print(response("total_book"))
