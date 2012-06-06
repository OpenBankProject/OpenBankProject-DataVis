google.load('visualization', '1', {packages:['table']});
      google.setOnLoadCallback(drawTable);
      drawVisualization("js/sales.json");

      function drawVisualization(url) {
        $.getJSON(url, function(json){
          data = new google.visualization.DataTable();
          data.addColumn('string', 'Name');
          data.addColumn('number', 'Volume');
          rows = [];
           $.each(json, function(i,item){
            if (item)
              rows.push([item.name,item.volume])
           });
           data.addRows(rows);

          var table = new google.visualization.Table(document.getElementById('treemaptable'));
           table.draw(data, {
            title: 'Account',
            pieSliceText: 'value/100',
            sliceVisibilityThreshold: 1/100,
          }
                );
        });

        

      }