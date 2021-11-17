<?= $this->extend('layout/template'); ?>

<?= $this->section('content'); ?>
<?= $this->include('layout/sidebar'); ?>
<div class="main">
    <?= $this->include('layout/navbar'); ?>
    <!-- Content -->
    <div class="container">
        <div class="container my-5 ms-auto bg-white p-5">
            <div class="row g-3">
                <h2 class="fw-bold">Form Tambah Peminjaman</h2>
                <form action="/pinjambarang/savePinjam" method="POST">
                    <?= csrf_field(); ?>
                    <div class="form-group row mt-5">
                        <label for="peminjam" class="col-sm-2 col-form-label">Nama Peminjam :</label>
                        <div class="col-sm-6">
                            <select class="form-select <?= ($validation->hasError('peminjam')) ? 'is-invalid' : ''; ?> " id="peminjam" name="peminjam" autofocus value="<?= old('peminjam'); ?>"" aria-label=" Default select example" name="peminjam" id="peminjam">
                                <?php foreach ($user as $s) : ?>
                                    <option value="<?= $s['id_user']; ?>"><?= $s['nama']; ?></option>
                                <?php endforeach; ?>
                            </select>
                            <div id="validationServer03Feedback" class="invalid-feedback">
                                <?= $validation->getError('peminjam'); ?>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row mt-5">
                        <label for="barang_pinjam" class="col-sm-2 col-form-label">Nama Barang :</label>
                        <div class="col-sm-6">
                            <select class="form-select <?= ($validation->hasError('barang_pinjam')) ? 'is-invalid' : ''; ?> " id="barang_pinjam" name="barang_pinjam" autofocus value="<?= old('barang_pinjam'); ?>"" aria-label=" Default select example" name="barang_pinjam" id="barang_pinjam">
                                <?php foreach ($barang as $b) : ?>
                                    <option value="<?= $b['id_barang']; ?>"><?= $b['nama_barang']; ?></option>
                                <?php endforeach; ?>
                            </select>
                            <div id="validationServer03Feedback" class="invalid-feedback">
                                <?= $validation->getError('barang_pinjam'); ?>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row mt-5">
                        <label for="jml_pinjam" class="col-sm-2 col-form-label">Jumlah Pinjam :</label>
                        <div class="col-sm-6">
                            <input type="number" class="form-control <?= ($validation->hasError('jml_pinjam')) ? 'is-invalid' : ''; ?> " id="jml_pinjam" name="jml_pinjam" autofocus value="<?= old('jml_pinjam'); ?>" min="1">
                            <div id="validationServer03Feedback" class="invalid-feedback">
                                <?= $validation->getError('jml_pinjam'); ?>
                            </div>
                        </div>
                    </div>
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-3">
                        <a class="btn btn-warning me-md-2 white" type="button" href="/user">Kembali</a>
                        <button class="btn btn-success" type="submit">Simpan Data</button>
                    </div>
                </form>
            </div>


        </div>
    </div>
</div>
<?= $this->endSection(); ?>