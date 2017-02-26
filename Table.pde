//////////////////////////////////////////////////////
//                                                  //
//                a gift from ben                   //
//                                                  //
//////////////////////////////////////////////////////

class Table {
  int rowCount;
  String[][] data;
  String[] rowNames;

  Table(String filename) {
    String[] rows = loadStrings(filename);
    data = new String[rows.length][];
    for (int i = 0; i < rows.length; i++) {
      if (trim(rows[i]).length() == 0) {
        continue; // skip empty rows
      }
      if (rows[i].startsWith("#")) {
        continue;  // skip comment lines
      }
      // split the row on the tabs
      String[] pieces = split(rows[i], '\t');
      // copy to the table array
      data[rowCount] = pieces;
      rowCount++;
      // this could be done in one fell swoop via:
      //table[rowCount++] = split(rows[i], '\t');
    }
    // resize the 'data' array as necessary
    data = (String[][]) subset(data, 0, rowCount);
  }

  int getRowCount() {
    return rowCount;
  }

  String getRowName(int rowIndex) {
    return data[rowIndex][0];
  }

  String[] getRowNames() {
    // this is a potentially time-consuming function (if there are 40,000 lines, for instance)
    // so only get the names when asked, and then keep a copy around for later use
    if (rowNames == null) {
      rowNames = new String[rowCount];
      for (int i = 0; i < rowCount; i++) {
        rowNames[i] = getString(i, 0);
      }
    }
    return rowNames;
  }

  // find a row by its name, returns -1 if no row found
  int getRowIndex(String name) {
    for (int i = 0; i < rowCount; i++) {
      if (data[i][0].equals(name)) {
        return i;
      }
    }
    println("No row named '" + name + "' was found");
    return -1;
  }

  String getString(int rowIndex, int column) {
    return data[rowIndex][column];
  }

  String getString(String rowName, int column) {
    return getString(getRowIndex(rowName), column);
  }

  float getInt(String rowName, int column) {
    return parseFloat(getString(rowName, column));
  }

  float getInt(int rowIndex, int column) {
    return parseFloat(getString(rowIndex, column));
  }

  float getFloat(String rowName, int column) {
    return parseFloat(getString(rowName, column));
  }

  float getFloat(int rowIndex, int column) {
    return parseFloat(getString(rowIndex, column));
  }
}
