google.load('visualization', '1', {packages:['table']});
      google.setOnLoadCallback(drawTable);
      function drawTable() {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Income');
        data.addColumn('number', 'Volume');
        data.addRows([
          ["Sales",140413],
        ]);
        data.addColumn('string', 'Income');
        data.addColumn('number', 'Volume');
		
        var table = new google.visualization.Table(document.getElementById('table'));
        table.draw(data, {showRowNumber: false});
      }
