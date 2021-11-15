<?= $this->extend('layout/template'); ?>

<?= $this->section('content'); ?>
<?= $this->include('layout/sidebar'); ?>
<div class="main">
    <?= $this->include('layout/navbar'); ?>
    <!-- Content -->
    <div class="container">
        <div class="container my-5 ms-auto bg-white p-5">
            <div class="row justify-content-md-center">
                <h1 class="mb-3 fw-bold">Tambah User</h1>
                <div class="col-6">
                    <form action="/user/saveCreate" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="InputFornama" class="form-label">Nama Lengkap</label>
                            <input type="text" name="nama" class="form-control" id="InputForName">
                        </div>
                        <div class="mb-3">
                            <label for="InputForUsername" class="form-label">Username</label>
                            <input type="text" name="username" class="form-control" id="InputForEmail">
                        </div>
                        <div class="mb-3">
                            <label for="InputForPassword" class="form-label">Password</label>
                            <input type="password" name="password" class="form-control" id="InputForPassword">
                        </div>
                        <div class="mb-3">
                            <label for="InputForConfPassword" class="form-label">Konfirmasi Password</label>
                            <input type="password" name="confpassword" class="form-control" id="InputForConfPassword">
                        </div>
                </div>
                <div class="col-6">
                    <div class="form-group">
                        <label for="foto_profil" class="col-sm-10 col-form-label">Foto : </label>
                        <div class="col-sm-10">
                            <img src="/img/default.png" class="img-thumbnail img-preview" width="100px">
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="foto_profil" name="foto_profil" onchange="previewImg()">
                            </div>
                        </div>
                    </div>

                </div>
                <div class="row">
                    <div class="col d-grid gap-2 d-md-flex justify-content-md-end">
                        <button type="submit" class="btn btn-danger">Batal</button>
                        <button type="submit" class="btn btn-primary">Register</button>
                    </div>
                </div>
                </form>
            </div>

        </div>
    </div>
    <?= $this->endSection(); ?>