<?= $this->extend('layout/template'); ?>

<?= $this->section('content'); ?>
<?= $this->include('layout/sidebar'); ?>
<div class="main">
    <?= $this->include('layout/navbar'); ?>
    <!-- Content -->
    <div class="container">
        <div class="container my-5 ms-auto bg-white p-5">
            <div class="row g-3">
                <h2 class="fw-bold">Form Tambah User</h2>
                <form action="/user/saveCreate" method="POST" enctype="multipart/form-data">
                    <?= csrf_field(); ?>
                    <div class="form-group row mt-5">
                        <label for="nama" class="col-sm-2 col-form-label">Nama :</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control <?= ($validation->hasError('nama')) ? 'is-invalid' : ''; ?> " id="nama" name="nama" autofocus value="<?= old('nama'); ?>">
                            <div id="validationServer03Feedback" class="invalid-feedback">
                                <?= $validation->getError('nama'); ?>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row mt-5">
                        <label for="level" class="col-sm-2 col-form-label">Level :</label>
                        <div class="col-sm-6">
                            <select class="form-select <?= ($validation->hasError('level')) ? 'is-invalid' : ''; ?> " id="level" name="level" autofocus value="<?= old('level'); ?>"" aria-label=" Default select example" name="level" id="level">
                                <option value="U01">Administrator</option>
                                <option value="U02">Manajemen</option>
                                <option value="U03" selected>Peminjam</option>
                            </select>
                            <div id="validationServer03Feedback" class="invalid-feedback">
                                <?= $validation->getError('level'); ?>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row mt-5">
                        <label for="username" class="col-sm-2 col-form-label">Username :</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control <?= ($validation->hasError('username')) ? 'is-invalid' : ''; ?> " id="username" name="username" autofocus value="<?= old('username'); ?>">
                            <div id="validationServer03Feedback" class="invalid-feedback">
                                <?= $validation->getError('username'); ?>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row mt-5">
                        <label for="password" class="col-sm-2 col-form-label">Password :</label>
                        <div class="col-sm-6">
                            <input type="password" class="form-control <?= ($validation->hasError('password')) ? 'is-invalid' : ''; ?> " id="password" name="password" autofocus value="<?= old('password'); ?>">
                            <div id="validationServer03Feedback" class="invalid-feedback">
                                <?= $validation->getError('password'); ?>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row mt-5">
                        <label for="confpassword" class="col-sm-2 col-form-label">Konfirmasi Password :</label>
                        <div class="col-sm-6">
                            <input type="password" class="form-control <?= ($validation->hasError('confpassword')) ? 'is-invalid' : ''; ?> " id="confpassword" name="confpassword" autofocus value="<?= old('confpassword'); ?>">
                            <div id="validationServer03Feedback" class="invalid-feedback">
                                <?= $validation->getError('confpassword'); ?>
                            </div>
                        </div>
                    </div>
                    <div class=" form-group row mt-3">
                        <label for="foto_profil" class="col-sm-2 col-form-label">Foto Profil :</label>
                        <div class="col-sm-2">
                            <img src="/img/default.png" class="img-thumbnail img-preview">
                        </div>
                        <div class="col-sm-2">
                            <div class="custom-file">
                                <input type="file" class="custom-file-input  <?= ($validation->hasError('foto_profil')) ? 'is-invalid' : ''; ?> " id="foto_profil" name="foto_profil" value="<?= old('foto_profil'); ?>" id="foto_profil" name="foto_profil" onchange="previewImg()">
                                <div id="validationServer03Feedback" class="invalid-feedback">
                                    <?= $validation->getError('foto_profil'); ?>
                                </div>
                                <label class="custom-file-label" for="foto_profil"></label>
                            </div>
                        </div>
                    </div>
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <a class="btn btn-warning me-md-2 white" type="button" href="/user">Kembali</a>
                        <button class="btn btn-success" type="submit">Simpan Data</button>
                    </div>
                </form>
            </div>


        </div>
    </div>
</div>
<?= $this->endSection(); ?>