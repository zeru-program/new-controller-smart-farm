var URL = "https://controler-smart-farm-default-rtdb.firebaseio.com/";
var statusServer = 0;

const firebaseConfig = {
    databaseURL: "https://controler-smart-farm-default-rtdb.firebaseio.com/"
};
firebase.initializeApp(firebaseConfig);

const database = firebase.database();
const xValues = ["Pagi", "Siang", "Sore", "Malam"];
const tempValues = [];
const humiValues = [];
const moistureValues1 = [];
var statusServer = 0;
var autoMode = 0;
var scheduleMode = 0;
var midTempValue = 0;
var midHumiValue = 0;
var midMoisture1Value = 0;
var pagiTime = 0;
var siangTime = 0;
var soreTime = 0;
var malamTime = 0;

const Toast = Swal.mixin({
    toast: true,
    position: "top-end",
    showConfirmButton: false,
    timer: 3000,
    timerProgressBar: true
});

let lastTemperature = null;
let lastMoisture1 = null;

// Creating the chart
var myChart = new Chart("myChart", {
    type: "bar",
    data: {
        labels: xValues,
        datasets: [
            {
                label: "Humidity", // Dataset untuk humidity
                fill: false,
                lineTension: 0,
                backgroundColor: "#512B81",
                borderColor: "rgba(81, 43, 129, 0.8)",
                data: humiValues,
                yAxisID: "y-axis-humidity", // Hubungkan dataset ini dengan sumbu Y untuk humidity
                stepped: true
            },
            {
                label: "Moisture1", // Dataset untuk moisture
                fill: false,
                lineTension: 0,
                backgroundColor: "rgba(255, 32, 78, 1)",
                borderColor: "rgba(255, 32, 78, 0.7)",
                data: moistureValues1,
                yAxisID: "y-axis-moisture" // Hubungkan dataset ini dengan sumbu Y untuk moisture
            }
        ]
    },
    options: {
        responsive: true,
        legend: {
            display: true
        }, // Tampilkan legend untuk membedakan dataset
        scales: {
            yAxes: [
                {
                    id: "y-axis-humidity", // Sumbu Y untuk humidity
                    position: "left",
                    ticks: {
                        min: 0,
                        max: 100,
                        stepSize: 10 // Rentang dari 0 hingga 100 dengan jarak 10
                    }
                },
                {
                    id: "y-axis-moisture", // Sumbu Y untuk moisture
                    position: "right",
                    ticks: {
                        min: 0,
                        max: 100,
                        stepSize: 10 // Rentang dari 0 hingga 100 dengan jarak 10
                    }
                }
            ]
        },
        animation: {
            duration: 1000, // Durasi animasi dalam milidetik
            easing: "easeInOutQuart" // Fungsi easing untuk transisi halus
        }
    }
});

var myChartTemp = new Chart("myChartTemp", {
    type: "bar",
    data: {
        labels: xValues,
        datasets: [
            {
                label: "Temperature", // Dataset suhu
                fill: false,
                lineTension: 0,
                backgroundColor: "#800300",
                borderColor: "rgb(128, 3, 0, 0.8)",
                data: tempValues,
                stepped: true
            }
        ]
    },
    options: {
        responsive: true,
        legend: {
            display: true
        }, // Menampilkan legend untuk membedakan dataset
        scales: {
            yAxes: [
                {
                    ticks: {
                        min: 0,
                        max: 24, // Indeks maksimum yang sesuai dengan suhu 33.0
                        callback: function (value, index, ticks) {
                            // Mengonversi indeks yAxis ke nilai suhu
                            return (21.0 + value * 0.5).toFixed(1); // Rentang dari 21.0 sampai 33.0
                        }
                    }
                }
            ]
        },
        animation: {
            duration: 1000, // Durasi animasi dalam milidetik
            easing: "easeInOutQuart" // Easing function untuk transisi halus
        }
    }
});

function updateChartH(humi) {
    humiValues.push(humi); // Adding random humidity data
    if (xValues.length > 10) {
        // Keep max 10 data points, can adjust accordingly
        humiValues.shift();
    }

    myChart.update(); // Update the chart with new data
}
function updateChartM(moisture1) {
    moistureValues1.push(moisture1); // Adding random humidity data
    if (xValues.length > 10) {
        // Keep max 10 data points, can adjust accordingly
        moistureValues1.shift();
    }

    myChart.update(); // Update the chart with new data
}
function updateChartT(temp) {
    var index = mapTempToIndex(temp); // Map nilai suhu ke indeks yAxis
    if (index !== null) {
        tempValues.push(index); // Masukkan nilai indeks ke chart
        if (xValues.length > 10) {
            tempValues.shift(); // Menggeser data jika lebih dari 10 nilai
        }
        myChartTemp.update(); // Update chart dengan data baru
    }
}

