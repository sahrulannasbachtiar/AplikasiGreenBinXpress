<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');
$routes->get('sampah', 'Sampah::index');
$routes->get('sampah/(:segment)', 'Sampah::show/$1');
$routes->post('sampah/create', 'Sampah::create');
$routes->post('sampah/edit/(:segment)', 'Sampah::update/$1');
$routes->delete('sampah/(:segment)', 'Sampah::delete/$1');

$routes->group('auth', function($routes) {
    $routes->post('register', 'AuthController::register');
    $routes->post('login', 'AuthController::login');
});