<?= $this->extend('layout/template'); ?>

<?= $this->section('content'); ?>
<?= $this->include('layout/sidebar'); ?>
<div class="main">
    <?= $this->include('layout/navbar'); ?>
    <!-- Content -->
    <div class="container">
        <div class="container my-5 ms-auto bg-white p-5">
            <h1 class="fw-bold mb-3">Detail User</h1>
            <div class="card mb-3 p-3" style="max-width: 900px;">
                <div class="row g-6 align-items-center">
                    <div class="col-md-4">
                        <img src="/img/<?= $user['foto_profil']; ?>" class="img-fluid rounded-start" alt="...">
                    </div>
                    <div class="col-sm-2">
                        <p> Nama </p>
                        <p> Username </p>
                        <p> Akses Level </p>
                    </div>
                    <div class="col-sm-4">
                        <p>: <?= $user['nama']; ?></p>
                        <p>: <?= $user['username']; ?></p>
                        <p>: <?= $user['level']; ?></p>
                    </div>
                </div>
            </div>
            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <form action="/user/delete/<?= $user['id_user']; ?>" method="POST" class="d-inline">
                    <?= csrf_field(); ?>
                    <input type="hidden" name="_method" value="DELETE">
                    <button type="submit" class="btn btn-danger m-1" onclick="return confirm('apakah anda yakin ingin menghapus?')">
                        <i class="bi bi-trash-fill white"></i>
                        Hapus
                    </button>
                </form>
                <button class="btn btn-col m-1" type="button">
                    <i class="bi bi-arrow-left-circle-fill white"></i>
                    <a href="/user" class="text-decoration-none text-white">
                        Kembali
                    </a>
                </button>
            </div>
        </div>
    </div>
    <?= $this->endSection(); ?>