function mapTempToIndex(temp) {
    if (temp < 21.0 || temp > 33.0) {
        return null; // Abaikan jika suhu di luar rentang
    }

    // Menghitung indeks berdasarkan suhu dengan kenaikan 0.5
    var index = Math.round((temp - 21.0) / 0.5);
    return index; // Indeks ini sesuai dengan skala Y di chart
}

fetch(URL + "dataFarm/diagrams/temperature.json")
    .then(res => res.json())
    .then(data => {
        // Cek apakah data pagi ada, lalu update chart
        if (data.pagi > 0) {
            updateChartT(data.pagi);
        }

        // Cek apakah data siang tersedia, lalu update chart
        if (data.siang > 0) {
            updateChartT(data.siang);
        }

        // Cek apakah data sore tersedia, lalu update chart
        if (data.sore > 0) {
            updateChartT(data.sore);
        }

        // Cek apakah data malam tersedia, lalu update chart
        if (data.malam > 0) {
            updateChartT(data.malam);
        }
    });
fetch(URL + "dataFarm/diagrams/humidity.json")
    .then(res => res.json())
    .then(data => {
        // Cek apakah data pagi ada, lalu update chart
        if (data.pagi > 0) {
            updateChartH(data.pagi);
        }

        // Cek apakah data siang tersedia, lalu update chart
        if (data.siang > 0) {
            updateChartH(data.siang);
        }

        // Cek apakah data sore tersedia, lalu update chart
        if (data.sore > 0) {
            updateChartH(data.sore);
        }

        // Cek apakah data malam tersedia, lalu update chart
        if (data.malam > 0) {
            updateChartH(data.malam);
        }
    });
fetch(URL + "dataFarm/diagrams/moisture1.json")
    .then(res => res.json())
    .then(data => {
        // Cek apakah data pagi ada, lalu update chart
        if (data.pagi > 0) {
            updateChartM(data.pagi);
        }

        // Cek apakah data siang tersedia, lalu update chart
        if (data.siang > 0) {
            updateChartM(data.siang);
        }

        // Cek apakah data sore tersedia, lalu update chart
        if (data.sore > 0) {
            updateChartM(data.sore);
        }

        // Cek apakah data malam tersedia, lalu update chart
        if (data.malam > 0) {
            updateChartM(data.malam);
        }
    });

function server(state) {
    let stateFix;
    if (state === "on") {
        stateFix = 1;
    } else if (state === "off") {
        stateFix = 0;
    }
    if (state === "off") {
        fetch(URL + "dataFarm.json", {
            method: "PATCH",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                temperature: 0,
                humidity: 0,
                moisture1: 0
            })
        }).then(res => {
            if (res.ok) {
                fetch(URL + "dataOperation.json", {
                    method: "PATCH",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({
                        pagi_done: 0,
                        siang_done: 0,
                        sore_done: 0,
                        malam_done: 0
                    })
                }).then(res => {
                    if (res.ok) {
                        return;
                    }
                });
            }
        });
    }
    fetch(URL + "config.json", {
        method: "PATCH",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            server: stateFix
        })
    }).then(res => {
        if (res.ok) {
            if (state === "on") {
                Swal.fire({
                    title: "Berhasil !",
                    text: "server on",
                    icon: "success"
                });
            } else if (state === "off") {
                Swal.fire({
                    title: "Berhasil !",
                    text: "server off",
                    icon: "success"
                });
            }
        }
    });
}

function getStatusServer() {
    var btnBtn = document.getElementById("btn-btn");
    var btnAlert = document.getElementById("btn-alert");
    fetch(URL + "config.json")
        .then(res => res.json())
        .then(data => {
            var btnOn = document.getElementById("btns-on");
            var btnOff = document.getElementById("btns-off");
            if (data.server == 0) {
                btnOn.style.display = "flex";
                btnOff.style.display = "none";
                btnBtn.style.display = "none";
                btnAlert.style.display = "none";
                statusServer = 0;
            } else if (data.server == 1) {
                btnOn.style.display = "none";
                btnOff.style.display = "flex";
                btnBtn.style.display = "flex";
                btnAlert.style.display = "flex";
                statusServer = 1;
            }
        });
}
function changeSystem(elem) {
    var value = elem.value;
    fetch(URL + "config.json", {
        method: "PATCH",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            sf_operation: value
        })
    }).then(res => {
        if (res.ok) {
            Swal.fire({
                title: "Berhasil !",
                text: "mengganti system ke " + value,
                icon: "success"
            });
        } else {
            Swal.fire({
                title: "Failed !",
                text: "gagal mengganti system",
                icon: "info"
            });
        }
    });
}

