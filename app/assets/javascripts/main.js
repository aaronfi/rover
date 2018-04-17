$(window).load(function() {
    var applyFilterToSittersList = function() {
        var minScore = Number($('#minScore').val());
        var maxScore = Number($('#maxScore').val());
        $("#sitters li").filter(
            function () {
                var score = $(this).attr('data-ratings-score');
                return score >= minScore && score <= maxScore
            }).slideDown();

        $("#sitters li").filter(
            function () {
                var score = $(this).attr('data-ratings-score');
                return score < minScore || score > maxScore
            }).slideUp();
    };

    // min/max words slider and input fields -- up/down arrows only
    var isSliding = false;

    var minMaxScoreSlider = $('#minMaxScoreSlider')
        .slider({
            min: 0,
            max: 5.0,
            range: true,
            tooltip: 'hide',
            value: [0.0, 5.0]
        }).on('slide', function(e) {
            $('#minScore').val(e.value[0]);
            $('#maxScore').val(e.value[1]);
            applyFilterToSittersList();
        }).on('slideStart', function() {
            isSliding = true;
        }).on('slideStop', function() {
            isSliding = false;
        });

    $('#minScore').change(function() {
        if (!isSliding) {
            var min = Number(Math.min(5, Math.max(0, $(this).val())));
            var max = Number($('#maxScore').val());
            if (min >= max) {
                var temp = min;
                min = max;
                max = temp;
                $('#minScore').val(min);
                $('#maxScore').val(max);
            } else if (min == 0) {
                $('#minScore').val(min);
            }
            minMaxScoreSlider.slider('setValue', [min, max]);
            applyFilterToSittersList();
        }
    });
    $('#maxScore').change(function() {
        if (!isSliding) {
            var min = Number($('#minScore').val());
            var max = Number(Math.max(0, Math.min(5, $(this).val())));
            if (min >= max) {
                var temp = min;
                min = max;
                max = temp;
                $('#minScore').val(min);
                $('#maxScore').val(max);
            } else if (max == 5) {
                $('#maxScore').val(max);
            }
            minMaxScoreSlider.slider('setValue', [min, max]);
            applyFilterToSittersList();
        }
    });

    //var decr_min = function() {
    //    var min = Math.max(0, parseInt($('#minScore').val(), 10) - 0.1);
    //    var max = Number($('#maxScore').val());
    //    $('#minScore').val(min);
    //    minMaxScoreSlider.slider('setValue', [min, max]);
    //}
    //var incr_min = function() {
    //    var min = Math.max(0, parseInt($('#minScore').val(), 10) + 0.1);
    //    var max = Number($('#maxScore').val());
    //    $('#minScore').val(min);
    //    minMaxScoreSlider.slider('setValue', [min, max]);
    //}
    //var decr_max = function() {
    //    var min = Number($('#minScore').val());
    //    var max = Math.max(0, parseInt($('#maxScore').val(), 10) - 0.1);
    //    $('#maxScore').val(max);
    //    minMaxScoreSlider.slider('setValue', [min, max]);
    //}
    //var incr_max = function() {
    //    var min = Number($('#minScore').val());
    //    var max = Math.max(0, parseInt($('#maxScore').val(), 10) + 0.1);
    //    $('#maxScore').val(max);
    //    minMaxScoreSlider.slider('setValue', [min, max]);
    //}
    //$('#minScore').bind('keydown', function(e) {
    //    switch (e.keyCode) {
    //        case 13:  // enter key
    //        case 32:  // space bar
    //        case 37:
    //        case 39:
    //            e.preventDefault();
    //            e.stopPropagation();
    //            break;
    //        case 38:
    //            e.preventDefault();
    //            incr_min();
    //            e.stopPropagation();
    //            break;
    //        case 40:
    //            e.preventDefault();
    //            decr_min();
    //            e.stopPropagation();
    //            break;
    //        default:
    //            break;
    //    }
    //});
});
