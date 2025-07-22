<?php

namespace APP\CORE;

use APP\CORE\Env;
use Exception;

class FileLoader
{
    private string $uploadDir;
    private array $allowedExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];

    public function __construct()
    {
        $this->uploadDir = trim("", '/');

        if (!is_dir($this->uploadDir)) {
            if (!mkdir($this->uploadDir, 0775, true)) {
                throw new \Exception("Impossible de créer le dossier de destination.");
            }
        } 
    }

    public function getImagePath(string $fileName): string
    {
        $path = $this->uploadDir . '/' . $fileName;

        if (!file_exists($path)) {
            throw new Exception("Fichier non trouvé.");
        }

        return $path;
    }

    public function getImageContent(string $fileName): string
    {
        return file_get_contents($this->getImagePath($fileName));
    }
}
