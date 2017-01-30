<?php
class ControllerExtensionModuleSmsAlert extends Controller {
	public function index($route, $data) {
		
		if (isset($data[0]) && !empty($data[0])) {
			
			$this->load->language('extension/module/sms_alert');

			$this->load->model('extension/module/sms_alert');
			
			$order_id = $data[0];

			$status = $this->model_extension_module_sms_alert->getOrder($order_id);

			$status_list = $this->config->get('sms_alert_processing_status');
			if(empty($status_list)) {
				$status_list = array();
			}

			if (in_array($status, $status_list)) {

				$text = html_entity_decode($this->config->get('config_sms_new_order'), ENT_QUOTES, 'UTF-8');
				$replace = array(
						'{ORDER_ID}'  => $order_id,
					);
				if(empty($text)) {
					$text = implode("\n", array_keys($replace));
				}
				$text = str_replace(array_keys($replace), array_values($replace), $text);

				$req = "http://sms.ru/sms/send?api_id=" . $this->config->get('sms_alert_id') . "&to=" . $this->config->get('sms_alert_tel') . "&text=".urlencode($text);
				file_get_contents($req);
				
				// тест запроса
				// $this->log->write($req);
			}
		}
	}

}