<?php
namespace AppDAF\API\ENTITY;

use APP\CORE\ABSTRACT\AbstractEntity;

class Response extends AbstractEntity
{
    private ?Citoyen $data;
    private Statut $statut;
    private int $code;
    private string $message;

    public function __construct(?Citoyen $data, Statut $statut, int $code, string $message) {
        $this->data = $data;
        $this->statut = $statut;
        $this->code = $code;
        $this->message = $message;
    }

    public static function toObject(array $data): static{
        return static();
    }
    public function toArray(): array{
        return [
            'data' => $this->data ? $this->data->toArray() : null,
            'statut' => $this->statut->value,
            'code' => $this->code,
            'message' => $this->message,
        ];
    }
}
