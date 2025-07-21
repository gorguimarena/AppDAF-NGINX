<?php
namespace AppDAF\API\REPOSITORY;

use AppDAF\API\ENTITY\Citoyen;
use AppDAF\API\ENTITY\Response;
use AppDAF\API\ENTITY\Statut;
use PDO;

class CitoyenRepository
{
    private PDO $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function select_by_cni(string $cni): Response
    {
        $stmt = $this->pdo->prepare("SELECT * FROM citoyen WHERE cni = :cni");
        $stmt->execute(['cni' => $cni]);

        $citoyen_row = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($citoyen_row) {
            $citoyen = new Citoyen();
            
            return new Response($citoyen, Statut::SUCCESS, 200, "Citoyen trouvé");
        }

        return new Response(null, Statut::ERROR, 404, "Aucun citoyen trouvé");
    }
}
