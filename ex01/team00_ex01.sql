WITH RECURSIVE solution(point1, point2, path, cost, recurisve_depth) AS (
    SELECT
    nodes.point1, nodes.point2, (nodes.point1 || '->' || nodes.point2) AS path  , nodes.cost, 0 AS recurisve_depth
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
WHERE point2 = 'A' AND recurisve_depth > 2
ORDER BY 1,2;