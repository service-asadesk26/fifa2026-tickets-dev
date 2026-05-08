-- =====================================================
-- Migration: Atualizar 16 estadios oficiais FIFA 2026 + soft-disable Rose Bowl
-- =====================================================
-- Story 0.9 — EPIC-000
-- Idempotente. MERGE por name (com normalizacao de acentos).
-- Resultado esperado: 17 stadiums (16 oficiais + 1 Rose Bowl legacy).
-- =====================================================

SET NOCOUNT ON;

-- 1) Soft-disable Rose Bowl (id=4 hoje). Nao esta na lista oficial FIFA 2026.
UPDATE dbo.stadiums
   SET name = N'Rose Bowl (legacy)',
       description = N'Estadio historico em Pasadena. Nao esta na lista oficial FIFA 2026 — preservado para integridade de dados historicos. Sediou a final da Copa de 1994.'
 WHERE name = N'Rose Bowl';

-- 2) MERGE staging com os 16 estadios oficiais FIFA 2026.
DECLARE @s TABLE (
  match_name NVARCHAR(255),
  name NVARCHAR(255),
  city NVARCHAR(255),
  country NVARCHAR(100),
  capacity INT,
  image NVARCHAR(1000),
  description NVARCHAR(MAX)
);

INSERT INTO @s (match_name, name, city, country, capacity, image, description) VALUES
-- ===== Estados Unidos (11) =====
(N'AT&T Stadium', N'AT&T Stadium', N'Arlington (Dallas)', N'Estados Unidos', 80000,
  N'https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Arlington_June_2020_4_%28AT%26T_Stadium%29.jpg/800px-Arlington_June_2020_4_%28AT%26T_Stadium%29.jpg',
  N'Inaugurado em 2009. Casa do Dallas Cowboys (NFL), com teto retratil e capacidade para 80.000 torcedores. Sediara 9 jogos da Copa 2026.'),

(N'Mercedes-Benz Stadium', N'Mercedes-Benz Stadium', N'Atlanta', N'Estados Unidos', 71000,
  N'https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Mercedes_Benz_Stadium_time_lapse_capture_2017-08-13.jpg/800px-Mercedes_Benz_Stadium_time_lapse_capture_2017-08-13.jpg',
  N'Inaugurado em 2017. Casa do Atlanta Falcons (NFL) e Atlanta United (MLS). Famoso pelo teto retratil em formato de petalas.'),

(N'Gillette Stadium', N'Gillette Stadium', N'Foxborough', N'Estados Unidos', 64628,
  N'https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/Gillette_Stadium_%28Top_View%29.jpg/800px-Gillette_Stadium_%28Top_View%29.jpg',
  N'Inaugurado em 2002. Casa do New England Patriots (NFL) e New England Revolution (MLS), na regiao da Grande Boston.'),

(N'Hard Rock Stadium', N'Hard Rock Stadium', N'Miami Gardens', N'Estados Unidos', 65326,
  N'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Hard_Rock_Stadium_for_Super_Bowl_LIV_%2849606710103%29.jpg/800px-Hard_Rock_Stadium_for_Super_Bowl_LIV_%2849606710103%29.jpg',
  N'Inaugurado em 1987. Casa do Miami Dolphins (NFL). Sediou multiplos Super Bowls e o Open de Tenis de Miami.'),

(N'Lumen Field', N'Lumen Field', N'Seattle', N'Estados Unidos', 65123,
  N'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Qwest_Field_North.jpg/800px-Qwest_Field_North.jpg',
  N'Inaugurado em 2002. Casa do Seattle Seahawks (NFL) e Seattle Sounders (MLS). Conhecido pelo barulho ensurdecedor da torcida.'),

(N'Lincoln Financial Field', N'Lincoln Financial Field', N'Philadelphia', N'Estados Unidos', 65827,
  N'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a1/Lincoln_Financial_Field_%28Aerial_view%29.jpg/800px-Lincoln_Financial_Field_%28Aerial_view%29.jpg',
  N'Inaugurado em 2003. Casa do Philadelphia Eagles (NFL). Apelidado de "The Linc" pelos torcedores.'),

(N'SoFi Stadium', N'SoFi Stadium', N'Los Angeles (Inglewood)', N'Estados Unidos', 70240,
  N'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/SoFi_Stadium_2023.jpg/800px-SoFi_Stadium_2023.jpg',
  N'Inaugurado em 2020. Casa do LA Rams e LA Chargers (NFL). O estadio mais caro ja construido (US$ 5.5 bilhoes).'),

(N'NRG Stadium', N'NRG Stadium', N'Houston', N'Estados Unidos', 68311,
  N'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Nrg_stadium.jpg/800px-Nrg_stadium.jpg',
  N'Inaugurado em 2002. Casa do Houston Texans (NFL). Primeiro estadio da NFL com teto retratil.'),

(N'Arrowhead Stadium', N'Arrowhead Stadium', N'Kansas City', N'Estados Unidos', 76416,
  N'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/Aerial_view_of_Arrowhead_Stadium_08-31-2013.jpg/800px-Aerial_view_of_Arrowhead_Stadium_08-31-2013.jpg',
  N'Inaugurado em 1972. Casa do Kansas City Chiefs (NFL). Detem o recorde Guinness do estadio mais barulhento do mundo (142.2 dB).'),

