<?php
class ControllerBlogPost extends Controller {
	public function index() {
		$this->load->language('blog/post');

		$this->load->model('blog/post');

		$this->load->model('blog/category');

		$this->load->model('catalog/product');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_blog'),
			'href' => $this->url->link('blog/category')
		);

		if (isset($this->request->get['blog_post_id'])) {
			$data['blog_post_id'] = $blog_post_id = (int)$this->request->get['blog_post_id'];
		} else {
			$data['blog_post_id'] = $blog_post_id = 0;
		}

		$post_info = $this->model_blog_post->getPost($blog_post_id);

		if ($post_info) {

			$this->document->setTitle($post_info['meta_title']);
			$this->document->setDescription($post_info['meta_description']);
			$this->document->setKeywords($post_info['meta_keyword']);

			$data['breadcrumbs'][] = array(
				'text' => $post_info['title'],
				'href' => $this->url->link('blog/post', 'blog_post_id=' .  $blog_post_id)
			);

			$data['heading_title'] = $post_info['title'];

			$data['button_continue'] = $this->language->get('button_continue');

			$data['description'] = html_entity_decode($post_info['description'], ENT_QUOTES, 'UTF-8');


			$data['text_write'] = $this->language->get('text_write');
			$data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));
			$data['text_note'] = $this->language->get('text_note');
			$data['text_loading'] = $this->language->get('text_loading');
			$data['help_email'] = $this->language->get('help_email');
			$data['text_posted_by'] = sprintf($this->language->get('text_posted_by'),ucwords($post_info['author']),date($this->language->get('date_format_long'), strtotime($post_info['date_added'])));
			$data['text_tags'] = $this->language->get('text_tags');
			
			$data['entry_name'] = $this->language->get('entry_name');
			$data['entry_email'] = $this->language->get('entry_email');
			$data['entry_comment'] = $this->language->get('entry_comment');

			$data['likes'] = $post_info['likes'];
			$data['dislikes'] = $post_info['dislikes'];

			$next = $this->model_blog_post->getNextPost($data['blog_post_id']);
			if(!empty($next)) {
				$data['next'] = $this->url->link('blog/post', 'blog_post_id=' . $next['blog_post_id']);
			} else {
				$data['next'] = false;
			}

			$prev = $this->model_blog_post->getPrevPost($data['blog_post_id']);
			if(!empty($prev)) {
				$data['prev'] = $this->url->link('blog/post', 'blog_post_id=' . $prev['blog_post_id']);
			} else {
				$data['prev'] = false;
			}

			$categories = $this->model_blog_category->getCategoriesByPostId($data['blog_post_id']);

			if(!empty($categories)) {
				foreach ($categories as $category) {
					$data['categories'][] = $category['name'];
				}
			} else {
				$data['categories'] = false;
			}

			$data['name'] = $this->config->get('config_name');
			$data['help_email'] = $this->config->get('config_help_email');
			$data['help_phone'] = $this->config->get('config_help_phone');

			$data['author'] = ucwords($post_info['author']);
			$data['updated'] = date('F n, Y g:h A', strtotime($post_info['date_modified']));

			$data['continue'] = $this->url->link('common/home');

			/*if ($this->config->get('config_google_captcha_status')) {
				$this->document->addScript('https://www.google.com/recaptcha/api.js');

				$data['site_key'] = $this->config->get('config_google_captcha_public');
			} else {
				$data['site_key'] = '';
			}

			$data['tags'] = array();

			if ($post_info['tag']) {
				$tags = explode(',', $post_info['tag']);

				foreach ($tags as $tag) {
					$data['tags'][] = array(
						'tag'  => trim($tag),
						'href' => $this->url->link('blog/category', 'filter_title=' . trim($tag))
					);
				}
			}*/
			if (!isset($this->request->cookie['knowledge-base-'.$data['blog_post_id']])) {
				$data['voted'] = false;
			} else {
				$data['voted'] = true;
			}

			if(isset($this->session->data['guest'])) {
				if(isset($this->session->data['guest']['firstname'])) {
					$data['firstname'] = $this->session->data['guest']['firstname'];
				} else {
					$data['firstname'] = '';
				}

				if(isset($this->session->data['guest']['lastname'])) {
					$data['lastname'] = $this->session->data['guest']['lastname'];
				} else {
					$data['lastname'] = '';
				}

				if(isset($this->session->data['guest']['email'])) {
					$data['email'] = $this->session->data['guest']['email'];
				} else {
					$data['email'] = '';
				}

				if(isset($this->session->data['guest']['telephone'])) {
					$data['telephone'] = $this->session->data['guest']['telephone'];
				} else {
					$data['telephone'] = '';
				}
				
			} else {
				$data['firstname'] = '';
				$data['lastname'] = '';
				$data['email'] = '';
				$data['telephone'] = '';
			}

			$data['products'] = array();
			$filter_data = array();
			$products = $this->model_catalog_product->getProducts($filter_data);

			if(!empty($products)) {
				foreach ($products as $product) {
					$data['products'][] = $product['name'];
				}
			}

			$data['knb'] = $this->url->link('blog/category', '');

			$subjects = $this->config->get('config_kb_subjects');
			$subjects = str_replace(array("\n\r", "\r\n"), "\n", $subjects);
			$data['subjects'] = explode("\n", $subjects);

			$data['action'] = $this->url->link('information/contact/feedback', '', true);

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if(isset($this->session->data['kb_form_message'])) {
				$data['form_message'] = $this->session->data['kb_form_message'];
				unset($this->session->data['kb_form_message']);
			} else {
				$data['form_message'] = '';
			}

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/blog/post.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/blog/post.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('blog/post.tpl', $data));
			}
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('blog/post', 'blog_post_id=' . $blog_post_id)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/error/not_found.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/error/not_found.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('error/not_found.tpl', $data));
			}
		}
	}

	public function comment() {
		$this->load->language('blog/post');

		$this->load->model('blog/comment');

		$data['text_comment'] = $this->language->get('text_comment');
		$data['text_no_comments'] = $this->language->get('text_no_comments');//


		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$data['comments'] = array();

		$comment_total = $this->model_blog_comment->getTotalCommentsByPostId($this->request->get['blog_post_id']);

		$results = $this->model_blog_comment->getCommentsByPostId($this->request->get['blog_post_id'], ($page - 1) * 5, 5);

		foreach ($results as $result) {
			$data['comments'][] = array(
				'author'     => $result['author'],
				'text'       => nl2br($result['text']),				
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
			);
		}

		$pagination = new Pagination();
		$pagination->total = $comment_total;
		$pagination->page = $page;
		$pagination->limit = 5;
		$pagination->url = $this->url->link('blog/post/comment', 'blog_post_id=' . $this->request->get['blog_post_id'] . '&page={page}');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($comment_total) ? (($page - 1) * 5) + 1 : 0, ((($page - 1) * 5) > ($comment_total - 5)) ? $comment_total : ((($page - 1) * 5) + 5), $comment_total, ceil($comment_total / 5));

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/blog/comment.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/blog/comment.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('blog/comment.tpl', $data));
		}
	}

	public function like() {
		$json = array();
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			$this->load->model('blog/post');
			if (!isset($this->request->cookie['knowledge-base-'.$this->request->get['post_id']])) {
				$result = $this->model_blog_post->addLike($this->request->get['post_id']);
			} else {
				$result = false;
				$json['error'] = 2;
			}

			if($result && !isset($json['error'])) {
				$json['success'] = $result;
				setcookie('knowledge-base-'.$this->request->get['post_id'], 1, time() + 60 * 60 * 24 * 30, '/', $this->request->server['HTTP_HOST']);
			} else {
				if(!isset($json['error'])) {
					$json['error'] = 1;
				}
			}

			$this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_encode($json));
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('blog/post', 'blog_post_id=' . $blog_post_id)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/error/not_found.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/error/not_found.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('error/not_found.tpl', $data));
			}
		}
	}

	public function dislike() {
		$json = array();
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			$this->load->model('blog/post');

			if (!isset($this->request->cookie['knowledge-base-'.$this->request->get['post_id']])) {
				$result = $this->model_blog_post->addDislike($this->request->get['post_id']);
			} else {
				$result = false;
				$json['error'] = 2;
			}

			if($result && !isset($json['error'])) {
				$json['success'] = $result;
				setcookie('knowledge-base-'.$this->request->get['post_id'], 1, time() + 60 * 60 * 24 * 30, '/', $this->request->server['HTTP_HOST']);
			} else {
				if(!isset($json['error'])) {
					$json['error'] = 1;
				}
			}

			$this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_encode($json));
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('blog/post', 'blog_post_id=' . $blog_post_id)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/error/not_found.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/error/not_found.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('error/not_found.tpl', $data));
			}
		}
	}

	public function write() {
		$this->load->language('blog/post');

		$json = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
				$json['error'] = $this->language->get('error_name');
			}

			if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
				$json['error'] = $this->language->get('error_text');
			}

			if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
				$json['error'] = $this->language->get('error_email');
			}

			if ($this->config->get('config_google_captcha_status')) {
				$recaptcha = file_get_contents('https://www.google.com/recaptcha/api/siteverify?secret=' . urlencode($this->config->get('config_google_captcha_secret')) . '&response=' . $this->request->post['g-recaptcha-response'] . '&remoteip=' . $this->request->server['REMOTE_ADDR']);

				$recaptcha = json_decode($recaptcha, true);

				if (!$recaptcha['success']) {
					$json['error'] = $this->language->get('error_captcha');
				}
			}

			if (!isset($json['error'])) {
				$this->load->model('blog/comment');

				$this->model_blog_comment->addComment($this->request->get['blog_post_id'], $this->request->post);

				$json['success'] = $this->language->get('text_success');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

}