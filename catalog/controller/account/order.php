<?php
//require_once(DIR_SYSTEM . 'include/dompdf/vendor/autoload.php');
require_once (DIR_SYSTEM.'include/dompdf/autoload.inc.php');

use Dompdf\Dompdf;

class ControllerAccountOrder extends Controller {
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/order', '', true);

			$this->response->redirect($this->url->link('account/login', '', true));
		}

		// Payment Methods
		$method_data = array();
		$this->load->model('extension/extension');
		$results   = $this->model_extension_extension->getExtensions('payment');
		$recurring = $this->cart->hasRecurringProducts();
		foreach ($results as $result) {
			if ($this->config->get($result['code'].'_status')) {
				$this->load->model('extension/payment/'.$result['code']);

				$method = $this->{'model_extension_payment_'.$result['code']}->getMethod($this->session->data['payment_address'], 1);

				if ($method) {
					if ($recurring) {
						if (property_exists($this->{'model_extension_payment_'.$result['code']}, 'recurringPayments') && $this->{'model_extension_payment_'.$result['code']}->recurringPayments()) {
							$method_data[$result['code']] = $method;
						}
					} else {
						$method_data[$result['code']] = $method;
					}
				}
			}
		}
		$sort_order = array();
		foreach ($method_data as $key => $value) {
			$sort_order[$key] = $value['sort_order'];
		}
		array_multisort($sort_order, SORT_ASC, $method_data);
		$this->session->data['payment_methods'] = $method_data;
		if (isset($this->session->data['payment_methods'])) {
			$data['payment_methods'] = $this->session->data['payment_methods'];
		} else {
			$data['payment_methods'] = array();
		}
		// Payment Methods end

		$this->load->language('account/order');

		$this->document->setTitle($this->language->get('heading_title'));

		$url = '';

		if (isset($this->request->get['page'])) {
			$url .= '&page='.$this->request->get['page'];
		}

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
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('account/order', $url, true)
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_empty'] = $this->language->get('text_empty');

		$data['column_order_id']   = $this->language->get('column_order_id');
		$data['column_customer']   = $this->language->get('column_customer');
		$data['column_product']    = $this->language->get('column_product');
		$data['column_total']      = $this->language->get('column_total');
		$data['column_status']     = $this->language->get('column_status');
		$data['column_date_added'] = $this->language->get('column_date_added');

		$data['button_view']     = $this->language->get('button_view');
		$data['button_continue'] = $this->language->get('button_continue');

		$data['store'] = $this->url->link('product/category', 'path=63');
		$data['cart']  = $this->url->link('checkout/cart');

		$data['knb'] = $this->url->link('blog/category', '');
		$data['mb']  = $this->url->link('testimonial/testimonial', '', true);

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$data['orders'] = array();

		$this->load->model('account/order');
		$this->load->model('account/transaction');

		$data['filter'] = (isset($this->request->get['filter']))?$this->request->get['filter']:'';

		$filter = array();

		if (!empty($data['filter'])) {
			switch ($data['filter']) {
				case 'unpaid':
					$filter = array(7, 8, 10);
					break;

				case 'past':
					$filter = array(5, 14, 15, 11, 16, 3);
					break;

				case 'active':
				default:
					$filter = array(9, 13, 1, 15, 12);
					break;
			}
		}

		$order_total = $this->model_account_order->getTotalOrders($filter);

		$results = $this->model_account_order->getOrders(($page-1)*10, 10, $filter);
		foreach ($results as $result) {
			$product_total = $this->model_account_order->getTotalOrderProductsByOrderId($result['order_id']);
			$voucher_total = $this->model_account_order->getTotalOrderVouchersByOrderId($result['order_id']);
			$payment       = $this->model_account_transaction->getTransactionsByOrder($result['order_id']);
			$color         = '';
			if (in_array($result['order_status_id'], array(7, 8, 10))) {
				$color = 'red';
			}

			if (in_array($result['order_status_id'], array(5, 14, 15, 11, 16, 3))) {
				$color = 'grey';
			}

			if (in_array($result['order_status_id'], array(9, 13, 1, 15, 12))) {
				$color = 'light';
			}

			$data['orders'][] = array(
				'order_id'     => $result['order_id'],
				'name'         => $result['firstname'].' '.$result['lastname'],
				'status'       => $result['status'],
				'date_added'   => date('M n, Y', strtotime($result['date_added'])),
				'products'     => ($product_total+$voucher_total),
				'payment'      => reset($payment),
				'status_color' => $color,
				'total'        => $this->currency->format($result['total'], $result['currency_code'], $result['currency_value']),
				'view'         => $this->url->link('account/order/info', 'order_id='.$result['order_id'], true),
				'pdf'          => $this->url->link('account/order/info', 'order_id='.$result['order_id'].'&action=pdf', true),
				'download'     => $this->url->link('account/order/info', 'order_id='.$result['order_id'].'&action=download', true),
				'reorder'      => $this->url->link('account/order/reorderall', 'order_id='.$result['order_id'], true)
			);
		}

		$pagination        = new Pagination();
		$pagination->total = $order_total;
		$pagination->page  = $page;
		$pagination->limit = 10;
		$pagination->url   = $this->url->link('account/order', 'page={page}', true);

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($order_total)?(($page-1)*10)+1:0, ((($page-1)*10) > ($order_total-10))?$order_total:((($page-1)*10)+10), $order_total, ceil($order_total/10));

		$data['continue'] = $this->url->link('account/account', '', true);

		$this->load->model('tool/image');
		$this->load->model('account/customer');
		$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());
		if (empty($customer_info['avatar'])) {
			$data['avatar']       = $this->model_tool_image->resize('catalog/default-user-avatar.png', 100, 100);
			$data['avatar_small'] = $this->model_tool_image->resize('catalog/default-user-avatar.png', 90, 90);
		} else {
			$data['avatar']       = $this->model_tool_image->resize($customer_info['avatar'], 100, 100);
			$data['avatar_small'] = $this->model_tool_image->resize($customer_info['avatar'], 90, 90);
		}

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
		$data['edit']      = $this->url->link('account/edit', '', true);
		$data['order']     = $this->url->link('account/order', '', true);

		$data['actite'] = $this->url->link('account/order', 'filter=active', true);
		$data['unpaid'] = $this->url->link('account/order', 'filter=unpaid', true);
		$data['past']   = $this->url->link('account/order', 'filter=past', true);

		$customer_info     = $this->model_account_customer->getCustomer($this->customer->getId());
		$data['firstname'] = $customer_info['firstname'];
		$data['lastname']  = $customer_info['lastname'];
		$data['email']     = $customer_info['email'];
		$data['telephone'] = $customer_info['telephone'];

		$data['column_left']    = $this->load->controller('common/column_left');
		$data['column_right']   = $this->load->controller('common/column_right');
		$data['content_top']    = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer']         = $this->load->controller('common/footer');
		$data['header']         = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('account/order_list', $data));
	}

	public function info() {
		$this->load->language('account/order');

		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		$data['title'] = $this->document->getTitle();

		$data['name'] = $this->config->get('config_name');

		$data['base']        = $server;
		$data['description'] = $this->document->getDescription();
		$data['keywords']    = $this->document->getKeywords();

		if (isset($this->request->get['order_id'])) {
			$order_id = $this->request->get['order_id'];
		} else {
			$order_id = 0;
		}

		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/order/info', 'order_id='.$order_id, true);

			$this->response->redirect($this->url->link('account/login', '', true));
		}

		$this->load->model('account/order');

		$order_info = $this->model_account_order->getOrder($order_id);

		if ($order_info) {
			$this->document->setTitle($this->language->get('text_order'));

			$url = '';

			if (isset($this->request->get['page'])) {
				$url .= '&page='.$this->request->get['page'];
			}

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
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('account/order', $url, true)
			);

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_order'),
				'href' => $this->url->link('account/order/info', 'order_id='.$this->request->get['order_id'].$url, true)
			);

			$data['heading_title'] = $this->language->get('text_order');

			$data['text_order_detail']     = $this->language->get('text_order_detail');
			$data['text_invoice_no']       = $this->language->get('text_invoice_no');
			$data['text_order_id']         = $this->language->get('text_order_id');
			$data['text_date_added']       = $this->language->get('text_date_added');
			$data['text_shipping_method']  = $this->language->get('text_shipping_method');
			$data['text_shipping_address'] = $this->language->get('text_shipping_address');
			$data['text_payment_method']   = $this->language->get('text_payment_method');
			$data['text_payment_address']  = $this->language->get('text_payment_address');
			$data['text_history']          = $this->language->get('text_history');
			$data['text_comment']          = $this->language->get('text_comment');
			$data['text_no_results']       = $this->language->get('text_no_results');

			$data['column_name']       = $this->language->get('column_name');
			$data['column_model']      = $this->language->get('column_model');
			$data['column_quantity']   = $this->language->get('column_quantity');
			$data['column_price']      = $this->language->get('column_price');
			$data['column_total']      = $this->language->get('column_total');
			$data['column_action']     = $this->language->get('column_action');
			$data['column_date_added'] = $this->language->get('column_date_added');
			$data['column_status']     = $this->language->get('column_status');
			$data['column_comment']    = $this->language->get('column_comment');

			$data['button_reorder']  = $this->language->get('button_reorder');
			$data['button_return']   = $this->language->get('button_return');
			$data['button_continue'] = $this->language->get('button_continue');

			if (isset($this->session->data['error'])) {
				$data['error_warning'] = $this->session->data['error'];

				unset($this->session->data['error']);
			} else {
				$data['error_warning'] = '';
			}

			if (isset($this->session->data['success'])) {
				$data['success'] = $this->session->data['success'];

				unset($this->session->data['success']);
			} else {
				$data['success'] = '';
			}

			if ($order_info['invoice_no']) {
				$data['invoice_no'] = $order_info['invoice_prefix'].$order_info['invoice_no'];
			} else {
				$data['invoice_no'] = '';
			}

			$data['telephone'] = $order_info['telephone'];
			$data['email']     = $order_info['email'];

			$data['order_id']   = $this->request->get['order_id'];
			$data['date_added'] = date('d-m-Y', strtotime($order_info['date_added']));

			$data['payment_address'] = array(
				'firstname'    => $order_info['payment_firstname'],
				'lastname'     => $order_info['payment_lastname'],
				'company'      => $order_info['payment_company'],
				'address_1'    => $order_info['payment_address_1'],
				'address_2'    => $order_info['payment_address_2'],
				'city'         => $order_info['payment_city'],
				'postcode'     => $order_info['payment_postcode'],
				'zone'         => $order_info['payment_zone'],
				'zone_code'    => $order_info['payment_zone_code'],
				'country'      => $order_info['payment_country'],
				'telephone'    => $order_info['telephone'],
				'country_code' => $order_info['payment_iso_code_2'],
			);

			$data['payment_method'] = $order_info['payment_method'];

			$data['shipping_address'] = array(
				'firstname'    => $order_info['shipping_firstname'],
				'lastname'     => $order_info['shipping_lastname'],
				'company'      => $order_info['shipping_company'],
				'address_1'    => $order_info['shipping_address_1'],
				'address_2'    => $order_info['shipping_address_2'],
				'city'         => $order_info['shipping_city'],
				'postcode'     => $order_info['shipping_postcode'],
				'zone'         => $order_info['shipping_zone'],
				'zone_code'    => $order_info['shipping_zone_code'],
				'country'      => $order_info['shipping_country'],
				'telephone'    => $order_info['telephone'],
				'country_code' => $order_info['shipping_iso_code_2'],
			);

			$this->load->model('account/transaction');
			$payment         = $this->model_account_transaction->getTransactionsByOrder($order_info['order_id']);
			$data['payment'] = reset($payment);

			$data['shipping_method'] = $order_info['shipping_method'];

			$this->load->model('catalog/product');
			$this->load->model('tool/upload');

			// Products
			$data['products'] = array();

			$products = $this->model_account_order->getOrderProducts($this->request->get['order_id']);

			$colors = array();
			$hilts  = '';

			foreach ($products as $product) {
				$option_data = array();

				$product_option_value_data = array();

				$options = $this->model_account_order->getOrderOptions($this->request->get['order_id'], $product['order_product_id']);

				foreach ($options as $option) {
					if ($option['type'] != 'file') {
						$value = $option['value'];
					} else {
						$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

						if ($upload_info) {
							$value = $upload_info['name'];
						} else {
							$value = '';
						}
					}

					if ($option['name'] == 'Hilt models') {
						$hilts = $option['value'];
					}

					if ($option['name'] == 'Color') {
						$colors[] = $option['value'];
					}
				}

				$product_info = $this->model_catalog_product->getProduct($product['product_id']);

				if ($product_info) {
					$reorder = $this->url->link('account/order/reorder', 'order_id='.$order_id.'&order_product_id='.$product['order_product_id'], true);
				} else {
					$reorder = '';
				}

				$data['products'][] = array(
					'name'     => $product['name'],
					'model'    => $product['model'],
					'sku'      => $product_info['sku'],
					'option'   => $option_data,
					'quantity' => $product['quantity'],
					'hilts'    => $hilts,
					'colors'   => (count($colors) > 1)?count($colors).' colours':reset($colors),
					'price'    => $this->currency->format($product['price']+($this->config->get('config_tax')?$product['tax']:0), $order_info['currency_code'], $order_info['currency_value']),
					'total'    => $this->currency->format($product['total']+($this->config->get('config_tax')?($product['tax']*$product['quantity']):0), $order_info['currency_code'], $order_info['currency_value']),
					'reorder'  => $reorder,
					'return'   => $this->url->link('account/return/add', 'order_id='.$order_info['order_id'].'&product_id='.$product['product_id'], true)
				);
			}

			// Voucher
			$data['vouchers'] = array();

			$vouchers = $this->model_account_order->getOrderVouchers($this->request->get['order_id']);

			foreach ($vouchers as $voucher) {
				$data['vouchers'][] = array(
					'description' => $voucher['description'],
					'amount'      => $this->currency->format($voucher['amount'], $order_info['currency_code'], $order_info['currency_value'])
				);
			}

			// Totals
			$data['totals'] = array();

			$totals              = $this->model_account_order->getOrderTotals($this->request->get['order_id']);
			$data['order_total'] = '';
			foreach ($totals as $total) {
				if ($total['code'] == 'total') {
					$data['order_total'] = $this->currency->format($total['value'], $order_info['currency_code'], $order_info['currency_value']);
				} else {
					$data['totals'][] = array(
						'title' => $total['title'],
						'text'  => $this->currency->format($total['value'], $order_info['currency_code'], $order_info['currency_value']),
					);
				}
			}

			$data['comment'] = nl2br($order_info['comment']);

			// History
			$data['histories'] = array();

			$results = $this->model_account_order->getOrderHistories($this->request->get['order_id']);

			foreach ($results as $result) {
				$data['histories'][] = array(
					'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
					'status'     => $result['status'],
					'comment'    => $result['notify']?nl2br($result['comment']):'',
				);
			}

			$data['continue'] = $this->url->link('account/order', '', true);
			$data['info']     = $this->url->link('account/order/info', 'order_id='.$order_id, true);

			$data['column_left']    = $this->load->controller('common/column_left');
			$data['column_right']   = $this->load->controller('common/column_right');
			$data['content_top']    = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer']         = $this->load->controller('common/footer');
			$data['header']         = $this->load->controller('common/header');

			$this->load->model('tool/image');

			if (is_file(DIR_IMAGE.$this->config->get('config_logo'))) {
				$data['logo'] = 'image/'.$this->config->get('config_logo');
			} else {
				$data['logo'] = '';
			}

			$action = (isset($this->request->get['action']))?$this->request->get['action']:'default';

			$template_path = DIR_TEMPLATE.str_replace('theme_', '', $this->config->get('config_theme')).'/template/account/';
			$template      = 'order_pdf.tpl';

			switch ($action) {
				case 'pdf':
					$dompdf = new Dompdf();
					$dompdf->loadHtml($this->load->view('account/order_pdf', $data));
					$dompdf->setPaper('A4');
					//$dompdf->setBasePath($server);
					$dompdf->set_option('isHtml5ParserEnabled', true);
					$dompdf->render();
					$dompdf->stream($data['name'].'-order-'.$data['order_id'].'-'.date('mdY'), array('Attachment' => 0));
					break;

				case 'download':
					$dompdf = new Dompdf();
					$dompdf->loadHtml($this->load->view('account/order_pdf', $data));
					$dompdf->setPaper('A4');
					//$dompdf->setBasePath($server);
					$dompdf->set_option('isHtml5ParserEnabled', true);
					$dompdf->render();
					$dompdf->stream($data['name'].'-order-'.$data['order_id'].'-'.date('mdY'), array('Attachment' => 1));
					break;

				default:
					$this->response->setOutput($this->load->view('account/order_info', $data));
					break;
			}

		} else {
			$this->document->setTitle($this->language->get('text_order'));

			$data['heading_title'] = $this->language->get('text_order');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

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
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('account/order', '', true)
			);

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_order'),
				'href' => $this->url->link('account/order/info', 'order_id='.$order_id, true)
			);

			$data['continue'] = $this->url->link('account/order', '', true);

			$data['column_left']    = $this->load->controller('common/column_left');
			$data['column_right']   = $this->load->controller('common/column_right');
			$data['content_top']    = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer']         = $this->load->controller('common/footer');
			$data['header']         = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}

	public function reorder() {
		$this->load->language('account/order');

		if (isset($this->request->get['order_id'])) {
			$order_id = $this->request->get['order_id'];
		} else {
			$order_id = 0;
		}

		$this->load->model('account/order');

		$order_info = $this->model_account_order->getOrder($order_id);

		if ($order_info) {
			if (isset($this->request->get['order_product_id'])) {
				$order_product_id = $this->request->get['order_product_id'];
			} else {
				$order_product_id = 0;
			}

			$order_product_info = $this->model_account_order->getOrderProduct($order_id, $order_product_id);

			if ($order_product_info) {
				$this->load->model('catalog/product');

				$product_info = $this->model_catalog_product->getProduct($order_product_info['product_id']);

				if ($product_info) {
					$option_data = array();

					$order_options = $this->model_account_order->getOrderOptions($order_product_info['order_id'], $order_product_id);

					foreach ($order_options as $order_option) {
						if ($order_option['type'] == 'select' || $order_option['type'] == 'radio' || $order_option['type'] == 'image') {
							$option_data[$order_option['product_option_id']] = $order_option['product_option_value_id'];
						} elseif ($order_option['type'] == 'checkbox') {
							$option_data[$order_option['product_option_id']][] = $order_option['product_option_value_id'];
						} elseif ($order_option['type'] == 'text' || $order_option['type'] == 'textarea' || $order_option['type'] == 'date' || $order_option['type'] == 'datetime' || $order_option['type'] == 'time') {
							$option_data[$order_option['product_option_id']] = $order_option['value'];
						} elseif ($order_option['type'] == 'file') {
							$option_data[$order_option['product_option_id']] = $this->encryption->encrypt($order_option['value']);
						}
					}

					$this->cart->add($order_product_info['product_id'], $order_product_info['quantity'], $option_data);

					$this->session->data['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id='.$product_info['product_id']), $product_info['name'], $this->url->link('checkout/cart'));

					unset($this->session->data['shipping_method']);
					unset($this->session->data['shipping_methods']);
					unset($this->session->data['payment_method']);
					unset($this->session->data['payment_methods']);
				} else {
					$this->session->data['error'] = sprintf($this->language->get('error_reorder'), $order_product_info['name']);
				}
			}
		}

		$this->response->redirect($this->url->link('account/order/info', 'order_id='.$order_id));
	}

	public function reorderall() {
		$this->load->language('account/order');

		if (isset($this->request->get['order_id'])) {
			$order_id = $this->request->get['order_id'];
		} else {
			$order_id = 0;
		}

		$this->load->model('account/order');

		$order_info = $this->model_account_order->getOrder($order_id);

		if ($order_info) {
			if (isset($this->request->get['order_product_id'])) {
				$order_product_id = $this->request->get['order_product_id'];
			} else {
				$order_product_id = 0;
			}

			$order_product_info = $this->model_account_order->getOrderProducts($order_id);

			foreach ($order_product_info as $order_product) {
				if ($order_product_info) {
					$this->load->model('catalog/product');

					$product_info = $this->model_catalog_product->getProduct($order_product['product_id']);

					if ($product_info) {
						$option_data = array();

						$order_options = $this->model_account_order->getOrderOptions($order_product['order_id'], $order_product['order_product_id']);
						foreach ($order_options as $order_option) {
							if ($order_option['type'] == 'select' || $order_option['type'] == 'radio' || $order_option['type'] == 'image') {
								$option_data[$order_option['product_option_id']] = $order_option['product_option_value_id'];
							} elseif ($order_option['type'] == 'checkbox') {
								$option_data[$order_option['product_option_id']][] = $order_option['product_option_value_id'];
							} elseif ($order_option['type'] == 'text' || $order_option['type'] == 'textarea' || $order_option['type'] == 'date' || $order_option['type'] == 'datetime' || $order_option['type'] == 'time') {
								$option_data[$order_option['product_option_id']] = $order_option['value'];
							} elseif ($order_option['type'] == 'file') {
								$option_data[$order_option['product_option_id']] = $this->encryption->encrypt($order_option['value']);
							}
						}

						$this->cart->add($order_product['product_id'], $order_product['quantity'], $option_data);

						//$this->session->data['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $product_info['product_id']), $product_info['name'], $this->url->link('checkout/cart'));

						unset($this->session->data['shipping_method']);
						unset($this->session->data['shipping_methods']);
						unset($this->session->data['payment_method']);
						unset($this->session->data['payment_methods']);
					} else {
						$this->session->data['error'] = sprintf($this->language->get('error_reorder'), $order_product_info['name']);
					}
				}
			}
		}
		$this->response->redirect($this->url->link('checkout/cart'));
	}

	public function ajax_load_payment() {
		if (isset($_POST['payment_code']) && !empty($_POST['payment_code'])) {
			$code = $_POST['payment_code'];
			if ($code == 'pp_express') {

			} else {
				$data['payment'] = $this->load->controller('extension/payment/'.$code);
				$this->response->setOutput($this->load->view('checkout/confirm', $data));
			}
		}
	}

	public function ajax_pay_now() {
		$json = array();
		if (isset($_POST['order_id']) && !empty($_POST['order_id']) && isset($_POST['payment_name']) && !empty($_POST['payment_name'])) {
			$order_id     = $_POST['order_id'];
			$payment_name = $_POST['payment_name'];

			$this->load->model('account/order');
			if ($this->model_account_order->update_order_payment_method($order_id, $payment_name)) {
				$json['message'] = 'Success';
			} else {
				$json['message'] = 'Fail';
			}

			$this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_encode($json));
		}
	}

	public function submit_bank_transfer_details() {

		$this->load->model('tool/image');

		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		$json = array();

		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
			$order_id = $this->request->post['bank_transfer_order_id'];
			$message  = html_entity_decode($this->request->post['text'], ENT_QUOTES, 'UTF-8');
			$message  = strip_tags($message);
			$subject  = 'Bank transfer details for order #'.$order_id;

			$customer_name = $this->customer->getFirstName().' '.$this->customer->getLastName();
			$email         = $this->customer->getEmail();

			$files = array();

			if (!empty($this->request->post['files'])) {
				foreach ($this->request->post['files'] as $file) {
					$_file = html_entity_decode(((isset($file))?$file:''), ENT_QUOTES, 'UTF-8');
					if (!empty($_file) && file_exists(DIR_IMAGE.$_file) && is_file(DIR_IMAGE.$_file)) {
						$files[] = $_file;
					}
				}
			}

			$text = html_entity_decode($this->config->get('config_review_mail'), ENT_QUOTES, 'UTF-8');

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

			$json['success'] = 1;
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));

	}

}