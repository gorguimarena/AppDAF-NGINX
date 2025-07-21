<?php
namespace AppDAF\API\ENTITY;

use APP\CORE\ABSTRACT\AbstractEntity;

class Citoyen extends AbstractEntity 
{
    private int $id;
    private string $nom;
    private string $prenom;
    private string $date_naissance;
    private string $lieu_naissance;
    private string $cni_verso_url;
    private string $cni_recto_url;
    private string $cni;

    public static function toObject(array $data): static{
        return static();
    }
    public function toArray(): array{
        return [
            'nom' => $this->nom,
            'prenom' => $this->prenom,
            'date_naissance' => $this->date_naissance,
            'lieu_naissance' => $this->lieu_naissance,
            'cni_verso_url' => $this->cni_verso_url,
            'cni_recto_url' => $this->cni_recto_url,
        ];
    }
}
