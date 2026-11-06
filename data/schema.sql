-- 1. Restaurants et Espaces
CREATE TABLE restaurant (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    budget_hebdo DECIMAL(10, 2) NOT NULL
);

CREATE TABLE espace (
    id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    nom VARCHAR(100) NOT NULL,
    capacite_max INT NOT NULL CHECK (capacite_max > 0),
    FOREIGN KEY (restaurant_id) REFERENCES restaurant(id) ON DELETE CASCADE
);

-- 2. Utilisateurs et Catégories Tarifaires
CREATE TABLE categorie_tarifaire (
    id INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL, -- ex: 'Étudiant Boursier', 'Étudiant Standard', 'Enseignant'
    tarif_repas DECIMAL(5, 2) NOT NULL CHECK (tarif_repas >= 0)
);

CREATE TABLE utilisateur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(180) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL,
    roles JSON NOT NULL, -- ex: ["ROLE_ETUDIANT"], ["ROLE_GESTIONNAIRE"]
    categorie_id INT NOT NULL,
    solde DECIMAL(8, 2) DEFAULT 0.00,
    FOREIGN KEY (categorie_id) REFERENCES categorie_tarifaire(id)
);

-- 3. Ingrédients, Allergènes et Lots (Gestion de la péremption et des seuils)
CREATE TABLE fournisseur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    delai_livraison_jours INT NOT NULL DEFAULT 1
);

CREATE TABLE ingredient (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    unite VARCHAR(20) NOT NULL, -- 'kg', 'litre', 'unite'
    seuil_alerte DECIMAL(10, 2) NOT NULL,
    cout_unitaire_moyen DECIMAL(8, 2) NOT NULL,
    capacite_stockage_max DECIMAL(10, 2) NOT NULL
);

CREATE TABLE lot_stock (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ingredient_id INT NOT NULL,
    fournisseur_id INT NOT NULL,
    quantite_initiale DECIMAL(10, 2) NOT NULL,
    quantite_restante DECIMAL(10, 2) NOT NULL CHECK (quantite_restante >= 0),
    prix_achat_unitaire DECIMAL(8, 2) NOT NULL,
    date_reception DATE NOT NULL,
    date_peremption DATE NOT NULL,
    est_perime BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredient(id),
    FOREIGN KEY (fournisseur_id) REFERENCES fournisseur(id)
);

-- 4. Plats, Recettes et Menus
CREATE TABLE plat (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    type_plat VARCHAR(30) NOT NULL, -- 'ENTREE', 'PLAT', 'DESSERT'
    calories INT NOT NULL
);

CREATE TABLE composition_plat (
    plat_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantite_par_portion DECIMAL(8, 4) NOT NULL, -- ex: 0.1500 kg de riz par portion
    PRIMARY KEY (plat_id, ingredient_id),

-- 5. Planification et Réservations
CREATE TABLE menu_jour (
    restaurant_id INT NOT NULL,
    date_service DATE NOT NULL,
    service VARCHAR(20) NOT NULL, -- 'MIDI', 'SOIR'
    portions_consommees INT DEFAULT 0,
    FOREIGN KEY (restaurant_id) REFERENCES restaurant(id)

CREATE TABLE reservation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    menu_jour_id INT NOT NULL,
    espace_id INT NOT NULL,
    statut VARCHAR(20) NOT NULL DEFAULT 'CONFIRMEE', -- 'CONFIRMEE', 'ANNULEE', 'CONSOMMEE'
    date_reservation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (menu_jour_id) REFERENCES menu_jour(id),
    FOREIGN KEY (espace_id) REFERENCES espace(id)
);    FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id),
    utilisateur_id INT NOT NULL,
);
     portions_prevues INT NOT NULL,
    id INT AUTO_INCREMENT PRIMARY KEY,
);

