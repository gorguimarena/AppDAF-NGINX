<?php
namespace AppDAF\API\REPOSITORY;

use AppDAF\API\ENTITY\Citoyen;
use AppDAF\API\ENTITY\Response;
use AppDAF\API\ENTITY\Statut;
use PDO;

class CitoyenRepository
{
    private PDO $pdo;

    public function __construct()
    {
        $this->pdo ;
    }

    public function select_by_cni(string $cni): ?Citoyen
    {
        $stmt = $this->pdo->prepare("SELECT * FROM citoyen WHERE cni = :cni");
        $stmt->execute(['cni' => $cni]);

        $citoyen_row = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($citoyen_row) {
            $citoyen = Citoyen::toObject($citoyen_row);
            return $citoyen;
        }
        return null;
    }
}
