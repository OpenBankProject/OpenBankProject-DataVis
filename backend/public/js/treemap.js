google.load("visualization", "1", {packages:["treemap"]});

function drawVisualization() {
          $.getJSON("js/treemap.json", function(json){

          data = new google.visualization.DataTable()
          data.addColumn('string', 'Category');
          data.addColumn('string', 'Parent');
          data.addColumn('number', 'Volume')
          data.addColumn('number', 'Heat') // in = +1, out = -1

          var row = [];
          row.push(["ALL", null, 0, 0 ])
          $.each(json, function(i,item){
            if (item.parent === null) item.parent = "ALL"
            row.push([item.name, item.parent, item.volume, parseInt(Math.random()*200)-100]);
          });
          console.log(row)
          data.addRows(row);

        // Create and draw the visualization.
        new google.visualization.TreeMap(document.getElementById('treemap')).
            draw(data, {minColor: '#ffa500',
          midColor: '#ddd',
          maxColor: '#0d0',
          headerHeight: 30,
          fontColor: 'black',
          showScale: false,
          maxPostDepth: '3'}
                );
        });       
      }
      google.setOnLoadCallback(drawVisualization);