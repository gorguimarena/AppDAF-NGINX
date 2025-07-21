<?php

use AppDAF\API\ENTITY\Log;

class LogRepository
{
    private PDO $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function insert(Log $log): int
    {
        $stmt = $this->pdo->prepare("
            INSERT INTO log (date, heure, localisation, statut, ip)
            VALUES (:date, :heure, :localisation, :statut, :ip)
        ");

        $stmt->execute([
            'date' => $log->date,
            'heure' => $log->heure,
            'localisation' => $log->localisation,
            'statut' => $log->statut->value,
            'ip' => $log->ip,
        ]);

        return $this->pdo->lastInsertId();
    }
}