function getSystemFarm() {
    fetch(URL + "config.json")
        .then(res => res.json())
        .then(data => {
            document.getElementById("system_mode_input").value =
                data.sf_operation;
            if (data.sf_operation === "automatic") {
                document.getElementById("auto-popup").style.display = "flex";
                document.getElementById("schedule-popup").style.display =
                    "none";
                autoMode = 1;
            } else if (data.sf_operation === "schedule") {
                document.getElementById("auto-popup").style.display = "none";
                document.getElementById("schedule-popup").style.display =
                    "flex";
                scheduleMode = 1;
            } else {
                document.getElementById("auto-popup").style.display = "none";
                document.getElementById("schedule-popup").style.display =
                    "none";
                autoMode = 0;
                scheduleMode = 0;
            }
        });
}

function saveAutoMode() {
    var midTemp = document.getElementById("mid-temp").value;
    var midHumi = document.getElementById("mid-humi").value;
    var midMoisture1 = document.getElementById("mid-moisture1").value;
    fetch(URL + "dataOperation.json", {
        method: "PATCH",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            mid_temp: midTemp,
            mid_humidity: midHumi,
            mid_moisture1: midMoisture1
        })
    }).then(res => {
        if (res.ok) {
            Toast.fire({
                icon: "success",
                title: "Pengaturan disimpan."
            });
        }
    });
}
function loadAutoMode() {
    var midTemp = document.getElementById("mid-temp");
    var midHumi = document.getElementById("mid-humi");
    var midMoisture1 = document.getElementById("mid-moisture1");
    fetch(URL + "dataOperation.json")
        .then(res => res.json())
        .then(data => {
            midTemp.value = parseFloat(data.mid_temp);
            midHumi.value = parseInt(data.mid_humidity);
            midMoisture1.value = parseInt(data.mid_moisture1);

            midTempValue = parseFloat(data.mid_temp);
            midHumiValue = parseInt(data.mid_humidity);
            midMoisture1Value = parseInt(data.mid_moisture1);
        });
}
function checkAutoMode() {
    if (statusServer == 1 && autoMode == 1) {
        fetch(URL + "dataFarm.json")
            .then(res => res.json())
            .then(data => {
                // Cek jika suhu berbeda dengan suhu sebelumnya
                if (lastTemperature !== data.temperature) {
                    if (data.temperature < midTempValue) {
                        fanButton(
                            "off",
                            document.getElementById("fan1-btn-off"),
                            1
                        );
                    } else if (data.temperature > midTempValue) {
                        fanButton(
                            "on",
                            document.getElementById("fan1-btn-on"),
                            1
                        );
                    }
                    // Simpan suhu sekarang sebagai suhu terakhir
                    lastTemperature = data.temperature;
                }
                setTimeout(() => {
                    if (lastMoisture1 !== data.moisture1) {
                        if (data.moisture1 < midMoisture1Value) {
                            pumpButton(
                                "on",
                                document.getElementById("pump1-btn-on"),
                                1
                            );
                        } else if (data.moisture1 > midMoisture1Value) {
                            pumpButton(
                                "off",
                                document.getElementById("pump1-btn-off"),
                                1
                            );
                        }
                        // Simpan suhu sekarang sebagai suhu terakhir
                        lastMoisture1 = data.moisture1;
                    }
                }, 2000);
            })
            .catch(error => {
                console.error("Error fetching data:", error);
            });
    }
}

