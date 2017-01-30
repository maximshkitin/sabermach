<?php
class ModelModuleHybridAuth extends Model {

	public function createTable() {
		$this->db->query( 'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'customer_authentication` (
							`customer_authentication_id` int(11) NOT NULL AUTO_INCREMENT,
							`customer_id` int(11) NOT NULL,
							`provider` varchar(100) NOT NULL,
							`identifier` varchar(255) NOT NULL,
							`web_site_url` varchar(255) NOT NULL,
							`profile_url` varchar(255) NOT NULL,
							`photo_url` varchar(255) NOT NULL,
							`display_name` varchar(255) NOT NULL,
							`description` varchar(255) NOT NULL,
							`first_name` varchar(255) NOT NULL,
							`last_name` varchar(255) NOT NULL,
							`gender` varchar(255) NOT NULL,
							`language` varchar(255) NOT NULL,
							`age` varchar(255) NOT NULL,
							`birth_day` varchar(255) NOT NULL,
							`birth_month` varchar(255) NOT NULL,
							`birth_year` varchar(255) NOT NULL,
							`email` varchar(255) NOT NULL,
							`email_verified` varchar(255) NOT NULL,
							`phone` varchar(255) NOT NULL,
							`address` varchar(255) NOT NULL,
							`country` varchar(255) NOT NULL,
							`region` varchar(255) NOT NULL,
							`city` varchar(255) NOT NULL,
							`zip` varchar(255) NOT NULL,
							`date_added` datetime NOT NULL,
							PRIMARY KEY (`customer_authentication_id`),
							UNIQUE KEY `identifier` (`identifier`)
							) ENGINE=MyISAM DEFAULT CHARSET=utf8;' );
	}

	public function dropTable() {
		$this->db->query( 'DROP TABLE ' . DB_PREFIX . 'customer_authentication;' );
	}


}