<?= $this->extend('layout/template'); ?>

<?= $this->section('content'); ?>
<?= $this->include('layout/sidebar'); ?>
<div class="main">
    <?= $this->include('layout/navbar'); ?>
    <!-- Content -->
    <div class="container">
        <div class="container my-5 ms-auto bg-white p-5">
            <div class="row g-3">
                <h2 class="fw-bold">Form Update User</h2>
                <form action="/user/saveUpdate/<?= $user['id_user']; ?>" method="POST" enctype="multipart/form-data">
                    <?= csrf_field(); ?>
                    <input type="hidden" name="password" value="<?= $user['password']; ?>">
                    <input type="hidden" name="fotoLama" value="<?= $user['foto_profil']; ?>">
                    <input type="hidden" name="level" value="<?= $user['level']; ?>">
                    <input type="hidden" name="nama" value="<?= $user['nama']; ?>">
                    <div class="form-group row">
                        <label for="id_user" class="col-sm-2 col-form-label">Id User : </label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="id_user" value="<?= (old('id_user')) ? old('id_user') : $user['id_user']; ?>" name="id_user" readonly>
                        </div>
                    </div>
                    <div class="form-group row mt-3">
                        <label for="username" class="col-sm-2 col-form-label">Username :</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control <?= ($validation->hasError('username')) ? 'is-invalid' : ''; ?> " id="username" name="username" autofocus value="<?= (old('username')) ? old('username') : $user['username']; ?>">
                            <div id="validationServer03Feedback" class="invalid-feedback">
                                <?= $validation->getError('username'); ?>
                            </div>
                        </div>
                    </div>
                    <div class=" form-group row mt-3">
                        <label for="foto_profil" class="col-sm-2 col-form-label">Foto Profil :</label>
                        <div class="col-sm-2">
                            <img src="/img/<?= $user['foto_profil']; ?>" class="img-thumbnail img-preview">
                        </div>
                        <div class="col-sm-2">
                            <div class="custom-file">
                                <input type="file" class="custom-file-input  <?= ($validation->hasError('foto_profil')) ? 'is-invalid' : ''; ?> " id="foto_profil" name="foto_profil" value="<?= old('foto_profil'); ?>" id="foto_profil" name="foto_profil" onchange="previewImg()">
                                <div id="validationServer03Feedback" class="invalid-feedback">
                                    <?= $validation->getError('foto_profil'); ?>
                                </div>
                                <label class="custom-file-label" for="foto_profil"><?= $user['foto_profil']; ?></label>
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