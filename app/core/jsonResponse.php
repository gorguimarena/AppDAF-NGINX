<?php

function jsonResponse(array $data, int $statusCode = 200): void
{
    http_response_code($statusCode);
    header('Content-Type: application/json');
    echo json_encode($data);
    exit; // pour s'assurer que rien d'autre ne s'exécute
}
