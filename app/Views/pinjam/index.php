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
                    <h1 class="fw-bold">Data Peminjaman</h1>
                </div>
                <div class="col d-flex justify-content-end">
                    <button class="btn btn-col m-1" type="button">
                        <a href="pinjam/create" class="text-decoration-none text-white">
                            <img src="https://img.icons8.com/ios-glyphs/25/ffffff/add.png" />
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
            <table class="table table-striped  align-middle mt-3">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Nama Peminjam</th>
                        <th scope="col">Barang Dipinjam</th>
                        <th scope="col">Jumlah Pinjam</th>
                        <th scope="col">Tanggal Pinjam</th>
                        <th scope="col">Tanggal Kembali</th>
                        <th scope="col">Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <?php $i = 1; ?>
                    <?php foreach ($pinjam as $p) : ?>
                        <tr>
                            <th scope="row"><?= $i++; ?></th>
                            <td><?= $p['nama']; ?></td>
                            <td><?= $p['nama_barang']; ?></td>
                            <td><?= $p['jml_pinjam']; ?></td>
                            <td><?= $p['tgl_pinjam']; ?></td>
                            <td><?= $p['tgl_kembali']; ?></td>
                            <td>
                                <button class="btn btn-sm">
                                    <a href="#">
                                        <img src="https://img.icons8.com/ios-glyphs/15/000000/visible.png" />
                                    </a>
                                </button>
                                <button class="btn btn-sm">
                                    <img src="https://img.icons8.com/ios-glyphs/15/000000/pencil--v1.png" />
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