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
                    <h1 class="fw-bold">Data User</h1>
                </div>
                <div class="col d-flex justify-content-end">
                    <button class="btn btn-col m-1" type="button">
                        <img src="https://img.icons8.com/ios-glyphs/25/ffffff/add.png" />
                        <a href="/user/create" class="text-decoration-none text-white">
                            Tambah
                        </a>
                    </button>
                </div>
            </div>
            <div class="row">
                <?php if (session()->getFlashdata()) : ?>
                    <div class="alert alert-warning" role="alert">
                        <?= session()->getFlashdata('pesan'); ?>
                    </div>
                <?php endif; ?>
            </div>

            <!-- Table -->
            <table class="table table-striped  align-middle">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Foto</th>
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
                                <img src="/img/<?= $s['foto_profil']; ?>" class="img-user" alt="...">
                            </td>
                            <td><?= $s['nama']; ?></td>
                            <td><?= $s['username']; ?></td>
                            <td><?= $s['level']; ?></td>
                            <td>
                                <button class="btn btn-sm">
                                    <a href="/user/detail/<?= $s['id_user']; ?>">
                                        <img src="https://img.icons8.com/ios-glyphs/15/000000/visible.png" />
                                    </a>
                                </button>
                                <button class="btn btn-sm">
                                    <a href="/user/update/<?= $s['id_user']; ?>">
                                        <img src="https://img.icons8.com/ios-glyphs/15/000000/pencil--v1.png" />
                                    </a>
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