<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Smart farm - home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <!--Google Fonts and Icons and cdn-->
    <script src="https://cdn.jsdelivr.net/npm/js-circle-progress/dist/circle-progress.min.js" type="module"></script>
    <link rel="shortcut icon" href="https://i.pinimg.com/474x/ef/f6/ac/eff6acfcf843833a9b21070769dae764.jpg" type="image/x-icon">
    <!-- style path -->
    <link rel="stylesheet" href="assets/style.css" type="text/css" media="all" />
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
  <!--<script type="text/javascript" charset="utf-8">-->
      <!--window.location.href = "controller-sf/index.html"
    </script>-->
  </head>
  <body class="aos-init" data-aos-easing="ease">
    <!--navbar -->
      <?php 
       include "components/navbar.php"
      ?>
    <!--navbar -->
    
    <header class="w-100 hero-home" id="home" style='background: url("assets/bg-hero-home.jpg") fixed no-repeat center center; background-size:cover'>
      <div class="cotainer w-100 vh-100 d-flex flex-column text-center justify-content-center align-items-center" data-aos="fadeIn" data-aos-duration="2000">
        <p class="m-0">improve your farming with</p>
        <h1 style="font-size:2em;" class="m-0 text-uppercase fw-bolder">Smart Farm</h1>
        <p class="m-0">Click start to move farming controller page!</p>
        <a href="controller-sf/index.html" class="mt-2" data-aos="fadeIn" data-aos-duration="1000" data-aos-delay="500">
          <button class="btn-start py-2" type="button">
            <b>START</b>
          </button>
        </a>
      </div>
    </header>
    
    <main class="m-0 w-100 bg-transparent" style="">

      <!--about us page editing-->
      <div id="about" class="d-flex py-4 position-relative align-items-center text-center text-dark flex-column w-100" style="padding-top:100px !important;background:white">
        <img src="assets/team.jpg" style="width:30%" class="mb-3 rounded-3" alt="team" data-aos="fadeIn" />
        <h1 class="m-0 fw-bold" data-aos="fadeIn">About us</h1>
        <p class="m-0 container" data-aos="fadeIn">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Iure natus nemo ipsam qui iusto, nam voluptate velit deserunt adipisci beatae. Repudiandae necessitatibus doloremque et optio a, iusto placeat sapiente qui.</p>
      </div>
      
      <div class="d-flex py-4 gap-3 container justify-content-center  align-items-center text-dark flex-column w-100" style="background:white;">
       <div class="d-flex justify-content-center align-items-center gap-3 flex-wrap">
       <div class="d-flex" style="border: 1.5px solid #386c5f;width:250px;height:250px;">
         <img src="assets/farmer-ins.jpg" style="z-index:99999;margin-top:10px;margin-left:10px;width:250px;height:250px;object-fit:cover" data-aos="fadeIn" alt="" class="">
       </div>
       <div class="d-flex flex-column contain-text-why" style="">
         <h1 class="m-0 text-uppercase text-wrap fw-bold font-why-choose-sf" data-aos="fadeIn">why choose smart farm?</h1>
       </div>
       </div>
       <div class="d-flex mt-2 text-center">
         <p class="m-0" data-aos="fadeIn">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium voluptatum eligendi exercitationem quidem nulla esse nam dolor sunt eaque possimus minima, iusto consequatur neque nisi facere saepe, explicabo qui numquam.</p>
       </div>
       <div class="mt-3 d-flex flex-column align-items-center">
         <h1 class="m-0 fw-bold" data-aos="fadeIn">Our Circuits</h1>
         <img src="assets/circuits.jpg" data-aos="fadeIn" style="width:100%" alt="circuits image" class="m-0">
       </div>
      </div>
      <!--about us page editing-->
      
      <!--contact us page editing-->
      <div id="contact" class="py-4 d-flex flex-column container" style="background:white;">
        <h1 class="m-0 fw-bold text-center" data-aos="fadeIn">Order our product</h1>
        <p class="m-0 text-center" data-aos="fadeIn">(smart farm project)</p>
        <div class="mt-4 d-flex flex-column" data-aos="fadeIn">
          <div class="d-flex gap-1">
            <i class="bi bi-whatsapp" style="color:green;"></i>
            <span>+6287774487198</span>
          </div>
          <div class="d-flex gap-1">
            <i class="bi bi-envelope" style="color:red;"></i>
            <span>zeruprogram@gmail.com</span>
          </div>
        </div>
        <form action="" class="mt-2 d-flex flex-column" data-aos="fadeIn">
          <p class="m-0">You're name</p>
          <input type="text" class="input-order" name="" id="">
          <p class="m-0 mt-2">Email address</p>
          <input type="email" class="input-order" name="" id="">
          <p class="m-0 mt-2">Email address</p>
          <textarea name="" id="" class="input-order"></textarea>
          <button class="btn-submit mt-2" type="submit">Submit</button>
        </form>
      </div>
      <!--contact us page editing-->
    
      <!--faq page editing-->
      <div id="faq" class="py-4 d-flex flex-column container" style="background:white;">
        <h1 class="fw-bold" style="" data-aos="fadeIn">Frequently Asked Questions</h1>
        <p class="" data-aos="fadeIn">maybe it's will help you</p>
        <div class="accordion accordion-flush" id="accordionFlushExample" data-aos="fadeIn">
          <div class="accordion-item">
            <h2 class="accordion-header">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                Accordion Item #1
              </button>
            </h2>
            <div id="flush-collapseOne" class="accordion-collapse collapse" data-bs-parent="#accordionFlushExample">
              <div class="accordion-body">Placeholder content for this accordion, which is intended to demonstrate the <code>.accordion-flush</code> class. This is the first item's accordion body.</div>
            </div>
          </div>
          <div class="accordion-item">
            <h2 class="accordion-header">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
                Accordion Item #2
              </button>
            </h2>
            <div id="flush-collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionFlushExample">
              <div class="accordion-body">Placeholder content for this accordion, which is intended to demonstrate the <code>.accordion-flush</code> class. This is the second item's accordion body. Let's imagine this being filled with some actual content.</div>
            </div>
          </div>
          <div class="accordion-item">
            <h2 class="accordion-header">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
                Accordion Item #3
              </button>
            </h2>
            <div id="flush-collapseThree" class="accordion-collapse collapse" data-bs-parent="#accordionFlushExample">
              <div class="accordion-body">Placeholder content for this accordion, which is intended to demonstrate the <code>.accordion-flush</code> class. This is the third item's accordion body. Nothing more exciting happening here in terms of content, but just filling up the space to make it look, at least at first glance, a bit more representative of how this would look in a real-world application.</div>
            </div>
          </div>
        </div>
      </div>
      <!--faq page editing-->
      
    </main>
    
      <!--wave animation-->
   <!-- <div>
      <svg class="waves" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http:/www.w3.org/1999/xlink" viewbox="0 24 150 28" preserveAspectRatio="none" shape-rendering="auto">
        <defs>
          <path id="gentle-wave" d="M-160 44c30 0 58-18 88-18s 58 18 88 18 58-18 88-18 58 18 88 18 v44h-352z" />
        </defs>
        <g class="parallax">
          <use xlink:href="#gentle-wave" x="48" y="0" fill="rgba(56,108,95,0.7)"/>
          <use xlink:href="#gentle-wave" x="48" y="3" fill="rgba(56,108,95,0.5)"/>
          <use xlink:href="#gentle-wave" x="48" y="5" fill="rgba(56,108,95,0.3)"/>
          <use xlink:href="#gentle-wave" x="48" y="7" fill="#386c5f"/>
        </g>
      </svg>
    </div>-->
      <!--wave animation-->
    
    
      <!--footer -->
      <?php 
       include "components/footer.php"
      ?>
      <!--footer -->
    <script src="assets/main.js"></script>
  </body>
  
</html>
