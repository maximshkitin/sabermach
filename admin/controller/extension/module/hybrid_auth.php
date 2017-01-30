<?php

/**
 * @category   OpenCart
 * @package    OCU HybridAuth
 * @copyright  Copyright (c) 2011 Eugene Lifescale by OpenCart Ukrainian Community (http://opencart-ukraine.tumblr.com)
 */

class ControllerExtensionModuleHybridAuth extends Controller {

    // Presets
    private $error = array();

    public function index() {

        // Load Dependencies
        $this->load->language('extension/module/hybrid_auth');
        $this->load->model('setting/setting');

        // Save Incoming Data
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            
            // Prepare Sort Order
            if (isset($this->request->post['hybrid_auth'])) {
                $sort_order = array();

                foreach ($this->request->post['hybrid_auth'] as $key => $value) {
                    $sort_order[$key] = $value['sort_order'];
                }

                array_multisort($sort_order, SORT_ASC, $this->request->post['hybrid_auth']);
            }
            
            // Edit Settings
            $this->model_setting_setting->editSetting('hybrid_auth', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'], true));
        }

        // Language Init
        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_copyright'] = sprintf($this->language->get('text_copyright'), date('Y'));

        $data['entry_status'] = $this->language->get('entry_status');
        $data['entry_debug'] = $this->language->get('entry_debug');

        $data['entry_provider'] = $this->language->get('entry_provider');
        $data['entry_key'] = $this->language->get('entry_key');
        $data['entry_secret'] = $this->language->get('entry_secret');
        $data['entry_scope'] = $this->language->get('entry_scope');
        $data['entry_sort_order'] = $this->language->get('entry_sort_order');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        $data['button_add_row'] = $this->language->get('button_add_row');
        $data['button_remove'] = $this->language->get('button_remove');

        // Process Errors
         if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        // Generate Breadcrumbs
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], true),
            'separator' => false
        );

        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_module'),
            'href'      => $this->url->link('extension/extension', 'token=' . $this->session->data['token'], true),
            'separator' => ' :: '
        );

        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('extension/module/hybrid_auth', 'token=' . $this->session->data['token'], true),
            'separator' => ' :: '
        );

        // Set Page Title
        $this->document->setTitle($this->language->get('heading_title'));

        // Load Providers
        $data['providers'] = array();

        if (is_dir(DIR_SYSTEM . '/library/Hybrid/Providers')) {
            $providers = scandir(DIR_SYSTEM . '/library/Hybrid/Providers');

            if (count($providers)) {
                foreach ($providers as $provider) {
                    if ($provider != '.' && $provider != '..') {
                        $data['providers'][] = str_replace('.php', '', $provider);
                    }
                }
            }
        }

        // Basic Variables
        $data['action'] = $this->url->link('extension/module/hybrid_auth', 'token=' . $this->session->data['token'], true);
        $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], true);

        // Process Variables
        if (isset($this->request->post['hybrid_auth'])) {
            $data['hybrid_auth_items'] = $this->request->post['hybrid_auth'];
        } elseif ($this->config->get('hybrid_auth')) {
            $data['hybrid_auth_items'] = $this->config->get('hybrid_auth');
        } else {
            $data['hybrid_auth_items'] = array();
        }

        if (isset($this->request->post['hybrid_auth_debug'])) {
            $data['hybrid_auth_debug'] = $this->request->post['hybrid_auth_debug'];
        } elseif ($this->config->get('hybrid_auth_debug')) {
            $data['hybrid_auth_debug'] = $this->config->get('hybrid_auth_debug');
        } else {
            $data['hybrid_auth_debug'] = 0;
        }

        if (isset($this->request->post['hybrid_auth_status'])) {
            $data['hybrid_auth_status'] = $this->request->post['hybrid_auth_status'];
        } elseif ($this->config->get('hybrid_auth_status')) {
            $data['hybrid_auth_status'] = $this->config->get('hybrid_auth_status');
        } else {
            $data['hybrid_auth_status'] = 0;
        }

        $data['text_edit'] = 'Editing';

        // Load Template
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        // Rendering
        $this->response->setOutput($this->load->view('extension/module/hybrid_auth.tpl', $data));
    }

    private function validate() {
        // Check Permissions
        if (!$this->user->hasPermission('modify', 'extension/module/hybrid_auth')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    public function install() {
        $this->load->model('extension/module/hybrid_auth');
        $this->model_module_hybrid_auth->createTable();
    }

    public function uninstall() {
        $this->load->model('extension/module/hybrid_auth');
        $this->model_module_hybrid_auth->dropTable();
        $this->load->model('setting/setting');
        $this->model_setting_setting->deleteSetting('hybrid_auth');
    }
}
