<?php
App::uses('AppModel', 'Model');
/**
 * Post Model
 *
 */
class Post extends AppModel {
/**
 * Validation rules
 *
 * @var array
 */
	public $validate = array(
		'title' => array(
			'notempty' => array(
				'rule' => array('notempty'),
				//'message' => 'Your custom message here',
				//'allowEmpty' => false,
				//'required' => false,
				//'last' => false, // Stop validation after this rule
				//'on' => 'create', // Limit validation to 'create' or 'update' operations
			),
		),
	);

	public function othersThan($id) {
		return $this->find('all', array(
			'conditions' => array(
				'NOT' => array(
					'id' => $id
				)
			),
			'order' => 'created DESC'
		));
	}
}
