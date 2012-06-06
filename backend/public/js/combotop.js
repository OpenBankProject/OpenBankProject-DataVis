google.load('visualization', '1', {packages: ['corechart']});

	  function drawVisualization() {

     $.getJSON("js/combotop.json", function(json){
          data = new google.visualization.DataTable()
          data.addColumn('string', 'Month');
          data.addColumn('number', 'Income');
          data.addColumn('number', 'Expenses')
          data.addColumn('number', 'Balance')

          var row = [];
          $.each(json, function(i,item){
            row.push([item.name, item.income, item.expenses, item.balance]);
          });
          console.log(row)
          data.addRows(row);
        
        // Create and draw the visualization.
        new google.visualization.ComboChart(document.getElementById('combotop')).
            draw(data,          {title : 'Income & Expenses',
          vAxis: {title: "Euro"},
          hAxis: {title: "Month"},
          seriesType: "bars",
          series: {2: {type: "line", lineWidth: "3"}} }
                );
        });

      }
	  
      
      google.setOnLoadCallback(drawVisualization);