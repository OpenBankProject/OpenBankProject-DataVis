google.load('visualization', '1', {packages:['table']});
      google.setOnLoadCallback(drawTable);
      
      function drawTable() {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'KPI');
        data.addColumn('number', 'Value');
        data.addRows([
          ["Avg Bm Rate",140413],
          ["Balance (overall)",140413],
          ["Income last month",6000],
          ["Expense last month",4000],
          ["Profit last month",2000],
        ]);
		
        var table = new google.visualization.Table(document.getElementById('combotoptable'));
        table.draw(data, {showRowNumber: false});
      }
