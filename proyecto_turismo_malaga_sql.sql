
-- TURISMO SOSTENIBLE EN MÁLAGA
-- Análisis de VUT y percepción de los residentes

DROP DATABASE IF EXISTS turismo_malaga;
CREATE DATABASE turismo_malaga;
USE turismo_malaga;

-- 1. TABLA DE VIVIENDAS DE USO TURÍSTICO POR DISTRITO

CREATE TABLE IF NOT EXISTS vut_by_district (
    district_id INT PRIMARY KEY,
    district_name VARCHAR(100) NOT NULL,
    vut_count INT NOT NULL
);

-- 2. TABLA DE PERCEPCIÓN DEL TURISMO POR DISTRITO

CREATE TABLE IF NOT EXISTS perception_by_district (
    district_id INT PRIMARY KEY,
    positive_pct DECIMAL(5,2) NOT NULL,
    negative_pct DECIMAL(5,2) NOT NULL,
    no_answer_pct DECIMAL(5,2) NOT NULL
);

-- 3. INSERCIÓN DE DATOS

INSERT INTO vut_by_district
    (district_id, district_name, vut_count)
VALUES
    (1, 'CENTRO', 6302),
    (2, 'ESTE', 1058),
    (3, 'CIUDAD JARDIN', 64),
    (4, 'BAILEN-MIRAFLORES', 350),
    (5, 'PALMA-PALMILLA', 57),
    (6, 'CRUZ DE HUMILLADERO', 534),
    (7, 'CARRETERA DE CADIZ', 1191),
    (8, 'CHURRIANA', 178),
    (9, 'CAMPANILLAS', 19),
    (10, 'PUERTO DE LA TORRE', 45),
    (11, 'TEATINOS-UNIVERSIDAD', 193);

INSERT INTO perception_by_district
(district_id, positive_pct, negative_pct, no_answer_pct) VALUES
(1, 73.88, 18.26, 7.86),
(2, 78.91, 11.87, 9.22),
(3, 73.16, 9.90, 16.94),
(4, 69.88, 12.50, 17.62),
(5, 87.80, 7.13, 5.07),
(6, 82.35, 14.06, 3.59),
(7, 78.10, 16.05, 5.85),
(8, 60.53, 39.47, 0.00),
(9, 82.62, 0.00, 17.38),
(10, 75.91, 0.00, 24.09),
(11, 73.94, 7.37, 18.69);

-- 4. ANÁLISIS POR DISTRITO

-- Unión de VUT y percepción de residentes
SELECT
    v.district_id,
    v.district_name,
    v.vut_count,
    p.positive_pct,
    p.negative_pct,
    p.no_answer_pct
FROM vut_by_district AS v
INNER JOIN perception_by_district AS p
    ON v.district_id = p.district_id
ORDER BY v.district_id;


-- Ranking de distritos por número de VUT
SELECT
    v.district_id,
    v.district_name,
    v.vut_count,
    p.negative_pct
FROM vut_by_district AS v
INNER JOIN perception_by_district AS p
    ON v.district_id = p.district_id
ORDER BY v.vut_count DESC;


-- Ranking de distritos por percepción negativa
SELECT
    v.district_id,
    v.district_name,
    v.vut_count,
    p.negative_pct
FROM vut_by_district AS v
INNER JOIN perception_by_district AS p
    ON v.district_id = p.district_id
ORDER BY p.negative_pct DESC;

-- 5. DISTRITOS CON PERCEPCIÓN NEGATIVA SUPERIOR A LA MEDIA

SELECT
    v.district_id,
    v.district_name,
    v.vut_count,
    p.negative_pct
FROM vut_by_district AS v
INNER JOIN perception_by_district AS p
    ON v.district_id = p.district_id
WHERE p.negative_pct > (
    SELECT AVG(negative_pct)
    FROM perception_by_district
)
ORDER BY p.negative_pct DESC;

-- 6. VISTA CONJUNTA PARA EL ANÁLISIS

CREATE OR REPLACE VIEW district_analysis AS
SELECT
    v.district_id,
    v.district_name,
    v.vut_count,
    p.positive_pct,
    p.negative_pct,
    p.no_answer_pct
FROM vut_by_district AS v
INNER JOIN perception_by_district AS p
    ON v.district_id = p.district_id;

-- 7. RESUMEN DE INDICADORES

SELECT
    COUNT(*) AS total_districts,
    ROUND(AVG(vut_count), 2) AS avg_vut,
    MIN(vut_count) AS min_vut,
    MAX(vut_count) AS max_vut,
    ROUND(AVG(negative_pct), 2) AS avg_negative_pct,
    MIN(negative_pct) AS min_negative_pct,
    MAX(negative_pct) AS max_negative_pct
FROM district_analysis;
