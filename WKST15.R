# WKST 15
#1) 
library(DBI)
library(RSQLite)

drv <- dbDriver("SQLite")
chinook_db <- dbConnect(drv, dbname = 
                          "./Documents/notes/PSTAT 10 HW/Chinook_Sqlite.sqlite")

# 2 (a) what is the average length of a track in the album with AlbumId = 160 

# Way 1: in milliseconds
dbGetQuery(chinook_db, "select avg(milliseconds) as avg_len_in_ms 
           from track
           where AlbumId = 160")
# as only changes the name of the display 

# Way 2: in minutes 
dbGetQuery(chinook_db, "select avg(milliseconds) / 60000 as avg_length from track
           where AlbumId = 160")
###
# find avg length for each album id
dbGetQuery(chinook_db, "select albumid, avg(milliseconds) as avg_len_in_ms
           from track
           group by albumid")

# find avg len for each album id between 50 and 90 and whose avg len is > 10000
dbGetQuery(chinook_db, "select albumid, avg(milliseconds) as avg_len_in_ms
           from track
           where albumid between 50 and 90 
           group by albumid
           having avg(milliseconds) > 10000") # faster
# having is for each element of the group by 
# this is why you need to use the having statement 

dbGetQuery(chinook_db, "select albumid, avg(milliseconds) as avg_len_in_ms
           from track
           group by albumid
           having albumid between 50 and 90") # slower 

###???
dbGetQuery(chinook_db, "select albumid, avg(milliseconds) as avg_len_in_ms
           from track
           where avg(milliseconds) > 10000
           group by albumid
           having albumid between 50 and 90") # this is wrong
# the where is the avg for all entries ??????????
###???

# WHERE can walk through each entry
# HAVING only deals with grouped column names, aggregated values like count, min etc 

# (b) 

# (c) 
dbGetQuery(chinook_db, 
           "select albumId, avg(milliseconds) from track
           where AlbumId between 250 and 255
           group by AlbumId")
# (d) 
dbGetQuery(chinook_db,
           "select albumid, avg(milliseconds) from track
           group by AlbumId
           having AlbumId between 250 and 255")

# (e) 

# 3 (a) 
dbGetQuery(chinook_db, 'select * from track') 
dbGetQUery(chinook_db, 'select * from mediatype')

# is a foreign key always a primary key of some other table or itself?
# it has to be at least a unique values column : candidate key in the referencing table 

# can a foreign key be its candidate/ primary key?
# CUSTOMER: pK: CUST_NO
# PRODUCT: PK: PROD_NO
# SALES_ORDER : PK(ORDER_NO)< FK - (CUST_NO)
# SALES_ORDER_LINE : PK(ORDER_NO, PROD_NO), FK(CUST_NO, SALES_ORDER< PROD_NO. PRODUCT) 
