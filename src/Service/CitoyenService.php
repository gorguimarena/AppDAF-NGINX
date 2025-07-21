<?php
namespace AppDAF\API\SERVICE;

use AppDAF\API\ENTITY\Response;
use AppDAF\API\REPOSITORY\CitoyenRepository;

class CitoyenService
{
    private CitoyenRepository $citoyen_repository;

    public function __construct(CitoyenRepository $citoyen_repository)
    {
        $this->citoyen_repository = $citoyen_repository;
    }

    public function get_by_cni(string $cni): Response
    {
        return $this->citoyen_repository->select_by_cni($cni);
    }
}
