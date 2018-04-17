$(window).load(function() {

    // min/max words slider and input fields -- up/down arrows only
    var isSliding = false;
    var minMaxWordsSlider_maxValue = 1000;
    var minMaxWordsSlider = $('#minMaxWordsSlider')
        .slider({
            min: 0,
            max: 5.0,
            range: true,
            tooltip: 'hide',
            value: [0.0, 5.0]
        }).on('slide', function(e) {
            $('#minwords').val(e.value[0]);
            $('#maxwords').val(e.value[1]);
        }).on('slideStart', function() {
            isSliding = true;
        }).on('slideStop', function() {
            isSliding = false;
            //game.minWords = Number($('#minwords').val());
            //var max = $('#maxwords').val();
            //game.maxWords = max === 'any' ? 0 : Number(max);
            //window.location.hash = game.toHtmlAnchor();
            //$('meta[property="og:url"]').prop('content', window.location.href + window.location.hash);
        });

    $('#minwords').change(function() {
        if (!isSliding) {
            var min = Number($(this).val());
            var max = Number($('#maxwords').val());
            if (min > max) {
                var temp = min;
                min = max;
                max = temp;
                $('#minwords').val(min);
                $('#maxwords').val(max);
            }
            // minMaxWordsSlider.slider('setValue', [min, max]);
            //game.minWords = Number($('#minwords').val());
            //var max = $('#maxwords').val();
            //game.maxWords = max === 'any' ? 0 : Number(max);
            //window.location.hash = game.toHtmlAnchor();
            //$('meta[property="og:url"]').prop('content', window.location.href + window.location.hash);
        }
    });
    $('#maxwords').change(function() {
        if (!isSliding) {
            var min = Number($('#minwords').val());
            var max = Number($(this).val());
            if (max === minMaxWordsSlider_maxValue) {
                $('#maxwords').val('any');
            } else if (min > max) {
                var temp = min;
                min = max;
                max = temp;
                $('#minwords').val(min);
                $('#maxwords').val(max);
            }
            //minMaxWordsSlider.slider('setValue', [min, max]);
            //game.minWords = Number($('#minwords').val());
            //var max = $('#maxwords').val();
            //game.maxWords = max === 'any' ? 0 : Number(max);
            //window.location.hash = game.toHtmlAnchor();
            //$('meta[property="og:url"]').prop('content', window.location.href + window.location.hash);
        }
    });
});
