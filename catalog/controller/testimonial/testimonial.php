<?php
class ControllerTestimonialTestimonial extends Controller {
	private $error           = array();
	private $moduleName      = 'testimonial';
	private $moduleModel     = 'model_extension_module_testimonial';
	private $moduleModelPath = 'extension/module/testimonial';
	private $modulePath      = 'testimonial/testimonial';
	private $moduleVersion   = '1.4.1';

	public function index() {
		$this->load->model('catalog/product');
		$this->load->model('tool/image');

		if (!$this->customer->isLogged()) {
			$this->response->redirect($this->url->link('account/login', '', true));
		}

		$lang_ar = $this->load->language($this->moduleModelPath);

		foreach ($lang_ar as $key => $item) {
			$data[$key] = $item;
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$this->document->setTitle($data['heading_title']);

		$data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));

		$this->load->model($this->moduleModelPath);

		$data['review_status'] = 1;

		if ($this->config->get('config_review_guest') || $this->customer->isLogged()) {
			$data['review_guest'] = true;
		} else {
			$data['review_guest'] = false;
		}

		if ($this->customer->isLogged()) {
			$data['customer_name'] = $this->customer->getFirstName().' '.$this->customer->getLastName();
			$avatar                = $this->customer->getAvatar();
			$data['avatar']        = (!empty($avatar))?$this->model_tool_image->resize($avatar, 100, 100):$this->model_tool_image->resize('catalog/default-user-avatar.png', 100, 100);
		} else {
			$data['customer_name'] = 'Guest';
			$data['avatar']        = $this->model_tool_image->resize('catalog/default-user-avatar.png', 100, 100);
		}

		$data['breadcrumbs'][] = array(
			'text' => $data['heading_title'],
			'href' => $this->url->link($this->modulePath)
		);

		$data['name']       = $this->config->get('config_name');
		$data['help_email'] = $this->config->get('config_help_email');
		$data['help_phone'] = $this->config->get('config_help_phone');

		if (isset($this->session->data['guest'])) {
			if (isset($this->session->data['guest']['firstname'])) {
				$data['firstname'] = $this->session->data['guest']['firstname'];
			} else {
				$data['firstname'] = '';
			}

			if (isset($this->session->data['guest']['lastname'])) {
				$data['lastname'] = $this->session->data['guest']['lastname'];
			} else {
				$data['lastname'] = '';
			}

			if (isset($this->session->data['guest']['email'])) {
				$data['email'] = $this->session->data['guest']['email'];
			} else {
				$data['email'] = '';
			}

			if (isset($this->session->data['guest']['telephone'])) {
				$data['telephone'] = $this->session->data['guest']['telephone'];
			} else {
				$data['telephone'] = '';
			}

		} else {
			$data['firstname'] = '';
			$data['lastname']  = '';
			$data['email']     = '';
			$data['telephone'] = '';
		}

		$data['products'] = array();
		$filter_data      = array();
		$products         = $this->model_catalog_product->getProducts($filter_data);

		if (!empty($products)) {
			foreach ($products as $product) {
				$data['products'][] = $product['name'];
			}
		}

		$data['knb'] = $this->url->link('blog/category', '');

		$subjects         = $this->config->get('config_kb_subjects');
		$subjects         = str_replace(array("\n\r", "\r\n"), "\n", $subjects);
		$data['subjects'] = explode("\n", $subjects);

		$data['action'] = $this->url->link('information/contact/feedback', '', true);

		$data['action_reply'] = $this->url->link('testimonial/testimonial/write', '', true);

		if (isset($this->session->data['kb_form_message'])) {
			$data['form_message'] = $this->session->data['kb_form_message'];
			unset($this->session->data['kb_form_message']);
		} else {
			$data['form_message'] = '';
		}

		$data['review'] = $this->url->link($this->modulePath.'/review');
		$data['write']  = $this->url->link($this->modulePath.'/write');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$data['reviews'] = array();

		$review_total = $this->{ $this->moduleModel}->getTotalReviews();

		$results = $this->{ $this->moduleModel}->getReviews(($page-1)*5, 5);

		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		foreach ($results as $result) {
			$customer = (int) $result['customer_id'];
			if (!empty($customer)) {
				$this->load->model('account/customer');
				$customer_info = $this->model_account_customer->getCustomer($customer);
				if ($customer_info) {
					if (empty($customer_info['avatar'])) {
						$avatar = $this->model_tool_image->resize('catalog/default-user-avatar.png', 100, 100);
					} else {
						$avatar = $this->model_tool_image->resize($customer_info['avatar'], 100, 100);
					}
					$author = $customer_info['firstname'].' '.$customer_info['lastname'];
				} else {
					$avatar = $this->model_tool_image->resize('catalog/default-user-avatar.png', 100, 100);
					$author = $result['author'];
				}
			} else {
				if (!empty($result['avatar'])) {
					$avatar = $this->model_tool_image->resize($result['avatar'], 100, 100);
				} else {
					$avatar = $this->model_tool_image->resize('catalog/default-user-avatar.png', 100, 100);
				}
				$author = $result['author'];
			}

			$files  = array();
			$_files = json_decode($result['files']);
			if (!empty($_files)) {
				foreach ($_files as $file) {
					if (!empty($file) && is_file(DIR_IMAGE.$file)) {
						$file_data          = array();
						$file_data['image'] = $server.'image/'.$file;
						$file_data['thumb'] = $this->model_tool_image->resize($file, 50, 50);
						$files[]            = $file_data;
					}
				}
			}

			$data['reviews'][] = array(
				'avatar'     => $avatar,
				'author'     => $author,
				'group'      => $result['groups'],
				'text'       => nl2br($result['text']),
				'files'      => $files,
				'date_added' => date('F n, Y g:h A', strtotime($result['date_added']))
			);
		}

