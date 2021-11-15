<?= $this->extend('layout/template'); ?>

<?= $this->section('content'); ?>
<?= $this->include('layout/sidebar'); ?>
<div class="main">
    <?= $this->include('layout/navbar'); ?>
    <!-- Content -->
    <div class="container">
        <div class="container my-5 ms-auto bg-white p-3">
            <div class="row">
                <div class="col">
                    <h1>Data User</h1>
                </div>
                <div class="col d-flex justify-content-end">
                    <button class="btn btn-col m-1">
                        <img src="https://img.icons8.com/ios-glyphs/25/ffffff/add.png" />
                        <a href="/user/create" class="text-decoration-none text-white">
                            Tambah
                        </a>
                    </button>
                </div>
            </div>

            <!-- Table -->
            <table class="table table-striped  align-middle">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col"></th>
                        <th scope="col">Nama</th>
                        <th scope="col">Username</th>
                        <th scope="col">Level</th>
                        <th scope="col">Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <?php $i = 1; ?>
                    <?php foreach ($user as $s) : ?>
                        <tr>
                            <th scope="row"><?= $i++; ?></th>
                            <td>
                                <img src="/img/nana.jpg" class="img-user" alt="...">
                            </td>
                            <td><?= $s['nama']; ?></td>
                            <td><?= $s['username']; ?></td>
                            <td><?= $s['level']; ?></td>
                            <td>
                                <button class="btn btn-sm">
                                    <img src="https://img.icons8.com/ios-glyphs/15/000000/pencil--v1.png" />
                                </button>
                                <button class="btn btn-sm">
                                    <img src="https://img.icons8.com/ios-glyphs/15/000000/trash--v1.png" />
                                </button>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>
<?= $this->endSection(); ?>