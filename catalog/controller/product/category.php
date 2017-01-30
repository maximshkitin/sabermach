<?php
class ControllerProductCategory extends Controller {
	public function index() {
		$this->load->language('product/category');

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$data['register_link'] = $this->url->link('account/register', '', true);
		$data['account_link']  = $this->url->link('account/account', '', true);

		$data['providers'] = array();

		$social_logins = $this->config->get('hybrid_auth');
		if (!empty($social_logins)) {
			foreach ($social_logins as $config) {
				if ((bool) $config['enabled']) {
					$data['providers'][$config['provider']] = $this->url->link('hybrid/auth', 'provider='.$config['provider'], true);
				}
			}
		}

		$data['is_logged'] = $this->customer->isLogged();

		if (isset($this->request->get['filter'])) {
			$filter = $this->request->get['filter'];
		} else {
			$filter = '';
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.sort_order';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['limit'])) {
			$limit = (int) $this->request->get['limit'];
		} else {
			$limit = $this->config->get($this->config->get('config_theme').'_product_limit');
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		if (isset($this->request->get['path'])) {
			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort='.$this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order='.$this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit='.$this->request->get['limit'];
			}

			$path = '';

			$parts = explode('_', (string) $this->request->get['path']);

			$category_id = (int) array_pop($parts);

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = (int) $path_id;
				} else {
					$path .= '_'.(int) $path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],
						'href' => $this->url->link('product/category', 'path='.$path.$url)
					);
				}
			}
		} else {
			$category_id = 0;
		}

		$category_info = $this->model_catalog_category->getCategory($category_id);

		if (isset($this->session->data['form_message'])) {
			$data['form_message'] = $this->session->data['form_message'];
			unset($this->session->data['form_message']);
		} else {
			$data['form_message'] = '';
		}

		if ($category_info) {
			$this->document->setTitle($category_info['meta_title']);
			$this->document->setDescription($category_info['meta_description']);
			$this->document->setKeywords($category_info['meta_keyword']);

			$data['heading_title'] = $category_info['name'];

			$data['text_refine']       = $this->language->get('text_refine');
			$data['text_empty']        = $this->language->get('text_empty');
			$data['text_quantity']     = $this->language->get('text_quantity');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model']        = $this->language->get('text_model');
			$data['text_price']        = $this->language->get('text_price');
			$data['text_tax']          = $this->language->get('text_tax');
			$data['text_points']       = $this->language->get('text_points');
			$data['text_compare']      = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare'])?count($this->session->data['compare']):0));
			$data['text_sort']         = $this->language->get('text_sort');
			$data['text_limit']        = $this->language->get('text_limit');

			$data['button_cart']     = $this->language->get('button_cart');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare']  = $this->language->get('button_compare');
			$data['button_continue'] = $this->language->get('button_continue');
			$data['button_list']     = $this->language->get('button_list');
			$data['button_grid']     = $this->language->get('button_grid');

			// Set the last category breadcrumb
			$data['breadcrumbs'][] = array(
				'text' => $category_info['name'],
				'href' => $this->url->link('product/category', 'path='.$this->request->get['path'])
			);

			if ($category_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get($this->config->get('config_theme').'_image_category_width'), $this->config->get($this->config->get('config_theme').'_image_category_height'));
			} else {
				$data['thumb'] = '';
			}

			$data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');
			$data['compare']     = $this->url->link('product/compare');

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter='.$this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort='.$this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order='.$this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit='.$this->request->get['limit'];
			}

			$data['name']       = $this->config->get('config_name');
			$data['help_email'] = $this->config->get('config_help_email');
			$data['help_phone'] = $this->config->get('config_help_phone');

			$data['categories'] = array();

			$results = $this->model_catalog_category->getCategories($category_id);

			foreach ($results as $result) {
				$filter_data = array(
					'filter_category_id'  => $result['category_id'],
					'filter_sub_category' => true
				);

				$data['categories'][] = array(
					'name' => $result['name'].($this->config->get('config_product_count')?' ('.$this->model_catalog_product->getTotalProducts($filter_data).')':''),
					'href' => $this->url->link('product/category', 'path='.$this->request->get['path'].'_'.$result['category_id'].$url)
				);
			}

			$data['products'] = array();

			$filter_data = array(
				'filter_category_id' => $category_id,
				'filter_filter'      => $filter,
				'sort'               => $sort,
				'order'              => $order,
				'start'              => ($page-1)*$limit,
				'limit'              => $limit
			);

			$product_total = $this->model_catalog_product->getTotalProducts($filter_data);

			$results = $this->model_catalog_product->getProducts($filter_data);

			$replace = array();

			$right_symbol = $this->currency->getSymbolRight($this->session->data['currency']);
			if (!empty($right_symbol)) {
				$replace[] = $right_symbol;
			}

			$left_symbol = $this->currency->getSymbolLeft($this->session->data['currency']);
			if (!empty($left_symbol)) {
				$replace[] = $left_symbol;
			}

			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme').'_image_product_width'), $this->config->get($this->config->get('config_theme').'_image_product_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme').'_image_product_width'), $this->config->get($this->config->get('config_theme').'_image_product_height'));
				}

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$price = false;
				}

				if ((float) $result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$special = false;
				}

				$data['currency'] = $this->session->data['currency'];

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float) $result['special']?$result['special']:$result['price'], $this->session->data['currency']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = (int) $result['rating'];
				} else {
					$rating = false;
				}

				$product_name = explode(' ', $result['name']);
				$name         = array();
				if (!empty($product_name)) {
					foreach ($product_name as $key => $text) {
						if ($key == 0) {
							$name[] = $text;
						} elseif ($key == 1) {
							if (preg_match('/^\d+$/', $text) && isset($product_name[$key+1])) {
								$_text = array_slice($product_name, $key+1);
								$name[0] .= ' '.$text;
							} else {
								$_text = array_slice($product_name, $key);
							}
							$name[] = implode(' ', $_text);
							break;
						}
					}
				}

				$colors = array();
				$hilts  = array();
				foreach ($this->model_catalog_product->getProductOptions($result['product_id']) as $option) {
					$product_option_value_data = array();

					foreach ($option['product_option_value'] as $option_value) {
						if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
							if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float) $option_value['price']) {
								$_price = $this->currency->format($this->tax->calculate($option_value['price'], $result['tax_class_id'], $this->config->get('config_tax')?'P':false), $this->session->data['currency']);
							} else {
								$_price = false;
							}

							if ($option['option_id'] == 13) {
								if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
								   $base_url = $this->config->get('config_ssl');
								} else {
								   $base_url = $this->config->get('config_url');
								}
								$product_option_value_data[] = array(
									'product_option_value_id' => $option_value['product_option_value_id'],
									'option_value_id'         => $option_value['option_value_id'],
									'name'                    => $option_value['name'],
									'image'                   => $this->model_tool_image->resize($option_value['image'], 75, 75),
									// 'big_image'               => $this->model_tool_image->resize($option_value['big_image'], 48, 191),
									'big_image'               => $base_url.'image/'.$option_value['big_image'],
									'price'                   => $_price,
									'price_prefix'            => $option_value['price_prefix'],
								);
							}

							if ($option['option_id'] == 14) {
								$product_option_value_data[] = array(
									'product_option_value_id' => $option_value['product_option_value_id'],
									'option_value_id'         => $option_value['option_value_id'],
									'name'                    => $option_value['name'],
									'image'                   => $this->model_tool_image->resize($option_value['image'], 226, 179),
									'big_image'               => $this->model_tool_image->resize($option_value['big_image'], 45, 458),
									'price'                   => $_price,
									'price_prefix'            => $option_value['price_prefix'],
								);
							}
						}
					}

					if ($option['option_id'] == 14) {
						$colors[] = array(
							'product_option_id'    => $option['product_option_id'],
							'product_option_value' => $product_option_value_data,
							'option_id'            => $option['option_id'],
							'name'                 => $option['name'],
							'type'                 => $option['type'],
							'value'                => $option['value'],
							'required'             => $option['required'],
						);
					}

					if ($option['option_id'] == 13) {
						$hilts[] = array(
							'product_option_id'    => $option['product_option_id'],
							'product_option_value' => $product_option_value_data,
							'option_id'            => $option['option_id'],
							'name'                 => $option['name'],
							'type'                 => $option['type'],
							'value'                => $option['value'],
							'required'             => $option['required'],
						);
					}
				}

				$attributes = $this->model_catalog_product->getProductAttributes($result['product_id']);

				$_data       = array();
				$_data_color = 0;
				$_data_sound = 0;

				if (!empty($attributes)) {
					foreach ($attributes as $group) {
						if ($group['attribute_group_id'] == 8) {
							if (!empty($group['attribute'])) {
								foreach ($group['attribute'] as $item) {
									$text = html_entity_decode($item['text'], ENT_QUOTES, 'UTF-8');
									$text = explode("\n", $text);
									if ($item['attribute_id'] == 23) {
										$_data_sound = (int) $item['text'];
									} else if ($item['attribute_id'] == 24) {
										$_data_color = (int) $item['text'];
									} else {
										$_data[(int) $item['attribute_id']] = $text;
									}
								}
							}
							break;
						}
					}
				}

				$data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $name,
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme').'_product_description_length')).'..',
					'price'       => str_replace($replace, '', $price),
					'special'     => str_replace($replace, '', $special),
					'tax'         => $tax,
					'minimum'     => $result['minimum'] > 0?$result['minimum']:1,
					'rating'      => $result['rating'],
					'hilts'       => reset($hilts),
					'colors'      => reset($colors),
					'data'        => $_data,
					'data_color'  => $_data_color,
					'data_sound'  => $_data_sound,
					'href'        => $this->url->link('product/product', 'path='.$this->request->get['path'].'&product_id='.$result['product_id'].$url)
				);
			}

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter='.$this->request->get['filter'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit='.$this->request->get['limit'];
			}

			$data['sorts'] = array();

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_default'),
				'value' => 'p.sort_order-ASC',
				'href'  => $this->url->link('product/category', 'path='.$this->request->get['path'].'&sort=p.sort_order&order=ASC'.$url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_asc'),
				'value' => 'pd.name-ASC',
				'href'  => $this->url->link('product/category', 'path='.$this->request->get['path'].'&sort=pd.name&order=ASC'.$url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_desc'),
				'value' => 'pd.name-DESC',
				'href'  => $this->url->link('product/category', 'path='.$this->request->get['path'].'&sort=pd.name&order=DESC'.$url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href'  => $this->url->link('product/category', 'path='.$this->request->get['path'].'&sort=p.price&order=ASC'.$url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_desc'),
				'value' => 'p.price-DESC',
				'href'  => $this->url->link('product/category', 'path='.$this->request->get['path'].'&sort=p.price&order=DESC'.$url)
			);

			if ($this->config->get('config_review_status')) {
				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_desc'),
					'value' => 'rating-DESC',
					'href'  => $this->url->link('product/category', 'path='.$this->request->get['path'].'&sort=rating&order=DESC'.$url)
				);

				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_asc'),
					'value' => 'rating-ASC',
					'href'  => $this->url->link('product/category', 'path='.$this->request->get['path'].'&sort=rating&order=ASC'.$url)
				);
			}

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_asc'),
				'value' => 'p.model-ASC',
				'href'  => $this->url->link('product/category', 'path='.$this->request->get['path'].'&sort=p.model&order=ASC'.$url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_desc'),
				'value' => 'p.model-DESC',
				'href'  => $this->url->link('product/category', 'path='.$this->request->get['path'].'&sort=p.model&order=DESC'.$url)
			);

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter='.$this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort='.$this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order='.$this->request->get['order'];
			}

			$data['limits'] = array();

			$limits = array_unique(array($this->config->get($this->config->get('config_theme').'_product_limit'), 25, 50, 75, 100));

			sort($limits);

			foreach ($limits as $value) {
				$data['limits'][] = array(
					'text'  => $value,
					'value' => $value,
					'href'  => $this->url->link('product/category', 'path='.$this->request->get['path'].$url.'&limit='.$value)
				);
			}

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter='.$this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort='.$this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order='.$this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit='.$this->request->get['limit'];
			}

			$pagination        = new Pagination();
			$pagination->total = $product_total;
			$pagination->page  = $page;
			$pagination->limit = $limit;
			$pagination->url   = $this->url->link('product/category', 'path='.$this->request->get['path'].$url.'&page={page}');

			$data['pagination'] = $pagination->render();

			$data['results'] = sprintf($this->language->get('text_pagination'), ($product_total)?(($page-1)*$limit)+1:0, ((($page-1)*$limit) > ($product_total-$limit))?$product_total:((($page-1)*$limit)+$limit), $product_total, ceil($product_total/$limit));

			// http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html
			if ($page == 1) {
				$this->document->addLink($this->url->link('product/category', 'path='.$category_info['category_id'], true), 'canonical');
			} elseif ($page == 2) {
				$this->document->addLink($this->url->link('product/category', 'path='.$category_info['category_id'], true), 'prev');
			} else {
				$this->document->addLink($this->url->link('product/category', 'path='.$category_info['category_id'].'&page='.($page-1), true), 'prev');
			}

			if ($limit && ceil($product_total/$limit) > $page) {
				$this->document->addLink($this->url->link('product/category', 'path='.$category_info['category_id'].'&page='.($page+1), true), 'next');
			}

			$data['sort']  = $sort;
			$data['order'] = $order;
			$data['limit'] = $limit;

			$data['continue'] = $this->url->link('common/home');

			$data['column_left']    = $this->load->controller('common/column_left');
			$data['column_right']   = $this->load->controller('common/column_right');
			$data['content_top']    = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer']         = $this->load->controller('common/footer');
			$data['header']         = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('product/category', $data));
		} else {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path='.$this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter='.$this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort='.$this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order='.$this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page='.$this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit='.$this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('product/category', $url)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'].' 404 Not Found');

			$data['column_left']    = $this->load->controller('common/column_left');
			$data['column_right']   = $this->load->controller('common/column_right');
			$data['content_top']    = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer']         = $this->load->controller('common/footer');
			$data['header']         = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}
}
