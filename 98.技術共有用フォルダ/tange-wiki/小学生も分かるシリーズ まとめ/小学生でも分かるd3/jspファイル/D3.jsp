<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="utf-8">
	<title>D3</title>
	<style>                    //グラフのメモリのスタイル設定
		.axis path, axis line{
			fill : none;
			stroke : black;
			}
		.axis text{
			font-size : 11px;
			}
	</style>
</head>
<body>
<div id = "circle1"></div>
<div id = "circle2"></div>
<div id = "rect"></div>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.6/d3.min.js" charset="utf-8"></script>

	<script>

		var dataset = [11,24,36,47,21,16];           //使用するデータ

		var h = 200;                                 //SVG領域の縦幅
		var w = 700;                                 //SVG領域の横幅

		var svg = d3.select("#circle1").append("svg").attr({ height:h, width:w });                       //SVG領域を作る場所の指定と領域の大きさの指定


		svg.selectAll("circle")
			.data(dataset)
			.enter()
			.append("circle")
			.transition()                            //アニメーションをつける
			.delay(function(d,i){                    //動きをずらす
					return i * 300;
					})
			.duration(1000)                          //表示速度
			.ease("bounce")                          //表示にアクションをつける
			.each("start",function(){                //表示前のアクション
				d3.select(this).attr({
				fill : "silver",
				r : 0,
				cy : h
				});
				})
			.attr({
				cx: function(d, i){ return 50 + ( i * 100 ); },
				cy: h / 2,
				r : function(d){ return d; },
				fill : "red"
				})
			.each("end",function(){                  //表示後のアクション
				d3.select(this)
				.transition()
				.duration(1000)
				.attr({
					fill : "gold",
					r : 0,
					cy : 0
					});
				});
	</script>


	<script>
		var dataset = [11,24,36,47,21,16];           //使用するデータ

		var h = 200;                                 //SVG領域の縦幅
		var w = 700;                                 //SVG領域の横幅

		var svg = d3.select("#circle2").append("svg").attr({ height:h, width:w });                       //SVG領域を作る場所の指定と領域の大きさの指定


		svg.selectAll("circle")
			.data(dataset)
			.enter()
			.append("circle")
			.on("mouseover",function(d){                            //マウスが上に来た時のイベント
				d3.select(this).attr("fill","orange");
			})
			.on("mouseout",function(d){                             //マウスが離れた時のイベント
				d3.select(this).attr("fill","green");
			})
			.on("click",function(d){                                //クリックしたときのイベント
				var rs = d3.select(this).attr("r");
				alert(rs);
			})
			.attr({
				cx: function(d, i){ return 50 + ( i * 100 ); },
				cy: h / 2,
				r : function(d){ return d; },
				fill : "red"
				});

	</script>
	<script>
		var dataset = [11,24,36,47,21,16,34];

		var h = 200;
		var w = 500;
		var padding = 50;                                                             //余白

		var xScale = d3.scale.linear()                                                //入力と出力の調整
			.domain([0, d3.max(dataset)])
			.range([padding, w - padding])
			.nice();

		var yScale = d3.scale.ordinal()                                               //入力と出力の返還？
		    .domain(["","a","b","c","d","e","f","g",""])
			.range([0,10,35,60,85,110,135,160,185]);


		var svg = d3.select("#rect").append("svg").attr({ height:h, width:w });

		var xAxis = d3.svg.axis()                                                     //横軸のメモリ
			.scale(xScale)
			.orient("bottom")
			.tickFormat(function(d){ return d+"人"; })                                //メモリに単位をつける
			.ticks(4);                                                                //目盛の間隔の設定

		var yAxis = d3.svg.axis()                                                     //縦軸のメモリ
		    .scale(yScale)
		    .orient("left");

		svg.append("g")                                                               //横軸の配置、設定
			.attr({
				class : "axis",
				transform : "translate(0, 180)"
				})
			.call(xAxis)
			.append("text")                                                           //軸に単位をつける
			.attr("y",18)
			.attr("x",465)
			.text("(人数)");

		svg.append("g")                                                               //縦軸の配置、設定
			.attr({
				class : "axis",
				transform : "translate(50, 0)"
				})
			.call(yAxis);

		svg.selectAll("rect")                                                         //グラフの設定
			.data(dataset)
			.enter()
			.append("rect")
			.attr({
				x : padding,
				y : function(d, i){return i * 25; },
				width : function(d){return xScale(d) - padding ; },
				height : 20,
				fill : "rgba(0,0,200,0.5)"
				});

	</script>
</body>
</html>