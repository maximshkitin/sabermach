<?php
class ControllerAccountAddress extends Controller {
	private $error = array();

	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/address', '', true);

			$this->response->redirect($this->url->link('account/login', '', true));
		}

		$this->load->language('account/address');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('account/address');

		$this->getList();
	}

	public function add() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/address', '', true);

			$this->response->redirect($this->url->link('account/login', '', true));
		}

		$this->load->language('account/address');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('account/address');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_account_address->addAddress($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_add');

			// Add to activity log
			if ($this->config->get('config_customer_activity')) {
				$this->load->model('account/activity');

				$activity_data = array(
					'customer_id' => $this->customer->getId(),
					'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
				);

				$this->model_account_activity->addActivity('address_add', $activity_data);
			}

			$this->response->redirect($this->url->link('account/address', '', true));
		}

		$this->getForm();
	}

	public function edit() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/address', '', true);

			$this->response->redirect($this->url->link('account/login', '', true));
		}

		$this->load->language('account/address');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('account/address');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_account_address->editAddress($this->request->get['address_id'], $this->request->post);

			// Default Shipping Address
			if (isset($this->session->data['shipping_address']['address_id']) && ($this->request->get['address_id'] == $this->session->data['shipping_address']['address_id'])) {
				$this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->request->get['address_id'], 1);

				unset($this->session->data['shipping_method']);
				unset($this->session->data['shipping_methods']);
			}

			// Default Payment Address
			if (isset($this->session->data['payment_address']['address_id']) && ($this->request->get['address_id'] == $this->session->data['payment_address']['address_id'])) {
				$this->session->data['payment_address'] = $this->model_account_address->getAddress($this->request->get['address_id'], 0);

				unset($this->session->data['payment_method']);
				unset($this->session->data['payment_methods']);
			}

			$this->session->data['success'] = $this->language->get('text_edit');

			// Add to activity log
			if ($this->config->get('config_customer_activity')) {
				$this->load->model('account/activity');

				$activity_data = array(
					'customer_id' => $this->customer->getId(),
					'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
				);

				$this->model_account_activity->addActivity('address_edit', $activity_data);
			}

			$this->response->redirect($this->url->link('account/address', '', true));
		}

		$this->getForm();
	}

	public function delete() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/address', '', true);

			$this->response->redirect($this->url->link('account/login', '', true));
		}

		$this->load->language('account/address');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('account/address');

		if (isset($this->request->get['address_id']) && $this->validateDelete()) {
			$this->model_account_address->deleteAddress($this->request->get['address_id']);

			// Default Shipping Address
			if (isset($this->session->data['shipping_address']['address_id']) && ($this->request->get['address_id'] == $this->session->data['shipping_address']['address_id'])) {
				unset($this->session->data['shipping_address']);
				unset($this->session->data['shipping_method']);
				unset($this->session->data['shipping_methods']);
			}

			// Default Payment Address
			if (isset($this->session->data['payment_address']['address_id']) && ($this->request->get['address_id'] == $this->session->data['payment_address']['address_id'])) {
				unset($this->session->data['payment_address']);
				unset($this->session->data['payment_method']);
				unset($this->session->data['payment_methods']);
			}

			$this->session->data['success'] = $this->language->get('text_delete');

			// Add to activity log
			if ($this->config->get('config_customer_activity')) {
				$this->load->model('account/activity');

				$activity_data = array(
					'customer_id' => $this->customer->getId(),
					'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
				);
				
				$this->model_account_activity->addActivity('address_delete', $activity_data);
			}

			$this->response->redirect($this->url->link('account/address', '', true));
		}

		$this->getList();
	}

	protected function getList() {
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			if(isset($this->request->post['payment_address'])) {
				$this->model_account_address->editAddress($this->request->get['address_id'], $this->request->post['payment_address']);
				$this->session->data['payment_address'] = $this->model_account_address->getAddress($this->request->get['address_id'], 0);

				unset($this->session->data['payment_method']);
				unset($this->session->data['payment_methods']);

				$this->session->data['success'] = $this->language->get('text_edit_payment');
			}

			if(isset($this->request->post['shipping_address'])) {
				$this->model_account_address->editAddress($this->request->get['address_id'], $this->request->post['shipping_address']);

				//if(!isset($this->request->post['shipping_address']['same_address']) || empty($this->request->post['shipping_address']['same_address'])) {
				//	$this->model_account_address->setDefaultAddress(0);
					$this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->request->get['address_id'], 1);
				//} else {
				//	$this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->request->get['address_id'], 0);
				//	$this->model_account_address->setDefaultAddress((int) $this->session->data['shipping_address']['address_id']);
				//}

				unset($this->session->data['shipping_method']);
				unset($this->session->data['shipping_methods']);

				$this->session->data['success'] = $this->language->get('text_edit_shipping');
			}

			// Add to activity log
			if ($this->config->get('config_customer_activity')) {
				$this->load->model('account/activity');

				$activity_data = array(
					'customer_id' => $this->customer->getId(),
					'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
				);

				$this->model_account_activity->addActivity('address_edit', $activity_data);
			}

			$this->response->redirect($this->url->link('account/address', '', true));
		}

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('account/account', '', true)
		);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_details'),
			'href'      => $this->url->link('account/edit', '', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('account/address', '', true)
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_address_book'] = $this->language->get('text_address_book');
		$data['text_empty'] = $this->language->get('text_empty');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_none'] = $this->language->get('text_none');

		$data['button_new_address'] = $this->language->get('button_new_address');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['button_back'] = $this->language->get('button_back');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['addresses'] = array();

		$results = $this->model_account_address->getAddresses();

		foreach ($results as $result) {
			if($result['type'] == 0) {
				$data['payment_address'] = $result;
				$data['payment_address']['update'] = $this->url->link('account/address', 'address_id=' . $result['address_id'], true);
			} else {
				$data['shipping_address'] = $result;
				$data['shipping_address']['update'] = $this->url->link('account/address', 'address_id=' . $result['address_id'], true);
			}
		}

		$data['back'] = $this->url->link('account/edit', '', true);

		$data['knb'] = $this->url->link('blog/category', '');
		$data['mb'] = $this->url->link('testimonial/testimonial', '', true);

		$this->load->model('tool/image');
		$this->load->model('account/customer');
		$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());
		$data['firstname'] = $customer_info['firstname'];
		$data['lastname'] = $customer_info['lastname'];
		$data['email'] = $customer_info['email'];
		$data['telephone'] = $customer_info['telephone'];
		if(empty($customer_info['avatar'])) {
			$data['avatar'] = $this->model_tool_image->resize('catalog/default-user-avatar.png', 100, 100);
			$data['avatar_small'] = $this->model_tool_image->resize('catalog/default-user-avatar.png', 90, 90);
		} else {
			$data['avatar'] = $this->model_tool_image->resize($customer_info['avatar'], 100, 100);
			$data['avatar_small'] = $this->model_tool_image->resize($customer_info['avatar'], 90, 90);
		}

		$data['back'] = $this->url->link('account/account', '', true);

		$data['edit_profile'] = $this->url->link('account/edit/profile', '', true);

		$data['address'] = $this->url->link('account/address', '', true);

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->session->data['error_warning'])) {
			$data['error_warning'] = $this->session->data['error_warning'];
			unset($this->session->data['error_warning']);
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['address_1'])) {
			$data['error_payment_address_1'] = $this->error['address_1'];
		} else {
			$data['error_payment_address_1'] = '';
		}

		if (isset($this->error['city'])) {
			$data['error_payment_city'] = $this->error['city'];
		} else {
			$data['error_payment_city'] = '';
		}

		if (isset($this->error['postcode'])) {
			$data['error_payment_postcode'] = $this->error['postcode'];
		} else {
			$data['error_payment_postcode'] = '';
		}

		if (isset($this->error['country'])) {
			$data['error_payment_country'] = $this->error['country'];
		} else {
			$data['error_payment_country'] = '';
		}

		if (isset($this->error['zone'])) {
			$data['error_payment_zone'] = $this->error['zone'];
		} else {
			$data['error_payment_zone'] = '';
		}

		if (isset($this->error['address_1'])) {
			$data['error_shipping_address_1'] = $this->error['address_1'];
		} else {
			$data['error_shipping_address_1'] = '';
		}

		if (isset($this->error['city'])) {
			$data['error_shipping_city'] = $this->error['city'];
		} else {
			$data['error_shipping_city'] = '';
		}

		if (isset($this->error['postcode'])) {
			$data['error_shipping_postcode'] = $this->error['postcode'];
		} else {
			$data['error_shipping_postcode'] = '';
		}

		if (isset($this->error['country'])) {
			$data['error_shipping_country'] = $this->error['country'];
		} else {
			$data['error_shipping_country'] = '';
		}

		if (isset($this->error['zone'])) {
			$data['error_shipping_zone'] = $this->error['zone'];
		} else {
			$data['error_shipping_zone'] = '';
		}

		if (isset($this->request->post['payment_address']['address_1'])) {
			$data['payment_address_1'] = $this->request->post['payment_address']['address_1'];
		} elseif (!empty($data['payment_address'])) {
			$data['payment_address_1'] = $data['payment_address']['address_1'];
		} else {
			$data['payment_address_1'] = '';
		}

		if (isset($this->request->post['payment_address']['postcode'])) {
			$data['payment_postcode'] = $this->request->post['payment_address']['postcode'];
		} elseif (!empty($data['payment_address'])) {
			$data['payment_postcode'] = $data['payment_address']['postcode'];
		} else {
			$data['payment_postcode'] = '';
		}

		if (isset($this->request->post['payment_address']['country_id'])) {
			$data['payment_country_id'] = (int)$this->request->post['payment_address']['country_id'];
		}  elseif (!empty($data['payment_address'])) {
			$data['payment_country_id'] = $data['payment_address']['country_id'];
		} else {
			$data['payment_country_id'] = $this->config->get('config_country_id');
		}

		if (isset($this->request->post['payment_address']['zone_id'])) {
			$data['payment_zone_id'] = (int)$this->request->post['payment_address']['zone_id'];
		}  elseif (!empty($data['payment_address'])) {
			$data['payment_zone_id'] = $data['payment_address']['zone_id'];
		} else {
			$data['payment_zone_id'] = '';
		}

		if (isset($this->request->post['shipping_address']['address_1'])) {
			$data['shipping_address_1'] = $this->request->post['shipping_address']['address_1'];
		} elseif (!empty($data['shipping_address'])) {
			$data['shipping_address_1'] = $data['shipping_address']['address_1'];
		} else {
			$data['shipping_address_1'] = '';
		}

		if (isset($this->request->post['shipping_address']['postcode'])) {
			$data['shipping_postcode'] = $this->request->post['shipping_address']['postcode'];
		} elseif (!empty($data['shipping_address'])) {
			$data['shipping_postcode'] = $data['shipping_address']['postcode'];
		} else {
			$data['shipping_postcode'] = '';
		}

		if (isset($this->request->post['shipping_address']['country_id'])) {
			$data['shipping_country_id'] = (int)$this->request->post['shipping_address']['country_id'];
		}  elseif (!empty($data['shipping_address'])) {
			$data['shipping_country_id'] = $data['shipping_address']['country_id'];
		} else {
			$data['shipping_country_id'] = $this->config->get('config_country_id');
		}

		if (isset($this->request->post['shipping_address']['zone_id'])) {
			$data['shipping_zone_id'] = (int)$this->request->post['shipping_address']['zone_id'];
		}  elseif (!empty($data['shipping_address'])) {
			$data['shipping_zone_id'] = $data['shipping_address']['zone_id'];
		} else {
			$data['shipping_zone_id'] = '';
		}

		if (isset($this->request->post['shipping_address']['same_address'])) {
			$data['shipping_same_address'] = (int)$this->request->post['shipping_address']['same_address'];
		}  elseif (!empty($customer_info['address_id'])) {
			$data['shipping_same_address'] = 1;
		} else {
			$data['shipping_same_address'] = 0;
		}

		$this->load->model('localisation/country');
		$data['countries'] = $this->model_localisation_country->getCountries();

		$data['dashboard'] = $this->url->link('account/account', '', true);
		$data['order'] = $this->url->link('account/order', '', true);
		$data['edit'] = $this->url->link('account/edit', '', true);

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('account/address_list', $data));
	}

	protected function getForm() {
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('account/account', '', true)
		);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_details'),
			'href'      => $this->url->link('account/edit', '', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('account/address', '', true)
		);

		if (!isset($this->request->get['address_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_edit_address'),
				'href' => $this->url->link('account/address/add', '', true)
			);
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_edit_address'),
				'href' => $this->url->link('account/address/edit', 'address_id=' . $this->request->get['address_id'], true)
			);
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit_address'] = $this->language->get('text_edit_address');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_loading'] = $this->language->get('text_loading');

		$data['entry_firstname'] = $this->language->get('entry_firstname');
		$data['entry_lastname'] = $this->language->get('entry_lastname');
		$data['entry_company'] = $this->language->get('entry_company');
		$data['entry_address_1'] = $this->language->get('entry_address_1');
		$data['entry_address_2'] = $this->language->get('entry_address_2');
		$data['entry_postcode'] = $this->language->get('entry_postcode');
		$data['entry_city'] = $this->language->get('entry_city');
		$data['entry_country'] = $this->language->get('entry_country');
		$data['entry_zone'] = $this->language->get('entry_zone');
		$data['entry_default'] = $this->language->get('entry_default');

		$data['button_continue'] = $this->language->get('button_continue');
		$data['button_back'] = $this->language->get('button_back');
		$data['button_upload'] = $this->language->get('button_upload');

		if (isset($this->error['firstname'])) {
			$data['error_firstname'] = $this->error['firstname'];
		} else {
			$data['error_firstname'] = '';
		}

		if (isset($this->error['lastname'])) {
			$data['error_lastname'] = $this->error['lastname'];
		} else {
			$data['error_lastname'] = '';
		}

		if (isset($this->error['address_1'])) {
			$data['error_address_1'] = $this->error['address_1'];
		} else {
			$data['error_address_1'] = '';
		}

		if (isset($this->error['city'])) {
			$data['error_city'] = $this->error['city'];
		} else {
			$data['error_city'] = '';
		}

		if (isset($this->error['postcode'])) {
			$data['error_postcode'] = $this->error['postcode'];
		} else {
			$data['error_postcode'] = '';
		}

		if (isset($this->error['country'])) {
			$data['error_country'] = $this->error['country'];
		} else {
			$data['error_country'] = '';
		}

		if (isset($this->error['zone'])) {
			$data['error_zone'] = $this->error['zone'];
		} else {
			$data['error_zone'] = '';
		}

		if (isset($this->error['custom_field'])) {
			$data['error_custom_field'] = $this->error['custom_field'];
		} else {
			$data['error_custom_field'] = array();
		}
		
		if (!isset($this->request->get['address_id'])) {
			$data['action'] = $this->url->link('account/address/add', '', true);
		} else {
			$data['action'] = $this->url->link('account/address/edit', 'address_id=' . $this->request->get['address_id'], true);
		}

		if (isset($this->request->get['address_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$address_info = $this->model_account_address->getAddress($this->request->get['address_id']);
		}

		if (isset($this->request->post['firstname'])) {
			$data['firstname'] = $this->request->post['firstname'];
		} elseif (!empty($address_info)) {
			$data['firstname'] = $address_info['firstname'];
		} else {
			$data['firstname'] = '';
		}

		if (isset($this->request->post['lastname'])) {
			$data['lastname'] = $this->request->post['lastname'];
		} elseif (!empty($address_info)) {
			$data['lastname'] = $address_info['lastname'];
		} else {
			$data['lastname'] = '';
		}

		if (isset($this->request->post['company'])) {
			$data['company'] = $this->request->post['company'];
		} elseif (!empty($address_info)) {
			$data['company'] = $address_info['company'];
		} else {
			$data['company'] = '';
		}

		if (isset($this->request->post['address_1'])) {
			$data['address_1'] = $this->request->post['address_1'];
		} elseif (!empty($address_info)) {
			$data['address_1'] = $address_info['address_1'];
		} else {
			$data['address_1'] = '';
		}

		if (isset($this->request->post['address_2'])) {
			$data['address_2'] = $this->request->post['address_2'];
		} elseif (!empty($address_info)) {
			$data['address_2'] = $address_info['address_2'];
		} else {
			$data['address_2'] = '';
		}

		if (isset($this->request->post['postcode'])) {
			$data['postcode'] = $this->request->post['postcode'];
		} elseif (!empty($address_info)) {
			$data['postcode'] = $address_info['postcode'];
		} else {
			$data['postcode'] = '';
		}

		if (isset($this->request->post['city'])) {
			$data['city'] = $this->request->post['city'];
		} elseif (!empty($address_info)) {
			$data['city'] = $address_info['city'];
		} else {
			$data['city'] = '';
		}

		if (isset($this->request->post['country_id'])) {
			$data['country_id'] = (int)$this->request->post['country_id'];
		}  elseif (!empty($address_info)) {
			$data['country_id'] = $address_info['country_id'];
		} else {
			$data['country_id'] = $this->config->get('config_country_id');
		}

		if (isset($this->request->post['zone_id'])) {
			$data['zone_id'] = (int)$this->request->post['zone_id'];
		}  elseif (!empty($address_info)) {
			$data['zone_id'] = $address_info['zone_id'];
		} else {
			$data['zone_id'] = '';
		}

		$this->load->model('localisation/country');

		$data['countries'] = $this->model_localisation_country->getCountries();

		// Custom fields
		$this->load->model('account/custom_field');

		$data['custom_fields'] = $this->model_account_custom_field->getCustomFields($this->config->get('config_customer_group_id'));

		if (isset($this->request->post['custom_field'])) {
			$data['address_custom_field'] = $this->request->post['custom_field'];
		} elseif (isset($address_info)) {
			$data['address_custom_field'] = $address_info['custom_field'];
		} else {
			$data['address_custom_field'] = array();
		}

		if (isset($this->request->post['default'])) {
			$data['default'] = $this->request->post['default'];
		} elseif (isset($this->request->get['address_id'])) {
			$data['default'] = $this->customer->getAddressId() == $this->request->get['address_id'];
		} else {
			$data['default'] = false;
		}

		$data['back'] = $this->url->link('account/address', '', true);

		$this->load->model('tool/image');
		$this->load->model('account/customer');
		$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());
		if(empty($customer_info['avatar'])) {
			$data['avatar'] = $this->model_tool_image->resize('catalog/default-user-avatar.png', 100, 100);
			$data['avatar_small'] = $this->model_tool_image->resize('catalog/default-user-avatar.png', 90, 90);
		} else {
			$data['avatar'] = $this->model_tool_image->resize($customer_info['avatar'], 100, 100);
			$data['avatar_small'] = $this->model_tool_image->resize($customer_info['avatar'], 90, 90);
		}

		$data['back'] = $this->url->link('account/account', '', true);

		$data['edit_profile'] = $this->url->link('account/edit/profile', '', true);

		$data['shipping_address'] = $this->session->data['shipping_address'];
		$data['payment_address'] = $this->session->data['payment_address'];

		$data['address'] = $this->url->link('account/address', '', true);

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->session->data['error_warning'])) {
			$data['error_warning'] = $this->session->data['error_warning'];
			unset($this->session->data['error_warning']);
		} else {
			$data['error_warning'] = '';
		}

		$data['dashboard'] = $this->url->link('account/account', '', true);
		$data['order'] = $this->url->link('account/order', '', true);
		$data['edit'] = $this->url->link('account/edit', '', true);

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');


		$this->response->setOutput($this->load->view('account/address_form', $data));
	}

	protected function validateForm() {
		if(isset($this->request->post['payment_address'])) {
			if ((utf8_strlen(trim($this->request->post['payment_address']['address_1'])) < 3) || (utf8_strlen(trim($this->request->post['payment_address']['address_1'])) > 128)) {
				$this->error['payment_address_1'] = $this->language->get('error_address_1');
			}

			$this->load->model('localisation/country');

			$country_info = $this->model_localisation_country->getCountry($this->request->post['payment_address']['country_id']);

			if ($country_info && $country_info['postcode_required'] && (utf8_strlen(trim($this->request->post['payment_address']['postcode'])) < 2 || utf8_strlen(trim($this->request->post['payment_address']['postcode'])) > 10)) {
				$this->error['payment_postcode'] = $this->language->get('error_postcode');
			}

			if ($this->request->post['payment_address']['country_id'] == '' || !is_numeric($this->request->post['payment_address']['country_id'])) {
				$this->error['payment_country'] = $this->language->get('error_country');
			}

			if (!isset($this->request->post['payment_address']['zone_id']) || $this->request->post['payment_address']['zone_id'] == '' || !is_numeric($this->request->post['payment_address']['zone_id'])) {
				$this->error['payment_zone'] = $this->language->get('error_zone');
			}
		}

		if(isset($this->request->post['shipping_address'])) {
			if ((utf8_strlen(trim($this->request->post['shipping_address']['address_1'])) < 3) || (utf8_strlen(trim($this->request->post['shipping_address']['address_1'])) > 128)) {
				$this->error['shipping_address_1'] = $this->language->get('error_address_1');
			}

			$this->load->model('localisation/country');

			$country_info = $this->model_localisation_country->getCountry($this->request->post['shipping_address']['country_id']);

			if ($country_info && $country_info['postcode_required'] && (utf8_strlen(trim($this->request->post['shipping_address']['postcode'])) < 2 || utf8_strlen(trim($this->request->post['shipping_address']['postcode'])) > 10)) {
				$this->error['shipping_postcode'] = $this->language->get('error_postcode');
			}

			if ($this->request->post['shipping_address']['country_id'] == '' || !is_numeric($this->request->post['shipping_address']['country_id'])) {
				$this->error['shipping_country'] = $this->language->get('error_country');
			}

			if (!isset($this->request->post['shipping_address']['zone_id']) || $this->request->post['shipping_address']['zone_id'] == '' || !is_numeric($this->request->post['shipping_address']['zone_id'])) {
				$this->error['shipping_zone'] = $this->language->get('error_zone');
			}
		}

		return !$this->error;
	}

	protected function validateDelete() {
		if ($this->model_account_address->getTotalAddresses() == 1) {
			$this->error['warning'] = $this->language->get('error_delete');
		}

		if ($this->customer->getAddressId() == $this->request->get['address_id']) {
			$this->error['warning'] = $this->language->get('error_default');
		}

		return !$this->error;
	}
}
