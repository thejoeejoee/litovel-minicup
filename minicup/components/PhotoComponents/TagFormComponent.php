<?php

namespace Minicup\Components;


use Minicup\Model\Entity\Tag;
use Minicup\Model\Repository\TagRepository;
use Nette\Application\UI\Form;
use Nette\Utils\ArrayHash;
use Nette\Utils\Strings;

class TagFormComponent extends BaseComponent
{
    /** @var TagRepository */
    private $TR;

    /** @var Tag|NULL */
    private $tag;

    /**
     * @param Tag $tag
     * @param TagRepository $TR
     */
    public function __construct(Tag $tag = NULL, TagRepository$TR)
    {
        $this->TR = $TR;
        $this->tag = $tag;
    }

    public function render()
    {
        $this->template->tag = $this->tag;
        if ($this->tag) {
            /** @var Form $form */
            $form = $this['tagForm'];
            $form->setDefaults($this->tag->getData(array('name', 'slug', 'id')));
        }
        parent::render();
    }

    /**
     * @return Form
     */
    public function createComponentTagForm()
    {
        $f = $this->formFactory->create();
        $name = $f->addText('name', 'Název');
        $slug = $f->addText('slug', 'Slug');
        $f->addHidden('id');
        $f->addSubmit('submit', $this->tag ? 'Upravit' : 'Přidat');
        $f->onSuccess[] = $this->tagFormSuccess;
        return $f;
    }

    /**
     * @param Form $form
     * @param ArrayHash $values
     */
    public function tagFormSuccess(Form $form, ArrayHash $values)
    {
        if ($values->id) {
            /** @var Tag $tag */
            $tag = $this->TR->get($values->id);
            $tag->slug = Strings::webalize($values->slug);
            $tag->name = $values->name;
        } else {
            $tag = new Tag();
            $tag->name = $values->name;
            $tag->slug = Strings::webalize($values->name);
        }
        try {
            $this->TR->persist($tag);
        } catch (\DibiDriverException $e) {
            $this->presenter->flashMessage("Chyba při ukládání tagu {$tag->id} ({$tag->slug})!", 'warning');
            return;
        }
        $form->setValues(array(), TRUE);
        $this->presenter->flashMessage($values->id ? "Tag upraven!" : 'Tag přidán!', 'success');
        if ($this->presenter->isAjax()) {
            $this->redrawControl('tag-form');
        }
    }
}

interface ITagFormComponentFactory
{
    /**
     * @param Tag $tag
     * @return TagFormComponent
     */
    public function create(Tag $tag = NULL);
}