<?php
class ControllerCommonHome extends Controller {
	public function index() {
		$this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));

		if (isset($this->request->get['route'])) {
			$this->document->addLink($this->config->get('config_url'), 'canonical');
		}

		$data['text_scroll'] = $this->language->get('text_scroll');
		$data['text_to_start'] = $this->language->get('text_to_start');
		$data['text_contact_us'] = $this->language->get('text_contact_us');
		$data['text_get_today'] = $this->language->get('text_get_today');

		$data['slogan'] = $this->textLefRight($this->config->get('config_slogan'));

		$data['contact_url'] = $this->url->link('information/contact');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('common/home', $data));
	}

	private function textLefRight($text) {
		$text = explode(' ', $text);
		$result = array();

		if(empty($text)) {
			return $result;
		}

		foreach ($text as $key => $word) {
			if($key == 0) {
				$result['to-left'] = $word;
			} elseif($key == 1) {
				$result['to-right'] = $word;
			} else {
				break;
			}
		}

		unset($text);

		return $result;
	}
}
