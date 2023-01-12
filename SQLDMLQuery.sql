use movie_NETWORKING
--Query1
select * from item;
--Query2
select name
from person
where personID in (select actorID
					from actor_castin_item
					where itemID = ( select itemID from item where name='Harry Potter and the Deathly Hallows: Part 2'));
--Query3					
select i.itemID, name from item i, series s
where i.itemID = s.itemID;

--Query4
select i.name
from item i, movie m
where (i.itemID= m.itemID) and m.itemID in (select it.itemID from review_item_user it 
				where it.userID= 
							(select person.personID from users,person 
								where users.personID=person.personID and person.name='Victor Baldwin')
				);