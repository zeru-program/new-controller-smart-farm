AOS.init();

function openAlert() {
  document.getElementById("popup-alert").style.display = "flex"
}
function closeAlert() {
  document.getElementById("popup-alert").style.display = "none"
}
function openButton() {
  document.getElementById("popup-btn").style.display = "flex"
}
function closeButton() {
  document.getElementById("popup-btn").style.display = "none"
}



var urlPostRelay = "../config/postDataRelay.php";
function pumpButton(type, elem, pumpNumber) {
    var pinBtnOn = "pump" + pumpNumber + "-btn-on"
    var pinBtnOff = "pump" + pumpNumber + "-btn-off"
    var btnOn = document.getElementById(pinBtnOn);
    var btnOff = document.getElementById(pinBtnOff);
    btnOn.classList.remove("btno-active");
    btnOff.classList.remove("btno-active");
    
    var pumpStatus = (type === 'on') ? 1 : 0;  // Pump ON or OFF

    if (type === 'on') {
        elem.classList.add("btno-active");
        fetch(urlPostRelay, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                pump: true,
                pumpNumber: pumpNumber,
                pumpStatus: pumpStatus
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                Swal.fire({
                        title: "Berhasil !",
                        text: 'Pump' + pumpNumber + ' berhasil nyala',
                        icon: "success"
                      });
            } else {
                alert("Error: " + data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
    } else if (type === 'off') {
        elem.classList.add("btno-active");
        fetch(urlPostRelay, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                pump: true,
                pumpNumber: pumpNumber,
                pumpStatus: pumpStatus
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                Swal.fire({
                        title: "Berhasil !",
                        text: 'Pump' + pumpNumber + ' berhasil dimatikan',
                        icon: "success"
                      });
            } else {
                alert("Error: " + data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
    }
}

function fanButton(type, elem, fanNumber) {
   var pinBtnOn = "fan" + fanNumber + "-btn-on"
    var pinBtnOff = "fan" + fanNumber + "-btn-off"
    var btnOn = document.getElementById(pinBtnOn);
    var btnOff = document.getElementById(pinBtnOff);
  btnOn.classList.remove("btno-active")
  btnOff.classList.remove("btno-active")
  
  var fanStatus = (type === 'on') ? 1 : 0;  // Pump ON or OFF

    if (type === 'on') {
        elem.classList.add("btno-active");
        fetch(urlPostRelay, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                fan: true,
                fanNumber: fanNumber,
                fanStatus: fanStatus
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                Swal.fire({
                        title: "Berhasil !",
                        text: 'Fan' + fanNumber + ' berhasil dinyalakan',
                        icon: "success"
                      });
            } else {
                alert("Error: " + data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
    } else if (type === 'off') {
        elem.classList.add("btno-active");
        fetch(urlPostRelay, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                fan: true,
                fanNumber: fanNumber,
                fanStatus: fanStatus
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                Swal.fire({
                        title: "Berhasil !",
                        text: 'Fan' + fanNumber + ' berhasil dimatikan',
                        icon: "success"
                      });
            } else {
                alert("Error: " + data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
    }
}