		//$data['author'] = $this->customer->getFirstName() . ' ' . $this->customer->getLastName();

		$pagination        = new Pagination();
		$pagination->total = $review_total;
		$pagination->page  = $page;
		$pagination->limit = 5;
		$pagination->url   = $this->url->link('testimonial/testimonial', '&page={page}');

		$data['count'] = $review_total;

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($review_total)?(($page-1)*5)+1:0, ((($page-1)*5) > ($review_total-5))?$review_total:((($page-1)*5)+5), $review_total, ceil($review_total/5));

		$data['column_left']    = $this->load->controller('common/column_left');
		$data['column_right']   = $this->load->controller('common/column_right');
		$data['content_top']    = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer']         = $this->load->controller('common/footer');
		$data['header']         = $this->load->controller('common/header');

		if (substr(VERSION, 0, 7) > '2.1.0.2') {
			$this->response->setOutput($this->load->view($this->modulePath, $data));
		} else {
			if (file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/template/'.$this->modulePath.'.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template').'/template/'.$this->modulePath.'.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/'.$this->modulePath.'.tpl', $data));
			}
		}
	}

	/*public function review() {
	$this->load->language($this->moduleModelPath);
	$this->load->model($this->moduleModelPath);

	$data['text_no_reviews'] = $this->language->get('text_no_reviews');

	if (isset($this->request->get['page'])) {
	$page = $this->request->get['page'];
	} else {
	$page = 1;
	}

	$data['reviews'] = array();

	$review_total = $this->{$this->moduleModel}->getTotalReviews();

	$results = $this->{$this->moduleModel}->getReviews(($page - 1) * 5, 5);

	foreach ($results as $result) {
	$data['reviews'][] = array(
	'author'     => $result['author'],
	'text'       => nl2br($result['text']),
	'rating'     => (int)$result['rating'],
	'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
	);
	}

	$pagination = new Pagination();

	$pagination->total = $review_total;
	$pagination->page = $page;
	$pagination->limit = 5;
	$pagination->url = 'index.php?route=' . $this->modulePath . '/review&page={page}';

	$data['pagination'] = $pagination->render();

	$data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * 5) + 1 : 0, ((($page - 1) * 5) > ($review_total - 5)) ? $review_total : ((($page - 1) * 5) + 5), $review_total, ceil($review_total / 5));

	if(substr(VERSION, 0, 7) > '2.1.0.2'){
	$this->response->setOutput($this->load->view($this->modulePath . '_list', $data));
	}else{
	if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/' . $this->modulePath . '_list.tpl')) {
	$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/' . $this->modulePath . '_list.tpl', $data));
	} else {
	$this->response->setOutput($this->load->view('default/template/' . $this->modulePath . '_list.tpl', $data));
	}
	}
	}*/

	public function write() {
		$this->load->language('information/contact');

		$this->load->model('tool/image');

		$this->load->model($this->moduleModelPath);

		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		$json = array();

		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {

			$message = html_entity_decode($this->request->post['text'], ENT_QUOTES, 'UTF-8');
			$message = strip_tags($message);
			$subject = 'New question';

			if ($this->customer->isLogged()) {
				$customer_name = $this->customer->getFirstName().' '.$this->customer->getLastName();
				$avatar        = $this->customer->getAvatar();
				$email         = $this->customer->getEmail();
			} else {
				$customer_name = 'Guest';
				$avatar        = $this->model_tool_image->resize('catalog/default-user-avatar.png', 100, 100);
				$email         = $this->config->get('config_email');
			}

			$files = array();

			if (!empty($this->request->post['files'])) {
				foreach ($this->request->post['files'] as $file) {
					$_file = html_entity_decode(((isset($file))?$file:''), ENT_QUOTES, 'UTF-8');
					if (!empty($_file) && file_exists(DIR_IMAGE.$_file) && is_file(DIR_IMAGE.$_file)) {
						$files[] = $_file;
					}
				}
			}

			$data = array(
				'name'   => $customer_name,
				'avatar' => '',
				'files'  => $files,
				'text'   => $message,
				'group'  => '',
			);

			$this->{ $this->moduleModel}->addReview($data);

			$replace = array(
				'{NAME}'    => $customer_name,
				'{AVATAR}'  => $avatar,
				'{MESSAGE}' => nl2br($message)
			);

			$text = html_entity_decode($this->config->get('config_review_mail'), ENT_QUOTES, 'UTF-8');

			if (empty($text)) {
				$text = implode("\n", array_keys($replace));
			}
			$text = str_replace(array_keys($replace), array_values($replace), $text);

			$mail                = new Mail();
			$mail->protocol      = $this->config->get('config_mail_protocol');
			$mail->parameter     = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port     = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout  = $this->config->get('config_mail_smtp_timeout');

			$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($email);
			$mail->setSender($customer_name);
			$mail->setSubject($subject);
			$mail->setHtml($text);
			if (!empty($files)) {
				foreach ($files as $file) {
					$mail->addAttachment(DIR_IMAGE.$file);
				}
			}
			$mail->send();

			$data['text_message'] = $this->language->get('text_success');
			$data['home']         = $this->url->link('common/home');

			$this->session->data['kb_form_message'] = $this->load->view('information/contact_message', $data);
			//$this->response->redirect($this->url->link('information/contact/success/1'));
			$json['success'] = 1;
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));

	}
}