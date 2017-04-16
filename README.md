# README

# For development purposes, all users besides the admin 
# have 'secret' as a password. 
User login: 
email:    dave@gmail.com
password: secret

Admin login: 
email:    admin
password: admin

A note about the database: 

I chose to do the histories table as the join table between
my users and my restaurants. With the intention of keeping 
referential integrity between my tables, I chose to remove
the delete functionality for both users and restaurants. 
More importantly, I do not believe any information from the 
history log should ever be removed or even edited in order to 
prevent unethical practices. 

In a larger scale production, such as Yelp, your user doesn't 
go away though. I would assume the have another table for 
users that 'delete' their accounts in the case that they 
want to reactivate at a later date. If you have any suggestions
for I might be able to do this, I would love to hear some. Would
it be practical to create a column in the users table that marks 
them as active or inactive? This could maybe give the user the
impression that they are deleting their account, while our 
data base maintains referential integrity. 
