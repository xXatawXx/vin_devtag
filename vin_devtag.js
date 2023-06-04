addEventListener("message", (event) => {
    let item = event.data;

    if (item.type == true) {
        document.getElementById("data").innerHTML = item.html;
    }
});
