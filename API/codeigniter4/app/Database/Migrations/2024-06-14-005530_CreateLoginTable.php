<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class CreateLoginTable extends Migration
{
    public function up()
    {
        $this->forge->addField([
            'id_pengguna' => [
                'type'           => 'INT',
                'auto_increment' => true,
            ],
            'email' => [
                'type'       => 'VARCHAR',
                'constraint' => '50',
                'unique'     => true,
            ],
            'password' => [
                'type' => 'VARCHAR',
                'constraint' => '50',
            ],
        ]);

        $this->forge->addKey('id_pengguna', true);
        $this->forge->addKey('email', true);
        $this->forge->createTable('login');
    }

    public function down()
    {
        $this->forge->dropTable('login');
    }
}
