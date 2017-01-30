<?php
class ControllerExtensionModuleWhylist extends Controller {
	public function index($setting) {
		if (isset($setting['module_description'][$this->config->get('config_language_id')])) {
			$data['text_turn_around'] = $this->language->get('text_turn_around');
			
			$data['heading_title'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['title'], ENT_QUOTES, 'UTF-8');
			$data['description'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['description'], ENT_QUOTES, 'UTF-8');

			$_items = $setting['items'][$this->config->get('config_language_id')];

			$items = array();
			if(!empty($_items)) {
				foreach ($_items as $key => $item) {
					$result = new StdClass;
					$result->title = nl2br(html_entity_decode($item['title'], ENT_QUOTES, 'UTF-8'));
					$result->description = nl2br(html_entity_decode($item['description'], ENT_QUOTES, 'UTF-8'));
					$items[] = $result;
					unset($result);
				}
			}

			$data['items'] = $items;

			unset($_items);
			unset($items);

			return $this->load->view('extension/module/whylist', $data);
		}
	}
}