function saveScheduleMode() {
    var pagiIpt = document.getElementById("pagi-ipt").value;
    var siangIpt = document.getElementById("siang-ipt").value;
    var soreIpt = document.getElementById("sore-ipt").value;
    var malamIpt = document.getElementById("malam-ipt").value;
    fetch(URL + "dataOperation.json", {
        method: "PATCH",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            pagi_sc: pagiIpt,
            siang_sc: siangIpt,
            sore_sc: soreIpt,
            malam_sc: malamIpt
        })
    })
        .then(res => {
            if (res.ok) {
                Toast.fire({
                    icon: "success",
                    title: "Pengaturan disimpan."
                });
            } else {
                alert("error");
            }
        })
        .catch(error => {
            console.error("Terjadi kesalahan saat menyimpan:", error);
            alert("Terjadi kesalahan saat menyimpan pengaturan.");
        });
}
function loadScheduleMode() {
    var pagiIpt = document.getElementById("pagi-ipt");
    var siangIpt = document.getElementById("siang-ipt");
    var soreIpt = document.getElementById("sore-ipt");
    var malamIpt = document.getElementById("malam-ipt");
    fetch(URL + "dataOperation.json")
        .then(res => res.json())
        .then(data => {
            pagiIpt.value = parseInt(data.pagi_sc);
            siangIpt.value = parseInt(data.siang_sc);
            soreIpt.value = parseInt(data.sore_sc);
            malamIpt.value = parseInt(data.malam_sc);

            pagiTime = parseInt(data.pagi_sc);
            siangTime = parseInt(data.siang_sc);
            soreTime = parseInt(data.sore_sc);
            malamTime = parseInt(data.malam_sc);
        });
}
function checkScheduleMode() {
    if (statusServer == 1 && scheduleMode == 1) {
        fetch(URL + "dataOperation.json")
            .then(res => res.json())
            .then(data => {
                let now = new Date();
                let hours = now.getHours();

                if (parseInt(data.pagi_sc) == hours) {
                    if (data.pagi_done == 0) {
                        fetch(URL + "dataOperation.json", {
                            method: "PATCH",
                            headers: {
                                "Content-Type": "application/json"
                            },
                            body: JSON.stringify({
                                pagi_done: 1
                            })
                        }).then(res => {
                            if (res.ok) {
                                pumpButton(
                                    "on",
                                    document.getElementById("pump1-btn-on"),
                                    1
                                );
                                setTimeout(() => {
                                    fanButton(
                                        "off",
                                        document.getElementById("fan1-btn-off"),
                                        1
                                    );
                                }, 2000);
                            }
                        });
                    }
                } else if (parseInt(data.siang_sc) == hours) {
                    if (data.siang_done == 0) {
                        fetch(URL + "dataOperation.json", {
                            method: "PATCH",
                            headers: {
                                "Content-Type": "application/json"
                            },
                            body: JSON.stringify({
                                siang_done: 1
                            })
                        }).then(res => {
                            if (res.ok) {
                                pumpButton(
                                    "off",
                                    document.getElementById("pump1-btn-off"),
                                    1
                                );
                                setTimeout(() => {
                                    fanButton(
                                        "on",
                                        document.getElementById("fan1-btn-on"),
                                        1
                                    );
                                }, 2000);
                            }
                        });
                    }
                } else if (parseInt(data.sore_sc) == hours) {
                    if (data.sore_done == 0) {
                        fetch(URL + "dataOperation.json", {
                            method: "PATCH",
                            headers: {
                                "Content-Type": "application/json"
                            },
                            body: JSON.stringify({
                                sore_done: 1
                            })
                        }).then(res => {
                            if (res.ok) {
                                pumpButton(
                                    "off",
                                    document.getElementById("pump1-btn-off"),
                                    1
                                );
                                setTimeout(() => {
                                    fanButton(
                                        "on",
                                        document.getElementById("fan1-btn-on"),
                                        1
                                    );
                                }, 2000);
                            }
                        });
                    }
                } else if (parseInt(data.malam_sc) == hours) {
                    if (data.malam_done == 0) {
                        fetch(URL + "dataOperation.json", {
                            method: "PATCH",
                            headers: {
                                "Content-Type": "application/json"
                            },
                            body: JSON.stringify({
                                malam_done: 1
                            })
                        }).then(res => {
                            if (res.ok) {
                                pumpButton(
                                    "on",
                                    document.getElementById("pump1-btn-on"),
                                    1
                                );

                                setTimeout(() => {
                                    fanButton(
                                        "off",
                                        document.getElementById("fan1-btn-off"),
                                        1
                                    );
                                }, 2000);
                            }
                        });
                    }
                } else {
                    pumpButton(
                        "off",
                        document.getElementById("pump1-btn-off"),
                        1
                    );
                    fanButton(
                        "off",
                        document.getElementById("fan1-btn-off"),
                        1
                    );
                }
            })
            .catch(error => {
                console.error("Error fetching data:", error);
            });
    }
}

