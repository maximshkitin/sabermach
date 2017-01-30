<?php
class ControllerInformationContact extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('information/contact');

		$this->load->model('catalog/information');

		$this->load->model('tool/image');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['text_message'] = NULL;
		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} else {
			$data['name'] = $this->customer->getFirstName();
		}

		if (isset($this->request->post['email'])) {
			$data['email'] = $this->request->post['email'];
		} else {
			$data['email'] = $this->customer->getEmail();
		}

		if (isset($this->request->post['phone'])) {
			$data['phone'] = $this->request->post['phone'];
		} else {
			$data['phone'] = $this->customer->getTelephone();
		}

		if (isset($this->request->post['enquiry'])) {
			$data['enquiry'] = $this->request->post['enquiry'];
		} else {
			$data['enquiry'] = '';
		}

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$email = html_entity_decode($this->request->post['email'], ENT_QUOTES, 'UTF-8');
			$phone = html_entity_decode($this->request->post['phone'], ENT_QUOTES, 'UTF-8');
			$name = html_entity_decode($this->request->post['name'], ENT_QUOTES, 'UTF-8');
			$message = html_entity_decode($this->request->post['enquiry'], ENT_QUOTES, 'UTF-8');

			$text = html_entity_decode($this->config->get('config_contacts_message'), ENT_QUOTES, 'UTF-8');;
			$replace = array(
					'{NAME}'      => $name,
					'{TELEPHONE}' => $phone,
					'{EMAIL}'     => $email,
					'{MESSAGE}'   => nl2br($message)
				);
			if(empty($text)) {
				$text = implode("\n", array_keys($replace));
			}
			$text = str_replace(array_keys($replace), array_values($replace), $text);

			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

			$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($this->request->post['email']);
			$mail->setSender(html_entity_decode($this->request->post['name'], ENT_QUOTES, 'UTF-8'));
			$mail->setSubject(html_entity_decode(sprintf($this->language->get('email_subject'), $this->request->post['name'] . ' ' . $this->request->post['phone']), ENT_QUOTES, 'UTF-8'));
			$mail->setHtml($text);
			$mail->send();

			$data['text_message'] = $this->language->get('text_success');
			$data['home'] = $this->url->link('common/home');
			//$this->response->redirect($this->url->link('information/contact/success/1'));
			$this->session->data['form_message'] = $this->load->view('information/contact_message', $data);
			$data['text_message'] = $this->language->get('text_success');
			$data['enquiry'] = '';
		}

		if(isset($this->session->data['form_message'])) {
			$data['form_message'] = $this->session->data['form_message'];
			unset($this->session->data['form_message']);
		} else {
			$data['form_message'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('information/contact')
		);

		$about = $this->model_catalog_information->getInformation(4);

		if(!empty($about)) {
			$about_data = new StdClass;
			$about_data->title = $about['title'];
			$about_data->description = html_entity_decode($about['description'], ENT_QUOTES, 'UTF-8');
			$about_data->updated = $about['date_updated'];
			$about_data->image = (!empty($about['image']) ? $this->model_tool_image->resize($about['image'], 305, 264) : NULL);
		} else {
			$about_data = false;
		}

		$data['about'] = $about_data;

		unset($about_data);
		unset($about);



		$faq = $this->model_catalog_information->getInformation(7);
		if(!empty($faq)) {
			$faq_data = new StdClass;
			$faq_data->title = $faq['title'];
			$faq_data->description = html_entity_decode($faq['description'], ENT_QUOTES, 'UTF-8');
			$faq_data->updated = $faq['date_updated'];
			$faq_data->image = (!empty($faq['image']) ? $this->model_tool_image->resize($faq['image'], 305, 264) : NULL);
		} else {
			$faq_data = false;
		}

		$data['faq'] = $faq_data;

		unset($faq_data);
		unset($faq);

		$term = $this->model_catalog_information->getInformation(5);

		if(!empty($term)) {
			$term_data = new StdClass;
			$term_data->title = $term['title'];
			$term_data->description = html_entity_decode($term['description'], ENT_QUOTES, 'UTF-8');
			$term_data->updated = $term['date_updated'];
			$term_data->image = (!empty($term['image']) ? $this->model_tool_image->resize($term['image'], 305, 264) : NULL);
		} else {
			$term_data = false;
		}

		$data['terms'] = $term_data;

		unset($term_data);
		unset($term);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_location'] = $this->language->get('text_location');
		$data['text_store'] = $this->language->get('text_store');
		$data['text_contact'] = $this->language->get('text_contact');
		$data['text_address'] = $this->language->get('text_address');
		$data['text_telephone'] = $this->language->get('text_telephone');
		$data['text_fax'] = $this->language->get('text_fax');
		$data['text_open'] = $this->language->get('text_open');
		$data['text_comment'] = $this->language->get('text_comment');
		$data['text_contact_us'] = $this->language->get('text_contact_us');
		$data['text_feedback_enquiries'] = $this->language->get('text_feedback_enquiries');
		$data['text_about_us'] = $this->language->get('text_about_us');
		$data['text_last_updated'] = $this->language->get('text_last_updated');
		$data['text_reach_us'] = $this->language->get('text_reach_us');
		$data['text_located_at'] = $this->language->get('text_located_at');

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_phone'] = $this->language->get('entry_phone');
		$data['entry_email'] = $this->language->get('entry_email');
		$data['entry_enquiry'] = $this->language->get('entry_enquiry');

		$data['button_map'] = $this->language->get('button_map');

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}

		if (isset($this->error['email'])) {
			$data['error_email'] = $this->error['email'];
		} else {
			$data['error_email'] = '';
		}

		if (isset($this->error['phone'])) {
			$data['error_phone'] = $this->error['phone'];
		} else {
			$data['error_phone'] = '';
		}

		if (isset($this->error['enquiry'])) {
			$data['error_enquiry'] = $this->error['enquiry'];
		} else {
			$data['error_enquiry'] = '';
		}

		$data['button_submit'] = $this->language->get('button_submit');

		$data['action'] = $this->url->link('information/contact', '', true);

		$this->load->model('tool/image');

		if ($this->config->get('config_image')) {
			$data['image'] = $this->model_tool_image->resize($this->config->get('config_image'), $this->config->get($this->config->get('config_theme') . '_image_location_width'), $this->config->get($this->config->get('config_theme') . '_image_location_height'));
		} else {
			$data['image'] = false;
		}

		$data['store'] = $this->config->get('config_name');
		$data['address'] = nl2br($this->config->get('config_address'));
		$data['geocode'] = $this->config->get('config_geocode');
		$data['geocode_hl'] = $this->config->get('config_language');
		$data['telephone'] = $this->config->get('config_telephone');
		$data['fax'] = $this->config->get('config_fax');
		$data['open'] = nl2br($this->config->get('config_open'));
		$data['comment'] = html_entity_decode($this->config->get('config_comment'), ENT_QUOTES, 'UTF-8');

		$data['locations'] = array();

		$this->load->model('localisation/location');

		foreach((array)$this->config->get('config_location') as $location_id) {
			$location_info = $this->model_localisation_location->getLocation($location_id);

			if ($location_info) {
				if ($location_info['image']) {
					$image = $this->model_tool_image->resize($location_info['image'], $this->config->get($this->config->get('config_theme') . '_image_location_width'), $this->config->get($this->config->get('config_theme') . '_image_location_height'));
				} else {
					$image = false;
				}

				$data['locations'][] = array(
					'location_id' => $location_info['location_id'],
					'name'        => $location_info['name'],
					'address'     => nl2br($location_info['address']),
					'geocode'     => $location_info['geocode'],
					'telephone'   => $location_info['telephone'],
					'fax'         => $location_info['fax'],
					'image'       => $image,
					'open'        => nl2br($location_info['open']),
					'comment'     => html_entity_decode($location_info['comment'], ENT_QUOTES, 'UTF-8')
				);
			}
		}



		// Captcha
		if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('contact', (array)$this->config->get('config_captcha_page'))) {
			$data['captcha'] = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha'), $this->error);
		} else {
			$data['captcha'] = '';
		}

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('information/contact', $data));
	}

	protected function validate() {
		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 32)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		if (utf8_strlen($this->request->post['phone']) < 7) {
			$this->error['phone'] = $this->language->get('error_phone');
		}

		if (!filter_var($this->request->post['email'], FILTER_VALIDATE_EMAIL)) {
			$this->error['email'] = $this->language->get('error_email');
		}

		if ((utf8_strlen($this->request->post['enquiry']) < 10) || (utf8_strlen($this->request->post['enquiry']) > 3000)) {
			$this->error['enquiry'] = $this->language->get('error_enquiry');
		}

		// Captcha
		if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('contact', (array)$this->config->get('config_captcha_page'))) {
			$captcha = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha') . '/validate');

			if ($captcha) {
				$this->error['captcha'] = $captcha;
			}
		}

		return !$this->error;
	}

	public function success() {
		$this->load->language('information/contact');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('information/contact')
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_message'] = $this->language->get('text_success');

		$data['button_continue'] = $this->language->get('button_continue');

		$data['continue'] = $this->url->link('common/home');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('common/success', $data));
	}

	public function feedback() {
		$this->load->language('information/contact');

		$this->load->model('catalog/information');

		$this->load->model('tool/image');

		$this->document->setTitle($this->language->get('heading_title'));

		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		$json = array();

		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {

			$email = html_entity_decode($this->request->post['email'], ENT_QUOTES, 'UTF-8');
			$phone = html_entity_decode($this->request->post['telephone'], ENT_QUOTES, 'UTF-8');
			$firstname = html_entity_decode($this->request->post['firstname'], ENT_QUOTES, 'UTF-8');
			$lastname = html_entity_decode($this->request->post['lastname'], ENT_QUOTES, 'UTF-8');
			$name = $firstname . ' ' .$lastname;
			$message = html_entity_decode($this->request->post['message'], ENT_QUOTES, 'UTF-8');
			$series = html_entity_decode($this->request->post['series'], ENT_QUOTES, 'UTF-8');
			$subject = html_entity_decode($this->request->post['subject'], ENT_QUOTES, 'UTF-8');
			$attachment = html_entity_decode(((isset($this->request->post['attachment'])) ? $this->request->post['attachment'] : ''), ENT_QUOTES, 'UTF-8');

			$text = html_entity_decode($this->config->get('config_kb_message'), ENT_QUOTES, 'UTF-8');
			$replace = array(
					'{FIRSTNAME}' => $firstname,
					'{FULLNAME}'  => $name,
					'{LASTNAME}'  => $lastname,
					'{TELEPHONE}' => $phone,
					'{EMAIL}'     => $email,
					'{MESSAGE}'   => nl2br($message),
					'{SERIES}'   => $series,
					'{SUBJECT}'   => $subject,
					'{ATTACHMENT}' => $server . $attachment
				);
			if(empty($text)) {
				$text = implode("\n", array_keys($replace));
			}
			$text = str_replace(array_keys($replace), array_values($replace), $text);

			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

			$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($email);
			$mail->setSender($name);
			$mail->setSubject($subject);
			$mail->setHtml($text);
			if(!empty($attachment) && file_exists(DIR_IMAGE . $attachment) && is_file(DIR_IMAGE . $attachment)) {
				$mail->addAttachment(DIR_IMAGE . $attachment);
			}
			$mail->send();

			$data['text_message'] = $this->language->get('text_success');
			$data['home'] = $this->url->link('common/home');

			$this->session->data['kb_form_message'] = $this->load->view('information/contact_message', $data);
			//$this->response->redirect($this->url->link('information/contact/success/1'));
			$json['success'] = 1;
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