(N'Levi''s Stadium', N'Levi''s Stadium', N'Santa Clara (Bay Area)', N'Estados Unidos', 68500,
  N'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Levi%27s_Stadium_in_February_2016_prior_to_Super_Bowl_50_%2824398261729%29.jpg/800px-Levi%27s_Stadium_in_February_2016_prior_to_Super_Bowl_50_%2824398261729%29.jpg',
  N'Inaugurado em 2014. Casa do San Francisco 49ers (NFL). Sustentavel: certificacao LEED Gold e energia solar no telhado.'),

(N'MetLife Stadium', N'MetLife Stadium', N'East Rutherford (NY/NJ)', N'Estados Unidos', 82500,
  N'https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Metlife_stadium_%28Aerial_view%29.jpg/800px-Metlife_stadium_%28Aerial_view%29.jpg',
  N'Inaugurado em 2010. Casa do New York Giants e New York Jets (NFL). Sediara a FINAL da Copa do Mundo FIFA 2026 em 19/07/2026.'),

-- ===== Canada (2) =====
(N'BMO Field', N'BMO Field', N'Toronto', N'Canadá', 45736,
  N'https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Toronto_BMO_Field_in_2024.jpg/800px-Toronto_BMO_Field_in_2024.jpg',
  N'Inaugurado em 2007. Casa do Toronto FC (MLS) e Toronto Argonauts (CFL). Expandido para a Copa 2026 com capacidade temporaria de 45.736.'),

(N'BC Place', N'BC Place', N'Vancouver', N'Canadá', 54500,
  N'https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/BC_Place_2015_Women%27s_FIFA_World_Cup.jpg/800px-BC_Place_2015_Women%27s_FIFA_World_Cup.jpg',
  N'Inaugurado em 1983. Maior estadio coberto do Canada. Casa do Vancouver Whitecaps (MLS) e BC Lions (CFL). Sediou a final da Copa Feminina 2015.'),

-- ===== Mexico (3) =====
(N'Estadio Azteca', N'Estadio Azteca', N'Cidade do México', N'México', 87523,
  N'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Estadio_Azteca_y_sus_alrededores_46.jpg/800px-Estadio_Azteca_y_sus_alrededores_46.jpg',
  N'Inaugurado em 1966. Lendario palco mexicano. Unico estadio a sediar finais de TRES Copas do Mundo (1970, 1986 e 2026). Casa do Club America.'),

(N'Estadio BBVA', N'Estadio BBVA', N'Monterrey', N'México', 53500,
  N'https://upload.wikimedia.org/wikipedia/commons/thumb/5/57/Mexico_Guadalupe_Monterrey_Estadio_BBVA_Bancomer_fifa_world_cup_2026_6.JPG/800px-Mexico_Guadalupe_Monterrey_Estadio_BBVA_Bancomer_fifa_world_cup_2026_6.JPG',
  N'Inaugurado em 2015. Conhecido como "El Gigante de Acero". Casa do Rayados de Monterrey. Vista panoramica para o Cerro de la Silla.'),

(N'Estadio Akron', N'Estadio Akron', N'Guadalajara (Zapopan)', N'México', 49850,
  N'https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Estadio_Akron_02-07-2022_cabecera_sur_lado_derecho_%283%29.jpg/800px-Estadio_Akron_02-07-2022_cabecera_sur_lado_derecho_%283%29.jpg',
  N'Inaugurado em 2010. Casa do Chivas de Guadalajara. Arquitetura inspirada em um vulcao com nuvem de fumaca, projetado por Jean-Marie Massaud e Daniel Pouzet.');

-- 3) MERGE: atualiza existentes (por nome, com fallback para nomes legados sem acento)
--    e insere os faltantes.
MERGE dbo.stadiums AS tgt
USING (
  SELECT s.match_name, s.name, s.city, s.country, s.capacity, s.image, s.description
  FROM @s s
) AS src
ON (
  -- Match exato pelo nome canonico OU por aliases conhecidos (legados sem acento)
  tgt.name = src.match_name
  OR (src.match_name = N'Estadio Azteca'  AND tgt.name IN (N'Estádio Azteca'))
  OR (src.match_name = N'Estadio BBVA'    AND tgt.name IN (N'Estádio BBVA'))
  OR (src.match_name = N'Estadio Akron'   AND tgt.name IN (N'Estádio Akron'))
)
WHEN MATCHED THEN
  UPDATE SET
    name = src.name,
    city = src.city,
    country = src.country,
    capacity = src.capacity,
    image = src.image,
    description = src.description
WHEN NOT MATCHED BY TARGET THEN
  INSERT (name, city, country, capacity, image, description, created_at)
  VALUES (src.name, src.city, src.country, src.capacity, src.image, src.description, GETDATE());

-- 4) Validacao
SELECT
  COUNT(*) AS total,
  SUM(CASE WHEN name LIKE '%legacy%' THEN 1 ELSE 0 END) AS legacy_count,
  SUM(CASE WHEN country = N'Estados Unidos' AND name NOT LIKE '%legacy%' THEN 1 ELSE 0 END) AS usa_active,
  SUM(CASE WHEN country = N'Canadá' THEN 1 ELSE 0 END) AS canada_active,
  SUM(CASE WHEN country = N'México' THEN 1 ELSE 0 END) AS mexico_active
FROM dbo.stadiums;

PRINT 'Esperado: total=17, legacy=1, usa_active=11, canada_active=2, mexico_active=3';
