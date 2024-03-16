-- Challenge 1
-- Step 1
select t.title_id, t.price, t.advance, t.royalty, s.qty, a.au_id, au_lname, au_fname, ta.royaltyper, (t.price * s.qty * t.royalty * ta.royaltyper / 10000) as ROYALTIES
from titles t
inner join sales s on s.title_id = t.title_id
inner join titleauthor ta on ta.title_id = s.title_id
inner join authors a on a.au_id = ta.au_id
order by t.title_id, a.au_id;
-- Step 2
select title_id, au_id, au_lname, au_fname, advance, sum(ROYALTIES) as ROYALTIES from
(
	select t.title_id, t.price, t.advance, t.royalty, s.qty, a.au_id, au_lname, au_fname, ta.royaltyper, (t.price * s.qty * t.royalty * ta.royaltyper / 10000) as ROYALTIES
	from titles t
	inner join sales s on s.title_id = t.title_id
	inner join titleauthor ta on ta.title_id = s.title_id
	inner join authors a on a.au_id = ta.au_id
) as tmp
group by au_id, title_id
order by ROYALTIES desc;
-- Step 3
select au_id as "AUTHOR ID", au_lname as "LAST NAME", au_fname as "FIRST NAME", sum(advance + ROYALTIES) as PROFITS from
(
	select title_id, au_id, au_lname, au_fname, advance, sum(ROYALTIES) as ROYALTIES from (
		select t.title_id, t.price, t.advance, t.royalty, s.qty, a.au_id, au_lname, au_fname, ta.royaltyper, (t.price * s.qty * t.royalty * ta.royaltyper / 10000) as ROYALTIES
		from titles t
		inner join sales s on s.title_id = t.title_id
		inner join titleauthor ta on ta.title_id = s.title_id
		inner join authors a on a.au_id = ta.au_id
	) as tmp
	group by au_id, title_id
) as tmp2
group by au_id
order by PROFITS desc
limit 3;
-- Challenge 2
drop temporary table if exists tmp1;
CREATE TEMPORARY TABLE tmp1
select t.title_id, a.au_id, (t.price * s.qty * t.royalty * ta.royaltyper / 10000) as sale_royalty
from titles t
inner join sales s on s.title_id = t.title_id
inner join titleauthor ta on ta.title_id = s.title_id
inner join authors a on a.au_id = ta.au_id
order by t.title_id, a.au_id;
drop temporary table if exists tmp2;
CREATE TEMPORARY TABLE tmp2
select title_id, au_id, sum(sale_royalty) as ROYALTIES
from tmp1
group by title_id, au_id;
select tmp2.au_id as "AUTHOR ID", a.au_lname as "LAST NAME", a.au_fname as "FIRST NAME", sum(t.advance + ROYALTIES) as PROFITS
from tmp2
inner join titles t on t.title_id = tmp2.title_id
inner join authors a on a.au_id = tmp2.au_id
group by tmp2.au_id
order by PROFITS desc
limit 3;
-- Challenge 3
CREATE TABLE most_profiting_authors (
    au_id VARCHAR(10),
    profits DECIMAL(10, 2)
);
INSERT INTO most_profiting_authors (au_id, profits)
SELECT tmp2.au_id, SUM(t.advance + tmp2.ROYALTIES) AS profits
FROM (
    SELECT title_id, au_id, SUM(sale_royalty) AS ROYALTIES
    FROM (
        SELECT t.title_id, a.au_id, (t.price * s.qty * t.royalty * ta.royaltyper / 10000) AS sale_royalty
        FROM titles t
        INNER JOIN sales s ON s.title_id = t.title_id
        INNER JOIN titleauthor ta ON ta.title_id = s.title_id
        INNER JOIN authors a ON a.au_id = ta.au_id
        ORDER BY t.title_id, a.au_id
    ) AS tmp1
    GROUP BY title_id, au_id
) AS tmp2
INNER JOIN titles t ON t.title_id = tmp2.title_id
GROUP BY tmp2.au_id
ORDER BY profits DESC;