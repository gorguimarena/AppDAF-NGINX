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

    public static function toObject(array $data): static {
        $citoyen = new static();

        $citoyen->nom = $data['nom'];
        $citoyen->prenom = $data['prenom'];
        $citoyen->date_naissance = $data['date_naissance'];
        $citoyen->lieu_naissance = $data['lieu_naissance'];
        $citoyen->cni_verso_url = $data['cni_verso_url'];
        $citoyen->cni_recto_url = $data['cni_recto_url'];

        return $citoyen;

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
