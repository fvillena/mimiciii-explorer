$(document).ready(function () {
    ENDPOINT = "http://grupo08.cc3201.dcc.uchile.cl"
    $.get(`${ENDPOINT}/patients?select=subject_id&order=subject_id.asc`, function (data, status) {
        $.each(data, function (i, item) {
            $('#patients').append($('<option>', {
                value: item.subject_id,
                text: item.subject_id
            }));
        });
    });
    $('#patients').on('change', function (e) {
        $('#patient').show();
        $('#icustays-form').show();
        var optionSelected = $("option:selected", this);
        var valueSelected = this.value;
        $.get(`${ENDPOINT}/patients?subject_id=eq.${valueSelected}`, function (data, status) {
            $("#patient-id").text(data[0].subject_id);
            $("#patient-dob").text(data[0].dob);
            $("#patient-gender").text(data[0].gender);
        });
        $.get(`${ENDPOINT}/icustays?subject_id=eq.${valueSelected}&select=icustay_id&order=icustay_id.asc`, function (data, status) {
            $('#icustays').empty().append('<option></option>');
            $.each(data, function (i, item) {
                $('#icustays').append($('<option>', {
                    value: item.icustay_id,
                    text: item.icustay_id
                }));
            });
        });
    });
    let icustay_id
    $('#icustays').on('change', function (e) {
        $('#icustay').show();
        var optionSelected = $("option:selected", this);
        var valueSelected = this.value;
        icustay_id = this.value
        $.get(`${ENDPOINT}/icustays?icustay_id=eq.${valueSelected}`, function (data, status) {
            $("#icustay-id").text(data[0].icustay_id);
            $("#patient-intime").text(data[0].intime);
            $("#patient-los").text(data[0].los);
        });
        $.get(`${ENDPOINT}/chartevents_d_items?icustay_id=eq.${valueSelected}&valuenum=not.is.null&select=d_itemid,label&order=label.asc`, function (data, status) {
            $('#items-form').show();
            let data_unique = [...new Map(data.map((item) => [item["d_itemid"], item])).values()];
            $('#items').empty().append('<option></option>');
            $.each(data_unique, function (i, item) {
                $('#items').append($('<option>', {
                    value: item.d_itemid,
                    text: item.label
                }));
            });
        });
    });
    $('#items').on('change', function (e) {
        $('#chart').empty()
        var optionSelected = $("option:selected", this);
        var valueSelected = this.value;
        $.get(`${ENDPOINT}/chartevents_d_items?icustay_id=eq.${icustay_id}&valuenum=not.is.null&select=charttime,valuenum&d_itemid=eq.${valueSelected}`, function (data, status) {
            console.log(data)
            var dataset = anychart.data.set(data);
            var mapping = dataset.mapAs({ x: "charttime", value: "valuenum" });
            var chart = anychart.line();
            var series = chart.line(mapping);
            chart.container("chart");
            chart.draw();
        });
    });
});