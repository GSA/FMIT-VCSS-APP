<%@ Control Language="C#" ClassName="ModalWarning" %>
<script type="text/javascript">
    $(document).ready(function () {
        if (get_cookie("vcss_warning") != "agree") {
            launchWindow('#dialog');
        }

        //if close button is clicked
        $('.window #btnok').click(function () {
            $('#mask').hide();
            $('.window').hide();
            document.cookie = "vcss_warning=agree"
        });

        $(window).resize(function () {

            var box = $('#modalpopup .window');

            //Get the screen height and width
            var maskHeight = $(document).height();
            var maskWidth = $(window).width();

            //Set height and width to mask to fill up the whole screen
            $('#mask').css({ 'width': maskWidth, 'height': maskHeight });

            //Get the window height and width
            var winH = $(window).height();
            var winW = $(window).width();

            //Set the popup window to center
            box.css('top', winH / 2 - box.height() / 2);
            box.css('left', winW / 2 - box.width() / 2);

        });
    });

    function get_cookie(Name) {
        var search = Name + "="
        var returnvalue = "";
        if (document.cookie.length > 0) {
            offset = document.cookie.indexOf(search)
            if (offset != -1) {
                offset += search.length
                // set index of beginning of value
                end = document.cookie.indexOf(";", offset);
                // set index of; end of cookie value
                if (end == -1) end = document.cookie.length;
                returnvalue = unescape(document.cookie.substring(offset, end))
            }
        }
        return returnvalue;
    }

    function launchWindow(id) {

        //Get the screen height and width
        var maskHeight = $(document).height();
        var maskWidth = $(window).width();

        //Set heigth and width to mask to fill up the whole screen
        $('#mask').css({ 'width': maskWidth, 'height': maskHeight });

        //transition effect		
        $('#mask').fadeIn(1000);
        $('#mask').fadeTo("slow", 0.8);

        //Get the window height and width
        var winH = $(window).height();
        var winW = $(window).width();

        //Set the popup window to center
        $(id).css('top', winH / 2 - $(id).height());
        $(id).css('left', winW / 2 - $(id).width() / 2);

        //transition effect
        $(id).fadeIn(2000);
    }

</script>
<div id="modalpopup">
    <div id="dialog" class="window">
        <div style="display: block;" class="marginB10">
            ******************************** WARNING ********************************
        </div>
        <div style="text-align: center; display: block;" class="marginB10">
            <b>YOU HAVE CONNECTED TO A U.S. GOVERNMENT COMPUTER IF YOU ARE NOT AUTHORIZED TO ACCESS
                THIS SYSTEM, DISCONNECT NOW.</b></div>
        <div style="display: block; text-align: left;" class="marginB10">
            All attempts to access and use this system and/or its resources are subject to keystroke
            monitoring and recording. Everyone using this system expressly consents to such
            monitoring and is advised that if such reveals possible evidence of criminal activity
            or abuse of authority, the information will be reported to authorities for action.
            Unauthorized access attempts or use in excess of documented authority may subject
            you to a fine and/or imprisonment in accordance with Title 18, USC, Section 1030
            or administrative penalties or dismissal.</div>
        <div style="display: block;" class="marginB10">
            ******************************** WARNING ********************************
        </div>
        <div style="text-align: center;">
            <input id="btnok" type="button" value="OK" style="width: 100px;" /></div>
    </div>
    <div id="mask">
    </div>
</div>
