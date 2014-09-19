<?php

namespace Minicup\Model\Entity;
use LeanMapper\Entity;
/**
 * @property int $id
 * @property Match $match m:hasOne
 * @property string $type type of this report
 * @property string $message message of this report
 * @property \Datetime $datetime
 * @property int $timestamp
 * 
 */
class OnlineReport extends Entity {
    
}
