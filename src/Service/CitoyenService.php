<?php
namespace AppDAF\API\SERVICE;

use AppDAF\API\ENTITY\Citoyen;
use AppDAF\API\ENTITY\Response;
use AppDAF\API\REPOSITORY\CitoyenRepository;

class CitoyenService
{
    private CitoyenRepository $citoyen_repository;

    public function __construct()
    {
        $this->citoyen_repository = new CitoyenRepository();
    }

    public function get_by_cni(string $cni): ?Citoyen
    {
        return $this->citoyen_repository->select_by_cni($cni);
    }
}
