<?php

class ModelExtensionModuleTestimonial extends Model
{
    public function addReview($data)
    {
        $this->db->query("INSERT INTO " . DB_PREFIX . "review SET author = '" . $this->db->escape($data['name']) . "', customer_id = '" . (int)$this->customer->getId() . "', product_id = '0', text = '" . $this->db->escape($data['text']) . "', groups = '".$this->db->escape($data['group'])."', avatar='" . $this->db->escape($data['avatar']) . "', files='".$this->db->escape(json_encode($data['files']))."', date_added = NOW()");

        $review_id = $this->db->getLastId();

        return $review_id;
    }

    public function getReviews($start = 0, $limit = 20)
    {
        if ($start < 0) {
            $start = 0;
        }

        if ($limit < 1) {
            $limit = 20;
        }

        $query = $this->db->query("SELECT r.review_id, r.customer_id, r.author, r.rating, r.text, r.groups, r.files, r.avatar, r.date_added FROM " . DB_PREFIX . "review r WHERE (r.product_id = '0' AND r.status = '1' AND r.customer_id = '" . (int)$this->customer->getId() . "') OR (r.product_id = '0' AND r.status = '1' AND r.reply = '" . (int)$this->customer->getId() . "') ORDER BY r.review_id DESC LIMIT " . (int)$start . "," . (int)$limit);

        return $query->rows;
    }

    public function getModuleReviews($start = 0, $limit = 20, $order = 0)
    {
        if ($start < 0) {
            $start = 0;
        }

        if ($limit < 1) {
            $limit = 20;
        }
        switch ($order) {
            case 0: {
                $sql = "ORDER BY date_added  DESC LIMIT " . (int)$start . "," . (int)$limit;
                break;
            }
            case 1: {
                $sql = "ORDER BY RAND() DESC LIMIT " . (int)$start . "," . (int)$limit;
                break;
            }
            default: {
                $sql = "ORDER BY date_added DESC LIMIT " . (int)$start . "," . (int)$limit;
            }
        }

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "review WHERE (product_id = '0'  AND status = '1' AND r.customer_id = '" . (int)$this->customer->getId() . "') OR (product_id = '0'  AND status = '1' AND r.reply = '" . (int)$this->customer->getId() . "') " . $sql);

        return $query->rows;
    }

    public function getTotalReviews()
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review r WHERE (r.product_id = '0' AND r.status = '1' AND r.customer_id = '" . (int)$this->customer->getId() . "') OR (r.product_id = '0' AND r.status = '1' AND r.reply = '" . (int)$this->customer->getId() . "')");

        return $query->row['total'];
    }

}