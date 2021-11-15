<?= $this->extend('layout/template'); ?>

<?= $this->section('content'); ?>
<div class="container-fluid">
    <div class="row">
        <div class="col py-4">
            <a href="/"><img src="img/logo_OI_ijo.png" alt="login" class="logo-image"></a>
        </div>
    </div>
    <div class="row align-items-center">
        <div class="col-8">
            <img src="img/hero_login.png" alt="login" class="col-lg-10 hero-image">
        </div>
        <div class="col-4">
            <div class="col-10 form-section">
                <h1 id="login-title">Login</h1>
                <?php if (session()->getFlashdata('pesan')) : ?>
                    <div class="alert alert-danger"><?= session()->getFlashdata('pesan') ?></div>
                <?php endif; ?>
                <form action="/login/auth" method="post">
                    <div class="mb-2">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" class="form-control" id="username" name="username">
                    </div>
                    <div class="mb-2">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password">
                    </div>
                    <button type="submit" class="btn btn-login mt-3">Login</button>
                </form>
            </div>
        </div>
    </div>
    <div class="row mt-3">
        <footer class="footer">
            <div class="container">
                <a class="navbar-brand" href="#"></a>
            </div>
        </footer>
    </div>
</div>
<?= $this->endSection(); ?>