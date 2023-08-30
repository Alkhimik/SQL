CREATE TABLE nodes
(
point1 VARCHAR NOT NULL,
point2 VARCHAR NOT NULL,
cost BIGINT
);
INSERT INTO nodes values ('A', 'B', 10);
INSERT INTO nodes values ('B', 'A', 10);
---------------------------
INSERT INTO nodes values ('B', 'C', 35);
INSERT INTO nodes values ('C', 'B', 35);
---------------------------
INSERT INTO nodes values ('B', 'D', 25);
INSERT INTO nodes values ('D', 'B', 25);
---------------------------
INSERT INTO nodes values ('D', 'C', 30);
INSERT INTO nodes values ('C', 'D', 30);
---------------------------
INSERT INTO nodes values ('A', 'D', 20);
INSERT INTO nodes values ('D', 'A', 20);
---------------------------
INSERT INTO nodes values ('A', 'C', 15);
INSERT INTO nodes values ('C', 'A', 15);


WITH RECURSIVE solution(point1, point2, path, cost, recurisve_depth) AS (
    SELECT
    nodes.point1, nodes.point2, (nodes.point1 || '->' || nodes.point2) AS path, nodes.cost, 0 AS recurisve_depth
    FROM nodes
    WHERE point1 = 'A'
    UNION
    SELECT
    nodes.point1, nodes.point2, (solution.path || '->' || nodes.point2), solution.cost + nodes.cost, recurisve_depth + 1
    FROM solution
    INNER JOIN nodes ON nodes.point1 = solution.point2
    WHERE  recurisve_depth < 3 AND nodes.point2 NOT IN(solution.point1)
)
SELECT cost AS total_cost, path as tour FROM solution
WHERE point2 = 'A' AND recurisve_depth > 2 AND cost =(SELECT MIN(cost) FROM solution WHERE point2 = 'A' AND recurisve_depth > 2)
ORDER BY 1,2;
