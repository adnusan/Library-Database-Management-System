

## Library Database Management System Discord Bot
# Author @NUSAN RANA 
# I designed this Library Database Management System from the scratch using MySql. I'm using discord as interface for this database where user can use command to interact with this database. Database is hosted on cloud.


# [Discord Server](https://discord.gg/JHTsjhkNdG)
    Discord url: https://discord.gg/JHTsjhkNdG
# [Replit app](https://replit.com/join/xneqotjrst-nusanrana)
    Replit url: https://replit.com/join/xneqotjrst-nusanrana

##MUST READ
* My database has only few data inserted.
* Data in my database are not real, they are just mockup
* Please when entering parameters in bot command use examples command I provided OR look into inserted data in database
* For bot command it needs # before command, example: ```#aveg_spent```
* In business requirement below: 1st line is bot command, 2nd line is requirement, 3rd line is example 
* Thank you

# Business Requirements

1. #find_book_date_cat <start_date> <end_date> <category>        
    Find the book published between given dates with the given category. 
    Example: ```#find_book_date_cat 1980 1990 comic```

2. #storage                                        
    Show the number of books located in each storage, display total books in each storage
    Example: ```#storage```

3. #user_avg_borrow_days <userID>                     
    Find the average borrowed time for given user in the library database.
    
    Example: ```#user_avg_borrow_days 111```
    

4. #borrowed_twice                 
    Find the user that borrowed the same book twice  
    Example: ```#borrowed_twice```
    
5. #change_password <user_id> <new_password>
    Change the password of the given user id
    Example: ```#change_password 111 updatedpass```

6. #late_users
    Shows all the email of users who hasn't returned books after due dates
    Example: ```#late_users```

7. #user_spent <user_id>                            
    Shows the average money spent by given user
    Example: ```#user_spent 111```

8. #aveg_spent                                       
    Find the average money spent by all user combined
    Exanple: ```#aveg_spent```

9. #create_user <firstname> <lastname> <email> <password> <genderMF> <phonenumber> <dateofbirth> 
    Create a user account if they meet all the requirements like a unique email, has a full name
    
    Example: ```#create_user grader example test420@mail.com newpasswords M 4155156934 1999-1-1```
    

10. #book_total_sale <book title>                                 
    Find all the sale of given book then display total sale
    
    Examples: ```#book_total_sale hunt```

11. #popular_payment                                 
    Shows all the payment type used to purchase by payment id and total number of payment made
    Examples: ```#popular_payment```

12. #popular_book_by_age <start_age> <end_age> <category>  
    Find the most popular book between given age from given category
    
    Example: ```#popular_book_by_age 15 18 horror```

13. #delete_payment_card <payment ID>
    Delete the debit/credit card from user account given id number
    
    Example: ```#delete_payment_card 2004```
 
14. #members_zip_code
    Show the highest number of members from a same zip code, in descending order.
    Example: ```#members_zip_code```

15. #user_invoice <user_id>
    Show the invoice of the given user. Return the total amount owed by given user
    
    Example: ```#user_invoice 111```


16. #num_book_borrowed
    Show number of times each book is borrowed. 
    Example: ```#num_book_borrowed```


17. #total_book
    Find and show the total book in inventory
    Example: ```#total_book```



 





