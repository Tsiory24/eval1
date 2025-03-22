-- Génération de données aléatoires pour la table `absences`
INSERT INTO `absences` (`external_id`, `reason`, `comment`, `start_at`, `end_at`, `medical_certificate`, `user_id`, `created_at`, `updated_at`)
SELECT 
    UUID(),
    CASE FLOOR(1 + (RAND() * 3)) 
        WHEN 1 THEN 'Maladie' 
        WHEN 2 THEN 'Congé' 
        ELSE 'Autre' 
    END,
    'Commentaire généré aléatoirement',
    NOW() - INTERVAL FLOOR(RAND() * 10) DAY,
    NOW() + INTERVAL FLOOR(RAND() * 10) DAY,
    FLOOR(RAND() * 2),
    u.id,
    NOW(),
    NOW()
FROM users u
ORDER BY RAND()
LIMIT 10;

-- Génération de données aléatoires pour la table `activities`
INSERT INTO `activities` (`external_id`, `log_name`, `causer_id`, `causer_type`, `text`, `source_type`, `source_id`, `ip_address`, `properties`, `created_at`, `updated_at`)
SELECT 
    UUID(),
    'log_' || FLOOR(RAND() * 1000),
    u.id,
    'User',
    'Action aléatoire',
    'Module',
    FLOOR(RAND() * 1000),
    CONCAT(FLOOR(RAND()*255), '.', FLOOR(RAND()*255), '.', FLOOR(RAND()*255), '.', FLOOR(RAND()*255)),
    '{}',
    NOW(),
    NOW()
FROM users u
ORDER BY RAND()
LIMIT 10;

-- Génération de données aléatoires pour la table `appointments`
INSERT INTO `appointments` (`external_id`, `title`, `description`, `source_type`, `source_id`, `color`, `user_id`, `client_id`, `start_at`, `end_at`, `created_at`, `updated_at`)
SELECT 
    UUID(),
    'Rendez-vous ' || FLOOR(RAND() * 1000),
    'Description aléatoire',
    'Service',
    FLOOR(RAND() * 1000),
    LPAD(CONV(FLOOR(RAND() * 16777215), 10, 16), 6, '0'),
    u.id,
    NULL,
    NOW() + INTERVAL FLOOR(RAND() * 10) DAY,
    NOW() + INTERVAL FLOOR(RAND() * 20) DAY,
    NOW(),
    NOW()
FROM users u
ORDER BY RAND()
LIMIT 10;

-- Génération de données aléatoires pour la table `comments`
INSERT INTO `comments` (`external_id`, `description`, `source_type`, `source_id`, `user_id`, `created_at`, `updated_at`)
SELECT 
    UUID(),
    'Commentaire généré aléatoirement',
    'Post',
    FLOOR(RAND() * 1000),
    u.id,
    NOW(),
    NOW()
FROM users u
ORDER BY RAND()
LIMIT 10;
