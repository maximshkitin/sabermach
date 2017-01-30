<?php
class ControllerCommonHeader extends Controller {
	public function index() {
		// Analytics
		$this->load->model('extension/extension');

		$data['analytics'] = array();

		$analytics = $this->model_extension_extension->getExtensions('analytics');

		foreach ($analytics as $analytic) {
			if ($this->config->get($analytic['code'] . '_status')) {
				$data['analytics'][] = $this->load->controller('extension/analytics/' . $analytic['code'], $this->config->get($analytic['code'] . '_status'));
			}
		}

		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->document->addLink($server . 'image/' . $this->config->get('config_icon'), 'icon');
		}

		$data['title'] = $this->document->getTitle();

		$data['base'] = $server;
		$data['description'] = $this->document->getDescription();
		$data['keywords'] = $this->document->getKeywords();
		$data['links'] = $this->document->getLinks();
		$data['styles'] = $this->document->getStyles();
		$data['scripts'] = $this->document->getScripts();
		$data['lang'] = $this->language->get('code');
		$data['direction'] = $this->language->get('direction');

		$data['name'] = $this->config->get('config_name');

		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo'] = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$data['logo'] = '';
		}

		$social_list = array(
				'fb' => 'fa fa-facebook',
				'tw' => 'fa fa-twitter',
				'in' => 'fa fa-instagram',
				'yt' => 'fa fa-youtube',
			);

		foreach ($social_list as $key => $class) {
			$social_link = $this->config->get('config_'.$key);
			if(!empty($social_link)) {
				$link = new StdClass;
				$link->class = $class;
				$link->url = $social_link;
				$data['social'][] = $link;
				unset($link);
			}
		}

		$this->load->language('common/header');

		$data['text_home'] = $this->language->get('text_home');

		// Wishlist
		if ($this->customer->isLogged()) {
			$this->load->model('account/wishlist');

			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), $this->model_account_wishlist->getTotalWishlist());
		} else {
			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
		}

		$data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
		$data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', true), $this->customer->getFirstName(), $this->url->link('account/logout', '', true));

		$data['text_account'] = $this->language->get('text_account');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_logout'] = $this->language->get('text_logout');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_all'] = $this->language->get('text_all');
		$data['text_faq'] = $this->language->get('text_faq');
		$data['text_about'] = $this->language->get('text_about');
		$data['text_contact'] = $this->language->get('text_contact');
		$data['text_cart_title'] = $this->language->get('text_cart_title');

		$data['home'] = $this->url->link('common/home');
		$data['wishlist'] = $this->url->link('account/wishlist', '', true);
		$data['logged'] = $this->customer->isLogged();
		$data['account'] = $this->url->link('account/account', '', true);
		$data['register'] = $this->url->link('account/register', '', true);
		$data['login'] = $this->url->link('account/login', '', true);
		$data['order'] = $this->url->link('account/order', '', true);
		$data['transaction'] = $this->url->link('account/transaction', '', true);
		$data['download'] = $this->url->link('account/download', '', true);
		$data['logout'] = $this->url->link('account/logout', '', true);
		$data['shopping_cart'] = $this->url->link('checkout/cart');
		$data['checkout'] = $this->url->link('checkout/checkout', '', true);
		$data['contact'] = $this->url->link('information/contact');
		$data['telephone'] = $this->config->get('config_telephone');

		$data['total'] = $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0);

		$data['loged'] = $this->customer->isLogged();

		// Menu
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			if ($category['top']) {
				// Level 2
				/*$children_data = array();

				$children = $this->model_catalog_category->getCategories($category['category_id']);

				foreach ($children as $child) {
					$filter_data = array(
						'filter_category_id'  => $child['category_id'],
						'filter_sub_category' => true
					);

					$children_data[] = array(
						'name'  => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
						'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
					);
				}*/

				// Level 1
				$category_name = explode(' ', $category['name']);
				$name = array();
				if(!empty($category_name)) {
					foreach ($category_name as $key => $text) {
						if($key == 0) {
							$name[] = $text;
						} elseif($key == 1) {
							$_text = array_slice($category_name, $key);
							$name[] = implode(' ', $_text);
							break;
						}
					}
				}
				$data['categories'][] = array(
					'name'     => $name,
					// 'children' => $children_data,
					'column'   => $category['column'] ? $category['column'] : 1,
					'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
				);
			}
		}

		$data['language'] = $this->load->controller('common/language');
		$data['currency'] = $this->load->controller('common/currency');
		$data['search'] = $this->load->controller('common/search');
		$data['cart'] = $this->load->controller('common/cart');

		// For page specific css
		if (isset($this->request->get['route'])) {
			if (isset($this->request->get['product_id'])) {
				$class = '-' . $this->request->get['product_id'];
			} elseif (isset($this->request->get['path'])) {
				$class = '-' . $this->request->get['path'];
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$class = '-' . $this->request->get['manufacturer_id'];
			} elseif (isset($this->request->get['information_id'])) {
				$class = '-' . $this->request->get['information_id'];
			} else {
				$class = '';
			}



			$data['class'] = str_replace('/', '-', $this->request->get['route']) . $class;
		} else {
			$data['class'] = 'common-home';
		}

		$this->load->model('catalog/product');

		$data['products'] = array();

		$filter_data = array(
			'filter_category_id' => 63
		);

		//if(isset($this->request->get['path'])) {
			$results = $this->model_catalog_product->getProducts($filter_data);

			if(!empty($results)){
				foreach ($results as $result) {
					$product_name = explode(' ', $result['name']);
					$name = array();
					if(!empty($product_name)) {
						foreach ($product_name as $key => $text) {
							if($key == 0) {
								$name[] = $text;
							} elseif($key == 1) {
								if(preg_match('/^\d+$/', $text) && isset($product_name[$key + 1])) {
									$_text = array_slice($product_name, $key + 1);
									$name[0] .= ' ' . $text;
								} else {
									$_text = array_slice($product_name, $key);
								}
								$name[] = implode(' ', $_text);
								break;
							}
						}
					}
					if($result['product_id'] == 53 || $result['product_id'] == 54){
						$data['products']['first'][] = array(
							'product_id'  => $result['product_id'],
							'name'        => $name,
							'href'        => $this->url->link('product/product', 'path=63' . '&product_id=' . $result['product_id'] )
						);
					} else {
						$data['products']['second'][] = array(
							'product_id'  => $result['product_id'],
							'name'        => $name,
							'href'        => $this->url->link('product/product', 'path=63' . '&product_id=' . $result['product_id'] )
						);
					}
				}
			}
		//}

		$data['store'] = $this->url->link('product/category', 'path=63');

		return $this->load->view('common/header', $data);
	}
}
