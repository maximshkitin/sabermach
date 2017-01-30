<?php
class ModelExtensionModuleTestimonial extends Model {
	
	public function addReview($data) {
		if(isset($data['customer_id'])) {
			$sql = " reply = '" . (int) $data['customer_id'] . "',";
		} else {
			$sql = "";
		}
		$this->db->query("INSERT INTO " . DB_PREFIX . "review SET".$sql." author = '" . $this->db->escape($data['author']) . "', text = '" . $this->db->escape(strip_tags($data['text'])) . "', groups = '" . $this->db->escape($data['groups']) . "', status = '" . (int)$data['status'] . "', avatar = '" . $this->db->escape($data['avatar']) . "', files = '" . $this->db->escape(json_encode($data['files'])) . "', date_added = '" . $this->db->escape($data['date_added']) . "', date_modified = NOW()");

		$review_id = $this->db->getLastId();

		return $review_id;
	}

	public function editReview($review_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "review SET author = '" . $this->db->escape($data['author']) . "', text = '" . $this->db->escape(strip_tags($data['text'])) . "', groups = '" . $this->db->escape($data['groups']) . "', status = '" . (int)$data['status'] . "', date_added = '" . $this->db->escape($data['date_added']) . "', avatar = '" . $this->db->escape($data['avatar']) . "', files = '" . $this->db->escape(json_encode($data['files'])) . "', date_modified = NOW() WHERE review_id = '" . (int)$review_id  . "'");
	}

	public function deleteReview($review_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "review WHERE review_id = '" . (int)$review_id . "'");
	}

	public function getReview($review_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "review WHERE review_id = '" . (int)$review_id . "'");

		return $query->row;
	}

	public function getReviews($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "review WHERE product_id = 0";


		if (isset($data['filter_groups']) && !is_null($data['filter_groups'])) {
			$sql .= " AND groups LIKE '" . $this->db->escape($data['filter_groups']) . "%'";
		}

		if (!empty($data['filter_text'])) {
			$sql .= " AND text LIKE '" . $this->db->escape($data['filter_text']) . "%'";
		}

		if (!empty($data['filter_author'])) {
			$sql .= " AND author LIKE '" . $this->db->escape($data['filter_author']) . "%'";
		}

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND status = '" . (int)$data['filter_status'] . "'";
		}

		if (!empty($data['filter_date_added'])) {
			$sql .= " AND DATE(date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		$sort_data = array(
			'author',
			'groups',
			'status',
			'date_added'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY date_added";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getTotalReviews($data = array()) {
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review WHERE product_id = 0";

		if (isset($data['filter_rating']) && !is_null($data['filter_rating'])) {
			$sql .= " AND rating LIKE '" . $this->db->escape($data['filter_rating']) . "%'";
		}

		if (!empty($data['filter_author'])) {
			$sql .= " AND author LIKE '" . $this->db->escape($data['filter_author']) . "%'";
		}

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND status = '" . (int)$data['filter_status'] . "'";
		}

		if (!empty($data['filter_date_added'])) {
			$sql .= " AND DATE(date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function getTotalReviewsAwaitingApproval() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review WHERE status = '0'");

		return $query->row['total'];
	}

	public function install() {
		$this->db->query("UPDATE `" . DB_PREFIX . "modification` SET status=1 WHERE `name` LIKE'%Testimonials Lite Back End%'");
		$this->db->query("UPDATE `" . DB_PREFIX . "modification` SET status=1 WHERE `name` LIKE'%Testimonials Lite Front End%'");
		return $this->db->query("SELECT * FROM `" . DB_PREFIX . "modification` WHERE `name` LIKE'%Testimonials Lite Back End%'");
	}

	public function uninstall() {
		$this->db->query("UPDATE `" . DB_PREFIX . "modification` SET status=0 WHERE `name` LIKE'%Testimonials Lite Back End%'");
		$this->db->query("UPDATE `" . DB_PREFIX . "modification` SET status=0 WHERE `name` LIKE'%Testimonials Lite Front End%'");
		return $this->db->query("SELECT * FROM `" . DB_PREFIX . "modification` WHERE `name` LIKE'%Testimonials Lite Back End%'");
	}
}