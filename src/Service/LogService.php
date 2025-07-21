<?php
namespace AppDAF\API\SERVICE;

use AppDAF\API\ENTITY\Log;
use LogRepository;

class LogService
{
    private LogRepository $log_repository;

    public function __construct(LogRepository $log_repository)
    {
        $this->log_repository = $log_repository;
    }

    public function save(Log $log): int
    {
        return $this->log_repository->insert($log);
    }
}
