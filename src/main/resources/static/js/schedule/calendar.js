document.addEventListener('DOMContentLoaded', function () {

    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
        },
        locale: 'ko',
        initialDate: '2023-01-12',
        navLinks: true,
        selectable: true,
        selectMirror: false,
        select: function (arg) {
            scheduleModal();
            var request = {
                title: '',
                content: '',
                color: '#43aef2',
                sid: '',
                memberList: [],
                startDateType: "date",
                endDateType: "date",
                startDateValue: arg.startStr,
                endDateValue: arg.startStr
            };

            scheduleModalSetting(request);
            editScheduleSetting();
            calendar.unselect();
        },
        eventClick: function (arg) {
            scheduleModal();
            // 해당 일정에 대한 시간 처리
            var start = toLocalISOString(arg.event.start);
            var end = toLocalISOString(arg.event.end);
            var startDateType = "datetime-local";
            var endDateType = "datetime-local";
            var startDateValue = start;
            var endDateValue = end;
            if (arg.event._def.allDay) {
                startDateType = "date";
                endDateType = "date";
                startDateValue = changeDateTimeToDate(start);
                var tmp = new Date(end);
                endDateValue = changeDateTimeToDate(toLocalISOString(tmp.setDate(tmp.getDate() - 1)));
            }

            var request = {
                title: arg.event._def.title,
                content: arg.event._def.extendedProps.content,
                color: arg.event._def.ui.backgroundColor,
                sid: arg.event._def.extendedProps.sid,
                memberList: arg.event._def.extendedProps.memberList,
                startDateType: startDateType,
                endDateType: endDateType,
                startDateValue: startDateValue,
                endDateValue: endDateValue
            };

            scheduleModalSetting(request);
        },
        editable: true,
        dayMaxEvents: true, // allow "more" link when too many events
        events: function (fetchInfo, successCallback, failureCallback) {
            getScheduleList(successCallback);  // Fetch가 완료되면 successCallback에 데이터가 전달됩니다.
        }
    });

    calendar.render();
});