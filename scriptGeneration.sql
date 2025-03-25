-- 1. Génération des clients (20 clients) - OK
INSERT INTO clients (
    external_id, address, zipcode, city, 
    company_name, vat, company_type, 
    client_number, user_id, industry_id,
    created_at, updated_at
)
SELECT 
    UUID(),
    CONCAT(FLOOR(10 + RAND() * 90), ' ', 
           ELT(FLOOR(1 + RAND() * 10), 'Main', 'Oak', 'Pine', 'Maple', 'Cedar', 'Elm', 'Birch', 'Spruce', 'Willow', 'Park'), ' St.'),
    CONCAT(FLOOR(1000 + RAND() * 9000)),
    ELT(FLOOR(1 + RAND() * 10), 'Paris', 'Lyon', 'Marseille', 'Toulouse', 'Nice', 'Nantes', 'Strasbourg', 'Montpellier', 'Bordeaux', 'Lille'),
    CONCAT(
        ELT(FLOOR(1 + RAND() * 10), 'Global', 'National', 'International', 'Premium', 'First', 'Elite', 'Corporate', 'Business', 'Enterprise', 'Capital'),
        ' ',
        ELT(FLOOR(1 + RAND() * 10), 'Solutions', 'Technologies', 'Systems', 'Consulting', 'Group', 'Partners', 'Holdings', 'Ventures', 'Services', 'Industries')
    ),
    CONCAT('FR', FLOOR(10 + RAND() * 90), ' ', FLOOR(1000 + RAND() * 9000), ' ', FLOOR(1000 + RAND() * 9000)),
    ELT(FLOOR(1 + RAND() * 5), 'SARL', 'SAS', 'SA', 'EI', 'EURL'),
    FLOOR(1000 + RAND() * 9000),
    (SELECT id FROM users ORDER BY RAND() LIMIT 1),
    (SELECT id FROM industries ORDER BY RAND() LIMIT 1),
    DATE_ADD(NOW(), INTERVAL -FLOOR(180 + RAND() * 540) DAY),
    NOW()
