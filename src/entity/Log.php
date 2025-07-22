<?php
namespace AppDAF\API\ENTITY;

use APP\CORE\ABSTRACT\AbstractEntity;

class Log extends AbstractEntity
{
    private string $date;
    private string $heure;
    private string $localisation;
    private Statut $statut;
    private string $ip;

    public static function toObject(array $data): static{
        return new static();
    }
    public function toArray(): array{
        return [
            'date'=> $this->date,
            'heure'=> $this->heure,
            'localisation'=> $this->localisation,
            'statut'=> $this->statut->value,
            'ip'=> $this->ip,
        ];
    }
}
