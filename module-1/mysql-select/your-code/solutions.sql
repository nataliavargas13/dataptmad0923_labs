-- LAB MYSQL SELECT
-- CHALLENGE 1:
SELECT a2.au_id AS 'AUTHOR ID', a2.au_lname AS 'LAST NAME', a2.au_fname AS 'FIRST NAME', t2.title AS 'TITLE', p.pub_name AS 'PUBLISHER'
FROM authors a2
INNER JOIN titleauthor t  ON a2.au_id = t.au_id
INNER JOIN titles t2 ON t.title_id = t2.title_id
INNER JOIN publishers p ON p.pub_id = t2.pub_id
-- CHALLENGE 2:
SELECT a2.au_id AS 'AUTHOR ID', a2.au_lname AS 'LAST NAME', a2.au_fname AS 'FIRST NAME', p.pub_name AS 'PUBLISHER', COUNT(t2.title) AS 'TITLE COUNT'
FROM authors a2
INNER JOIN titleauthor t  ON a2.au_id = t.au_id
INNER JOIN titles t2 ON t.title_id = t2.title_id
INNER JOIN publishers p ON p.pub_id = t2.pub_id
GROUP BY t2.title

-- CHALLENGE 3:
SELECT a2.au_id AS 'AUTHOR ID', a2.au_lname AS 'LAST NAME', a2.au_fname AS 'FIRST NAME', s.qty AS 'TOTAL'
FROM authors a2
INNER JOIN titleauthor t  ON a2.au_id = t.au_id
INNER JOIN titles t2 ON t.title_id = t2.title_id
INNER JOIN sales s ON s.title_id = t2.title_id
GROUP BY a2.au_id
ORDER BY TOTAL DESC
LIMIT 3
-- CHALLENGE 4:
SELECT a2.au_id AS 'AUTHOR ID', a2.au_lname AS 'LAST NAME', a2.au_fname AS 'FIRST NAME', COALESCE(s.qty, 0) AS 'TOTAL'
FROM authors a2
INNER JOIN titleauthor t  ON a2.au_id = t.au_id
INNER JOIN titles t2 ON t.title_id = t2.title_id
LEFT JOIN sales s ON s.title_id = t2.title_id
GROUP BY a2.au_id
ORDER BY TOTAL DESC