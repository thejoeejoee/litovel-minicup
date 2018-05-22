<?php

namespace Minicup\Model\Entity;

use Nette\InvalidArgumentException;

/**
 * @property int            $id
 * @property Category       $category        m:hasOne                              category
 * @property TeamInfo       $homeTeam        m:hasOne(home_team_info_id:team_info) home team
 * @property TeamInfo       $awayTeam        m:hasOne(away_team_info_id:team_info) away team
 * @property int|NULL       $scoreHome       score of home team
 * @property int|NULL       $scoreAway       score of away team
 * @property \DateTime|NULL $confirmed       datetime of confirming or NULL if unconfirmed
 * @property int|NULL       $confirmedAs     order of confirming in category or NULL if unconfirmed
 * @property MatchTerm      $matchTerm       m:hasOne(match_term_id:match_term)   term for this match
 * @property Team[]         $historyTeams    m:belongsToMany(after_match_id)   history teams
 * @property MatchEvent[]   $events          m:belongsToMany all game events
 *
 * @property string         $onlineState
 * @property \DateTime|NULL $firstHalfStart  real time of match started
 * @property \DateTime|NULL $secondHalfStart real time of second halt start
 * @property string|NULL    $facebookVideoId ID of facebook stream
 */
class Match extends BaseEntity
{
    const HALF_LENGTH = "P600S";

    const INIT_ONLINE_STATE = 'init';
    const END_ONLINE_STATE = 'end';
    const HALF_FIRST_ONLINE_STATE = 'half_first';
    const HALF_SECOND_ONLINE_STATE = 'half_second';
    const PAUSE_ONLINE_STATE = 'pause';

    const ONLINE_STATE_PLAYING = [self::HALF_FIRST_ONLINE_STATE, self::PAUSE_ONLINE_STATE, self::HALF_SECOND_ONLINE_STATE];

    const ONLINE_STATE_CHOICES = [
        self::INIT_ONLINE_STATE => 'před zápasem',
        self::HALF_FIRST_ONLINE_STATE => '1. poločas',
        self::PAUSE_ONLINE_STATE => 'přestávka',
        self::HALF_SECOND_ONLINE_STATE => '2. poločas',
        self::END_ONLINE_STATE => 'po zápase'
    ];

    public static $CACHE_TAG = 'match';

    public function getCacheTags()
    {
        return [
            $this->homeTeam->tag ? $this->homeTeam->tag->getCacheTag() : NULL,
            $this->awayTeam->tag ? $this->awayTeam->tag->getCacheTag() : NULL,
        ];
    }

    /**
     * @return int|string
     * @throws \LeanMapper\Exception\InvalidStateException
     * @throws \LeanMapper\Exception\InvalidValueException
     * @throws \LeanMapper\Exception\MemberAccessException
     */
    public function getScoreHome()
    {
        return !is_null($score = $this->get('scoreHome')) ? $score : ' - ';
    }

    /**
     * @return int|string
     * @throws \LeanMapper\Exception\InvalidStateException
     * @throws \LeanMapper\Exception\InvalidValueException
     * @throws \LeanMapper\Exception\MemberAccessException
     */
    public function getScoreAway()
    {
        return !is_null($score = $this->get('scoreAway')) ? $score : ' - ';
    }

    /**
     * @param TeamInfo|Team $teamInfo
     * @return bool
     */
    public function isWinner($teamInfo)
    {
        if ($teamInfo instanceof Team) {
            $teamInfo = $teamInfo->i;
        } elseif (!$teamInfo instanceof TeamInfo) {
            throw new InvalidArgumentException('Unknown given argument');
        }
        if (!$this->confirmed) {
            return FALSE;
        }
        return
            ($teamInfo->id === $this->homeTeam->id && $this->scoreHome > $this->scoreAway) ||
            ($teamInfo->id === $this->awayTeam->id && $this->scoreAway > $this->scoreHome);
    }

    /**
     * @param Team|TeamInfo $teamInfo
     * @return bool
     */
    public function isLoser($teamInfo)
    {
        if ($teamInfo instanceof Team) {
            $teamInfo = $teamInfo->i;
        } elseif (!$teamInfo instanceof TeamInfo) {
            throw new InvalidArgumentException('Unknown given argument');
        }
        if (!$this->confirmed) {
            return FALSE;
        }
        return
            ($teamInfo->id === $this->homeTeam->id && $this->scoreHome < $this->scoreAway) ||
            ($teamInfo->id === $this->awayTeam->id && $this->scoreAway < $this->scoreHome);
    }

    /**
     * @return bool
     */
    public function isDraw()
    {
        if (!$this->confirmed) {
            return FALSE;
        }
        return $this->scoreHome === $this->scoreAway;
    }

    /**
     * @param TeamInfo $teamInfo
     * @return TeamInfo
     */
    public function getRival(TeamInfo $teamInfo)
    {
        return $this->homeTeam->id === $teamInfo->id ? $this->awayTeam : $this->homeTeam;
    }

    /**
     * Returns true, if match has started or already has end.
     * @return bool
     */
    public function hasStarted()
    {
        return $this->onlineState && $this->onlineState != self::INIT_ONLINE_STATE;
    }

    /**
     * Returns index of half, counted from 0.
     * @return int|NULL
     */
    public function getHalfIndex()
    {
        $index = !is_null($this->firstHalfStart) + !is_null($this->secondHalfStart) - 1;
        return $index >= 0 ? $index : NULL;
    }

    /**
     * Gets name of online state.
     * @return string
     */
    public function getOnlineStateName()
    {
        //dump($this->onlineState);
        return self::ONLINE_STATE_CHOICES[$this->onlineState ?: 'init'];
    }

    public function serialize()
    {
        return [
            'id' => $this->id,
            'home_team_abbr' => $this->homeTeam->abbr,
            'home_team_slug' => $this->homeTeam->slug,
            'home_team_name' => $this->homeTeam->name,
            'home_team_id' => $this->homeTeam->id,
            'away_team_name' => $this->awayTeam->name,
            'away_team_abbr' => $this->awayTeam->abbr,
            'away_team_slug' => $this->awayTeam->slug,
            'away_team_id' => $this->awayTeam->id,
            'home_team_color' => '#ff8574',
            'away_team_color' => '#88dd12',
            'category_name' => $this->category->name,
            'first_half_start' => $this->firstHalfStart ? $this->firstHalfStart->getTimestamp() : NULL,
            'second_half_start' => $this->secondHalfStart ? $this->secondHalfStart->getTimestamp() : NULL,
            'score' => [$this->scoreHome, $this->scoreAway],
            'confirmed' => $this->confirmed ? $this->confirmed->getTimestamp() : NULL,
            'half_length' => \DateInterval::createFromDateString(self::HALF_LENGTH)->s,
            'state' => $this->onlineState,
            'facebook_video_id' => $this->facebookVideoId,
            'match_term_start' => $this->matchTerm->day->day->setTime(0, 0)->getTimestamp() +
                $this->matchTerm->start->setDate(0, 0, 0)->getTimestamp()
        ];
    }
}
