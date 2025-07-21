<?php

use AppDAF\API\ENTITY\Statut;
use AppDAF\API\SERVICE\CitoyenService;

class CitoyenController
{
    private CitoyenService $citoyen_service;

    public function __construct(CitoyenService $citoyen_service)
    {
        $this->citoyen_service = $citoyen_service;
    }

    public function recherche(): string
    {
       return '';
    }
}
