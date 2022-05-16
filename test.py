import array
import os
from turtle import clear
import pymysql.cursors

db_host = "remotemysql.com"
db_username = "nH2MoFjX0X"
db_password = "hctY2gFAim"
db_name = "nH2MoFjX0X"


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
    if "/find_book_date_cat" in bot_command:
        start_date = command_parts[1]
        end_date = command_parts[2]
        cate = command_parts[3]
        db_response = find_book_btwn_date(start_date, end_date, cate)
        print("Title: " + db_response)


def find_book_btwn_date(startDate, endDate, category):
    try:
        con = connect()
        if con:
            cur = con.cursor()
            start_date = "1980"
            end_date = "1990"
            cat = "comic"
            # execute query
            query = """select b.* from book b join 
        category c on c.category_id = b.categories_categories_id join 
        book_author ba on b.book_id=ba.book_id join author a on a.author_id=ba.author_id
        where b.pub_date > %s and b.pub_date < %s and c.cateogry_name like %s"""
            variables = (startDate, endDate, category)
            cur.execute(query, variables)
            users = cur.fetchall()

            for user in users:
                # print(user["title"])
                result.append(user["title"])
        con.close
    except:
        result = -1
    return result


connection = pymysql.connect(
    host=db_host,
    port=3306,
    user=db_username,
    password=db_password,
    db=db_name,
    charset="utf8mb4",
    cursorclass=pymysql.cursors.DictCursor,
)
cursor = connection.cursor()
cursor.execute(
    """select u.email from user u 
join registered_member r on u.user_id=r.user_id 
join borrows b on r.registered_member_id = b.registered_member_id
where b.returned_date IS NULL;"""
)
ans = cursor.fetchall()
print(ans)

# response("/find_book_date_cat 1980 1990 comic")
