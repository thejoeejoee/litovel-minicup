<?php
namespace Minicup\Model\Repository;


use LeanMapper\Connection;
use LeanMapper\IEntityFactory;
use LeanMapper\IMapper;
use Minicup\Model\Entity\Category;
use Nette\InvalidStateException;

class CategoryRepository extends BaseRepository
{
    /** @var  YearRepository */
    private $YR;

    /** @var  Category[] categories indexed by slug */
    private $categories;

    /**
     * @param Connection $connection
     * @param IMapper $mapper
     * @param IEntityFactory $entityFactory
     * @param YearRepository $YR
     */
    public function __construct(Connection $connection, IMapper $mapper, IEntityFactory $entityFactory, YearRepository $YR)
    {
        $this->YR = $YR;
        parent::__construct($connection, $mapper, $entityFactory);
    }

    protected function createFluent(/*$filterArg1, $filterArg2, ...*/)
    {
        $year = $this->YR->getSelectedYear();
        return parent::createFluent(array_merge(array($year), func_get_args()));
    }

    /**
     * @param $slug string
     * @return Category|NULL
     */
    public function getBySlug($slug)
    {
        if (isset($this->categories[$slug])) {
            return $this->categories[$slug];
        }
        $row = $this->createFluent()->where('[slug] = %s', $slug)->fetch();
        if ($row) {
            /** @var Category $category */
            $category = $this->createEntity($row);
            $this->categories[$category->slug] = $category;
            return $category;
        }
        return NULL;
    }

    /**
     * @return Category|NULL
     */
    public function getDefaultCategory()
    {
        $row = $this->createFluent()->where('[default] = 1')->fetch();
        if ($row) {
            return $this->createEntity($row);
        }
        throw new InvalidStateException('Default category not found.');
    }
} 