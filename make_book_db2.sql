insert into books(book_id, title, publisher, year, price)
select book_id + 370, title, publisher, year, price + 100
from books; 