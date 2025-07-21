
CREATE TABLE citoyen (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    date_naissance DATE NOT NULL,
    lieu_naissance VARCHAR(150) NOT NULL,
    cni VARCHAR(20) UNIQUE NOT NULL,
    cni_recto_url TEXT NOT NULL, 
    cni_verso_url TEXT NOT NULL, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE log (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,                    
    heure TIME NOT NULL,                   
    localisation VARCHAR(255) NOT NULL,  
    ip_address VARCHAR(45) NOT NULL,  
    statut VARCHAR(10) CHECK (statut IN ('SUCCES', 'ERROR')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_citoyen_cni ON citoyen(cni);


INSERT INTO citoyen (nom, prenom, date_naissance, lieu_naissance, cni, cni_recto_url, cni_verso_url)
VALUES 
('Diop', 'Mamadou', '1990-05-12', 'Dakar', 'CNI1234567890', '/uploads/cni/CNI1234567890_recto.png', '/uploads/cni/CNI1234567890_verso.png'),

('Fall', 'Awa', '1985-09-23', 'Thiès', 'CNI9876543210', '/uploads/cni/CNI9876543210_recto.jpg', '/uploads/cni/CNI9876543210_verso.jpg'),

('Ba', 'Cheikh', '1993-02-01', 'Saint-Louis', 'CNI4567891230', '/uploads/cni/CNI4567891230_recto.jpeg', '/uploads/cni/CNI4567891230_verso.jpeg');

INSERT INTO log (date, heure, localisation, ip_address, statut)
VALUES 
('2025-07-21', '14:30:00', 'Dakar - Plateau', '192.168.1.10', 'SUCCES'),

('2025-07-21', '15:45:12', 'Thiès - Grand Standing', '192.168.1.11', 'ERROR'),

('2025-07-20', '09:15:05', 'Saint-Louis - Centre-ville', '10.0.0.1', 'SUCCES');