FROM (
    SELECT a.N + b.N * 10 + 1 AS n
    FROM (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
         (SELECT 0 AS N UNION SELECT 1) b
    LIMIT 20
) numbers;

-- 2. Génération des contacts (2-5 par client) - CORRIGÉ
INSERT INTO contacts (
    external_id, name, email, primary_number, 
    secondary_number, client_id, is_primary,
    created_at, updated_at
)
SELECT 
    UUID(),
    CONCAT(
        ELT(FLOOR(1 + RAND() * 10), 'Jean', 'Pierre', 'Marie', 'Sophie', 'Thomas', 'Laura', 'Nicolas', 'Julie', 'David', 'Sarah'),
        ' ',
        ELT(FLOOR(1 + RAND() * 10), 'Dupont', 'Martin', 'Bernard', 'Petit', 'Durand', 'Leroy', 'Moreau', 'Simon', 'Laurent', 'Lefebvre')
    ),
    CONCAT(
        LOWER(SUBSTRING(ELT(FLOOR(1 + RAND() * 10), 'jean', 'pierre', 'marie', 'sophie', 'thomas', 'laura', 'nicolas', 'julie', 'david', 'sarah'), 1, 1)),
        '.',
        LOWER(ELT(FLOOR(1 + RAND() * 10), 'dupont', 'martin', 'bernard', 'petit', 'durand', 'leroy', 'moreau', 'simon', 'laurent', 'lefebvre')),
        '@',
        LOWER(REPLACE(c.company_name, ' ', '')), '.com'
    ),
    CONCAT('0', FLOOR(6 + RAND() * 1), FLOOR(10 + RAND() * 90), FLOOR(10 + RAND() * 90), FLOOR(10 + RAND() * 90), FLOOR(10 + RAND() * 90)),
    CASE WHEN RAND() > 0.5 THEN CONCAT('06', FLOOR(10 + RAND() * 90), FLOOR(10 + RAND() * 90), FLOOR(10 + RAND() * 90), FLOOR(10 + RAND() * 90)) ELSE NULL END,
    c.id,
    CASE WHEN RAND() > 0.8 THEN 1 ELSE 0 END,
    DATE_ADD(c.created_at, INTERVAL FLOOR(RAND() * 30) DAY),
    NOW()
FROM clients c
JOIN (
    SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
) AS contact_counts
WHERE RAND() > 0.3;

-- 3. Génération des leads (30 leads) - OK
-- 3. Génération des leads (30 leads) - Version corrigée
INSERT INTO leads (
    external_id, title, description, status_id,
    user_assigned_id, client_id, user_created_id,
    qualified, result, deadline,
    created_at, updated_at
)
SELECT 
    UUID(),
    CONCAT(
        ELT(FLOOR(1 + RAND() * 5), 'Projet ', 'Opportunité ', 'Demande ', 'Devis ', 'Négociation '),
        ELT(FLOOR(1 + RAND() * 10), 'Site Web', 'Application Mobile', 'Système CRM', 'Solution SaaS', 
            'Migration Cloud', 'Formation', 'Audit', 'Maintenance', 'Optimisation', 'Refonte')
    ),
    CONCAT(
        'Le client souhaite ',
        ELT(FLOOR(1 + RAND() * 5), 'développer ', 'créer ', 'mettre en place ', 'améliorer ', 'optimiser '),
        ELT(FLOOR(1 + RAND() * 10), 'son site internet', 'une application mobile', 'son système informatique', 
            'ses processus métier', 'son infrastructure réseau', 'sa base de données', 
            'son e-commerce', 'sa communication digitale', 'son ERP', 'ses outils collaboratifs'),
        ' avec ',
        ELT(FLOOR(1 + RAND() * 5), 'une solution sur mesure', 'une technologie innovante', 
            'un délai serré', 'un budget maîtrisé', 'une approche agile')
    ),
    FLOOR(7 + RAND() * 4), -- Statuts lead (7-10)
    (SELECT id FROM users ORDER BY RAND() LIMIT 1),
    (SELECT id FROM clients ORDER BY RAND() LIMIT 1), -- Toujours un client_id valide
    (SELECT id FROM users ORDER BY RAND() LIMIT 1),
    CASE WHEN RAND() > 0.7 THEN 1 ELSE 0 END,
    CASE WHEN RAND() > 0.5 THEN ELT(FLOOR(1 + RAND() * 5), 'Positive', 'Negative', 'Pending', 'Postponed', 'Converted') ELSE NULL END,
    DATE_ADD(NOW(), INTERVAL FLOOR(7 + RAND() * 60) DAY),
    DATE_ADD(NOW(), INTERVAL -FLOOR(1 + RAND() * 90) DAY),
    NOW()
FROM (
    SELECT a.N + b.N * 10 + 1 AS n
    FROM (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
         (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2) b
    LIMIT 30
) numbers;-- 4. Génération des projets (20 projets)
INSERT INTO projects (
    external_id, title, description, status_id, 
    user_assigned_id, user_created_id, client_id, 
    deadline, created_at, updated_at
)
SELECT 
    UUID(),
    CONCAT('Project ', n),
    CONCAT('Description for project ', n),
    FLOOR(11 + RAND() * 5),
    (SELECT id FROM users ORDER BY RAND() LIMIT 1),
    (SELECT id FROM users ORDER BY RAND() LIMIT 1),
    (SELECT id FROM clients ORDER BY RAND() LIMIT 1),
    DATE_ADD(CURDATE(), INTERVAL FLOOR(30 + RAND() * 180) DAY),
    NOW(),
    NOW()
FROM (
    SELECT a.N + b.N * 10 + 1 AS n
    FROM (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
         (SELECT 0 AS N UNION SELECT 1) b
    LIMIT 20
) numbers;

-- 5. Génération des offres (15 offres)
INSERT INTO offers (
    external_id, sent_at, client_id, status, 
    created_at, updated_at
)
SELECT 
    UUID(),
    CASE WHEN RAND() > 0.3 THEN DATE_ADD(NOW(), INTERVAL -FLOOR(1 + RAND() * 60) DAY) ELSE NULL END,
    (SELECT id FROM clients ORDER BY RAND() LIMIT 1),
    ELT(FLOOR(1 + RAND() * 3), 'pending', 'accepted', 'declined'),
    NOW(),
    NOW()
FROM (
    SELECT a.N + b.N * 10 + 1 AS n
    FROM (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) a,
         (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2) b
    LIMIT 15
) numbers;

-- 6. Génération des factures (30 factures)
INSERT INTO invoices (
    external_id, status, invoice_number, 
    sent_at, due_at, client_id, offer_id,
    created_at, updated_at
)
SELECT 
    UUID(),
    ELT(FLOOR(1 + RAND() * 3), 'draft', 'sent', 'paid'),
    10000 + n,
    CASE WHEN RAND() > 0.3 THEN DATE_ADD(NOW(), INTERVAL -FLOOR(1 + RAND() * 60) DAY) ELSE NULL END,
    DATE_ADD(NOW(), INTERVAL FLOOR(15 + RAND() * 45) DAY),
    (SELECT id FROM clients ORDER BY RAND() LIMIT 1),
    CASE WHEN RAND() > 0.7 THEN (SELECT id FROM offers ORDER BY RAND() LIMIT 1) ELSE NULL END,
    NOW(),
    NOW()
FROM (
    SELECT a.N + b.N * 10 + 1 AS n
    FROM (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
         (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2) b
    LIMIT 30
) numbers;

-- 7. Lier projets à factures
UPDATE projects p
JOIN (
    SELECT p.id AS project_id, i.id AS invoice_id
    FROM projects p
    JOIN invoices i ON i.client_id = p.client_id
    WHERE p.invoice_id IS NULL
    GROUP BY p.id
    ORDER BY RAND()
    LIMIT 10
) AS matches ON p.id = matches.project_id
SET p.invoice_id = matches.invoice_id;

-- 8. Génération des lignes de facture (80 lignes)
INSERT INTO invoice_lines (
    external_id, title, comment, price, 
    invoice_id, offer_id, type, quantity,
    created_at, updated_at
)
SELECT 
    UUID(),
    ELT(FLOOR(1 + RAND() * 10), 
        'Consulting', 'Development', 'Design', 
        'Hosting', 'Training', 'Support',
        'License', 'Hardware', 'Custom Work', 'Other'),
    CONCAT('Details for ', ELT(FLOOR(1 + RAND() * 5), 'basic', 'standard', 'premium', 'custom', 'express'), ' service'),
    FLOOR(50 + RAND() * 950),
    i.id,
    CASE WHEN RAND() > 0.7 THEN (SELECT id FROM offers ORDER BY RAND() LIMIT 1) ELSE NULL END,
    ELT(FLOOR(1 + RAND() * 3), 'service', 'product', 'hourly'),
    FLOOR(1 + RAND() * 10),
    NOW(),
    NOW()
FROM invoices i
JOIN (
    SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
) AS line_counts
WHERE RAND() > 0.3
LIMIT 80;

-- 9. Génération des paiements
INSERT INTO payments (
    external_id, amount, description, 
    payment_source, payment_date, invoice_id,
    created_at, updated_at
)
SELECT 
    UUID(),
    FLOOR(i.invoice_number / 100) + FLOOR(50 + RAND() * 200),
    CONCAT('Payment for invoice ', i.invoice_number),
    ELT(FLOOR(1 + RAND() * 4), 'credit_card', 'bank_transfer', 'cash', 'paypal'),
    DATE_ADD(i.sent_at, INTERVAL FLOOR(1 + RAND() * 14) DAY),
    i.id,
    NOW(),
    NOW()
FROM invoices i
WHERE (i.status = 'paid' OR (i.status = 'sent' AND RAND() > 0.5))
AND i.sent_at IS NOT NULL;

-- 10. Génération des tâches (50 tâches)
INSERT INTO tasks (
    external_id, title, description, 
    status_id, user_assigned_id, user_created_id, 
    client_id, project_id, deadline,
    created_at, updated_at
)
SELECT 
    UUID(),
    CONCAT('Task ', n),
    CONCAT('Complete ', ELT(FLOOR(1 + RAND() * 8), 
        'research', 'development', 'testing', 
        'documentation', 'meeting', 'review',
        'deployment', 'analysis')),
    FLOOR(1 + RAND() * 6),
    (SELECT id FROM users ORDER BY RAND() LIMIT 1),
    (SELECT id FROM users ORDER BY RAND() LIMIT 1),
    (SELECT id FROM clients ORDER BY RAND() LIMIT 1),
    CASE WHEN RAND() > 0.2 THEN (SELECT id FROM projects ORDER BY RAND() LIMIT 1) ELSE NULL END,
    DATE_ADD(CURDATE(), INTERVAL FLOOR(1 + RAND() * 90) DAY),
    NOW(),
    NOW()
FROM (
    SELECT a.N + b.N * 10 + 1 AS n
    FROM (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
         (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) b
    LIMIT 50
) numbers;



-- 2. Si le résultat est > 0, exécutez cette version améliorée de la requête
INSERT INTO payments (
    external_id, amount, description, 
    payment_source, payment_date, invoice_id,
    created_at, updated_at
)
SELECT 
    UUID(),
    FLOOR(
        (SELECT COALESCE(SUM(price * quantity), 0) FROM invoice_lines WHERE invoice_id = i.id) *
        CASE 
            WHEN RAND() > 0.7 THEN 1.0  -- Paiement complet (30%)
            WHEN RAND() > 0.5 THEN (0.3 + RAND() * 0.6)  -- Paiement partiel (50%)
            ELSE (0.1 + RAND() * 0.2)  -- Acompte (20%)
        END
    ) AS amount,
    CONCAT('Payment for invoice ', i.invoice_number),
    ELT(FLOOR(1 + RAND() * 4), 'credit_card', 'bank_transfer', 'cash', 'paypal'),
    DATE_ADD(i.sent_at, INTERVAL FLOOR(1 + RAND() * IF(i.status = 'paid', 7, 30)) DAY),
    i.id,
    NOW(),
    NOW()
FROM invoices i
WHERE i.sent_at IS NOT NULL
AND EXISTS (SELECT 1 FROM invoice_lines WHERE invoice_id = i.id)
AND (SELECT COALESCE(SUM(price * quantity), 0) FROM invoice_lines WHERE invoice_id = i.id) > 0;

-- Mettre à jour le statut des factures totalement payées
UPDATE invoices i
SET status = 'paid',
    updated_at = NOW()
WHERE (
    SELECT COALESCE(SUM(amount), 0)
    FROM payments 
    WHERE invoice_id = i.id
) >= (
    SELECT COALESCE(SUM(price * quantity), 0)
    FROM invoice_lines 
    WHERE invoice_id = i.id
)
AND status != 'paid';