function loadDataGrafik() {
    fetch(URL + "dataFarm/diagrams.json")
        .then(res => res.json())
        .then(data => {
            var temps = data.temperature;
            var humid = data.humidity;
            var ms1 = data.moisture1;
            console.log(temps.pagi);
            var tempPagi = document.getElementById("temp-pagi");
            var tempSiang = document.getElementById("temp-siang");
            var tempSore = document.getElementById("temp-sore");
            var tempMalam = document.getElementById("temp-malam");

            var humiPagi = document.getElementById("humidity-pagi");
            var humiSiang = document.getElementById("humidity-siang");
            var humiSore = document.getElementById("humidity-sore");
            var humiMalam = document.getElementById("humidity-malam");

            var msPagi = document.getElementById("moisture1-pagi");
            var msSiang = document.getElementById("moisture1-siang");
            var msSore = document.getElementById("moisture1-sore");
            var msMalam = document.getElementById("moisture1-malam");

            tempPagi.value = temps.pagi;
            tempSiang.value = temps.siang;
            tempSore.value = temps.sore;
            tempMalam.value = temps.malam;

            humiPagi.value = humid.pagi;
            humiSiang.value = humid.siang;
            humiSore.value = humid.sore;
            humiMalam.value = humid.malam;

            msPagi.value = ms1.pagi;
            msSiang.value = ms1.siang;
            msSore.value = ms1.sore;
            msMalam.value = ms1.malam;
        });
}

function saveGrafik(type) {
    var tempPagi = document.getElementById("temp-pagi");
    var tempSiang = document.getElementById("temp-siang");
    var tempSore = document.getElementById("temp-sore");
    var tempMalam = document.getElementById("temp-malam");

    var humiPagi = document.getElementById("humidity-pagi");
    var humiSiang = document.getElementById("humidity-siang");
    var humiSore = document.getElementById("humidity-sore");
    var humiMalam = document.getElementById("humidity-malam");

    var msPagi = document.getElementById("moisture1-pagi");
    var msSiang = document.getElementById("moisture1-siang");
    var msSore = document.getElementById("moisture1-sore");
    var msMalam = document.getElementById("moisture1-malam");

    var bodyData = {};

    // Tentukan data yang akan disimpan berdasarkan tipe
    if (type === "temperature") {
        bodyData = {
            pagi: parseInt(tempPagi.value),
            siang: parseInt(tempSiang.value),
            sore: parseInt(tempSore.value),
            malam: parseInt(tempMalam.value)
        };
    } else if (type === "humidity") {
        bodyData = {
            pagi: parseInt(humiPagi.value),
            siang: parseInt(humiSiang.value),
            sore: parseInt(humiSore.value),
            malam: parseInt(humiMalam.value)
        };
    } else if (type === "moisture1") {
        bodyData = {
            pagi: parseInt(msPagi.value),
            siang: parseInt(msSiang.value),
            sore: parseInt(msSore.value),
            malam: parseInt(msMalam.value)
        };
    }

    // Lakukan PATCH request ke Firebase dengan data yang sesuai
    fetch(URL + "dataFarm/diagrams/" + type + ".json", {
        method: "PATCH",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(bodyData)
    })
        .then(response => response.json())
        .then(data => {
            Toast.fire({
                icon: "success",
                title: "Data grafik berhasil disimpan."
            });
        })
        .catch(error => {
            console.error("Error saving data:", error);
        });
}

database.ref("dataFarm").on("value", snapshot => {
    var data = snapshot.val();
    if (data) {
        var moistureValue1 = parseFloat(data.moisture1);
        var changeKondisiTanaman = document.getElementById("kondisi-tanaman");

        var textTemp = document.getElementById("temp-val");
        var textHumidity = document.getElementById("humi-val");
        var textMoisture1 = document.getElementById("ms-val");

        var intTemp = parseFloat(data.temperature);
        var intHumidity = parseFloat(data.humidity);
        var intMoisture1 = parseFloat(data.moisture1);

        // Mengubah angka menjadi dua digit (01, 02, dst.)
        var formattedTemp = String(intTemp).padStart(2, "0");
        var formattedHumidity = String(intHumidity).padStart(2, "0");
        var formattedMoisture1 = String(intMoisture1).padStart(2, "0");

        textTemp.value = formattedTemp;
        textHumidity.value = formattedHumidity;
        textMoisture1.value = formattedMoisture1;
    } else {
        alert("HTTP error");
    }
});

function dTime() {
    var text = document.getElementById("display-time");
    var time = new Date();
    text.innerText = time;
}

setInterval(checkAutoMode, 3000);
setInterval(checkScheduleMode, 10000);
loadAutoMode();
loadScheduleMode();
loadDataGrafik();
setInterval(getSystemFarm, 1000);
setInterval(getStatusServer, 1000);
setInterval(dTime, 1000);
