# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
###
# Welcome to the new js2coffee 2.0, now
# rewritten to use the esprima parser.
# try it out!
###
$(document).on 'turbolinks:load', ->
	console.log('showed', $("#container2").length)
	if $('#container2').length > 0
		console.log('showed2')
		$('#suhu').sevenSeg
			value: 0
			digits: 3
		$('#kelembaban').sevenSeg
			value: 0
			digits: 3
		Highcharts.setOptions global: useUTC: false
		Highcharts.chart 'container2',
			chart:
				zoomType: 'xy'
				events: load: ->
					# set up the updating of the chart each second
					seriesTemp = @series[1]
					seriesHum = @series[0]
					console.log @series
					setInterval (->
						$.ajax '/dashboard/data',
							type: 'GET'
							dataType: 'json'
							error: (data, textStatus, errorThrown) ->
								console.log 'AJAX ERROR : ', textStatus
								return
							success: (data, textStatus, jqXHR) ->
								x = (new Date(data.created_at)).getTime()
								y = Math.random()
								seriesHum.addPoint [
									x
									data.value_hum
								], true, true
								seriesTemp.addPoint [
									x
									data.value_temp
								], true, true
								$('#suhu').sevenSeg
									value: data.value_temp
									digits: 3
								$('#kelembaban').sevenSeg
									value: data.value_hum
									digits: 3
								return
						return
					), 5000
					return
			title: text: 'Data temperature dan humadity ruangan secara realtime'
			subtitle: text: 'Alat ukur menggunakan DHT22 dan Arduino'
			xAxis:
				type: 'datetime'
				tickPixelInterval: 150
				crosshair: true
			yAxis: [
				{
					labels:
						format: '{value}°C'
						style: color: Highcharts.getOptions().colors[1]
					title:
						text: 'Temperature'
						style: color: Highcharts.getOptions().colors[1]
				}
				{
					labels:
						format: '{value}%'
						style: color: Highcharts.getOptions().colors[0]
					title:
						text: 'Humidity'
						style: color: Highcharts.getOptions().colors[0]
					opposite: true
				}
			]
			tooltip: shared: true
			legend:
				layout: 'vertical'
				align: 'left'
				x: 120
				verticalAlign: 'top'
				y: 100
				floating: true
				backgroundColor: Highcharts.theme and Highcharts.theme.legendBackgroundColor or '#FFFFFF'
			exporting: enabled: false
			series: [
				{
					name: 'Humidity'
					type: 'spline'
					yAxis: 1
					tooltip: valueSuffix: '%'
					data: do ->
						# generate an array of random data
						data = []
						time = (new Date).getTime()
						`i = -19`
						while i <= 0
							data.push
								x: time + i * 1000
								y: 0
							`i += 1`
						data
				}
				{
					name: 'Temperature'
					type: 'spline'
					tooltip: valueSuffix: '°C'
					data: do ->
						# generate an array of random data
						data = []
						time = (new Date).getTime()
						`i = -19`
						while i <= 0
							data.push
								x: time + i * 1000
								y: 0
							`i += 1`
						data
				}
			]
		return

# ---
# generated by js2coffee 2.2.0