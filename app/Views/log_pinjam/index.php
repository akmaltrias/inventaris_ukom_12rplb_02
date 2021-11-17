<?= $this->extend('layout/template'); ?>

<?= $this->section('content'); ?>
<?= $this->include('layout/sidebar'); ?>
<div class="main">
    <?= $this->include('layout/navbar'); ?>
    <!-- Content -->
    <div class="container">
        <div class="container my-5 ms-auto bg-white">
            <div class="row">
                <h1 class="fw-bold">Log Peminjaman</h1>
                <!-- Table -->
                <table class="table table-striped align-middle mt-10">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Peminjam</th>
                            <th scope="col">Barang Pinjam</th>
                            <th scope="col">Jumlah Pinjam</th>
                            <th scope="col">Waktu Aksi</th>
                            <th scope="col">Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $i = 1; ?>
                        <?php foreach ($log as $log) : ?>
                            <tr>
                                <th scope="row"><?= $i++; ?></th>
                                <td><?= $log['peminjam']; ?></td>
                                <td><?= $log['barang']; ?></td>
                                <td><?= $log['jml_pinjam']; ?></td>
                                <td><?= $log['waktu']; ?></td>
                                <td><?= $log['keterangan']; ?></td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <?= $this->endSection(); ?>