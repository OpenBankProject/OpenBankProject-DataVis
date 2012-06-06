      google.load("visualization", "1", {packages:["corechart"]});    
    
       drawVisualization("js/sales.json")

      function drawVisualization(url) {
        // Create and populate the data table.
         $.getJSON(url, function(json){

          data = new google.visualization.DataTable()
          data.addColumn('string', 'Payee');
          data.addColumn('number', 'Volume')
          var row = [];
          $.each(json, function(i,item){
            row.push([item.name, item.volume]);
          });
          data.addRows(row);
        
        // Create and draw the visualization.
        new google.visualization.PieChart(document.getElementById('pie')).
            draw(data, {
            title: 'Account',
            pieSliceText: 'value/100',
            sliceVisibilityThreshold: 1/100,
          }
                );
        });
      }
      //google.setOnLoadCallback(drawVisualization);
