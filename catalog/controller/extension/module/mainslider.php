<?php
class ControllerExtensionModuleMainslider extends Controller {
	public function index($setting) {
		static $module = 0;

		$this->load->model('design/banner');
		$this->load->model('tool/image');

		$data['banners'] = array();

		$results = $this->model_design_banner->getBanner($setting['banner_id']);

		$data['title'] = html_entity_decode($setting['data'][$this->config->get('config_language_id')]['title'], ENT_QUOTES, 'UTF-8');
		$data['description'] = nl2br(html_entity_decode($setting['data'][$this->config->get('config_language_id')]['description'], ENT_QUOTES, 'UTF-8'));

		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$data['banners'][] = array(
					'title' => $result['title'],
					'link'  => $result['link'],
					'image' => $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height'])
				);
			}
		}

		$data['module'] = $module++;

		return $this->load->view('extension/module/mainslider', $data);
	}
}