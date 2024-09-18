
    const circles = [
        document.querySelector('#circle1'),
        document.querySelector('#circle2'),
        document.querySelector('#circle3')
    ];

    const progressValues = [
        document.querySelector('#progressValue1'),
        document.querySelector('#progressValue2'),
        document.querySelector('#progressValue3')
    ];

    const radii = circles.map(circle => circle.r.baseVal.value);
    const circumferences = radii.map(radius => 2 * Math.PI * radius);

    // Set strokeDasharray and initial strokeDashoffset for all circles
    circles.forEach((circle, i) => {
        circle.style.strokeDasharray = circumferences[i];
        circle.style.strokeDashoffset = circumferences[i];
    });

    function updateProgress(index, value) {
        const percentage = value > 100 ? 100 : value < 0 ? 0 : value; // Batasi nilai antara 0 dan 100
        const offset = circumferences[index] - (percentage / 100) * circumferences[index];
        circles[index].style.strokeDashoffset = offset;
        if (index == 0) {
        progressValues[index].innerHTML = `Temp<br/>${percentage}°C`;
        } else if (index == 1) {
        progressValues[index].innerHTML = `Humidity<br/>${percentage}%`;
        } else if (index == 2) {
        progressValues[index].innerHTML = `Moisture<br/>${percentage}%`;
        }
    }

    updateProgress(0, 0);  // Circular Progress 1
    updateProgress(1, 0);  // Circular Progress 2
    updateProgress(2, 0);  // Circular Progress 3
    