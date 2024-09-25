<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Controller smart farm - register</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous"></script>
  <!--Google Fonts and Icons and cdn-->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script src="https://cdn.jsdelivr.net/npm/js-circle-progress/dist/circle-progress.min.js" type="module"></script>
  <link rel="shortcut icon" href="https://i.pinimg.com/474x/ef/f6/ac/eff6acfcf843833a9b21070769dae764.jpg"
    type="image/x-icon">
  <!-- style path -->
  <link rel="stylesheet" href="../../assets/style.css" type="text/css" media="all" />
  <!--<link rel="stylesheet" href="https://zeru-program.github.io/controller-smart-farm-esp32/style.css" type="text/css" media="all" />-->
  <script type="text/javascript" charset="utf-8">
    if (localStorage.getItem("login")) {
      window.location.href = "/"
    }
    </script>
</head>

<body>

  <main class="m-0 w-100 text-center vh-100 d-flex justify-content-center align-items-center">
    <div class="d-flex shadow-lg gap-2 flex-column justify-content-center container align-items-center rounded-2 py-5"
      style="width: 450px;height:auto;">
      <img src="../../assets/logo.jpg" style="width:100px" alt="logo" />
      <h1 class="m-0">Register</h1>
      <input type="text" name="" id="username-ipt" class="form-control mt-2" placeholder="username.." />
      <input type="email" name="" id="email-ipt" class="form-control mt-2" placeholder="email.." />
      <input type="password" name="" id="password-ipt" class="form-control" placeholder="password.." />
      <button type="button" class="btn btn-primary mt-2" onclick="register()">Register</button>
    </div>
  </main>

  <script src="../../assets/main.js" type="text/javascript" charset="utf-8"></script>
  <script>


    function register() {
      var usnInput = document.getElementById("username-ipt").value
      var emailInput = document.getElementById("email-ipt").value
      var passInput = document.getElementById("password-ipt").value
      var validation = true;
      if (!usnInput || !emailInput || !passInput || !validation) {
        Swal.fire({
          title: "Failed !",
          text: 'silakan isi data dengan benar.',
          icon: "error"
        });
        validation = false
      }

      if (validation) {
        var userId = Math.floor(Math.random() * 100);
        var data = {
          user_id: userId,
          username: usnInput,
          password: passInput
        }
        fetch("../../config/postDataAccount.php", {
          method: "POST",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify(data)
        })
          .then(res => res.json())
          .then(data => {
            Swal.fire({
              title: "Success !",
              text: 'berhasil membuat akun, silakan login',
              icon: "success"
            });
            window.location.href = "../login/"
          })
      }
    }

  </script>
</body>

</html>