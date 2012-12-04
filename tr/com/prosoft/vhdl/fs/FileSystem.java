// Very simple "filesystem" manager.
// We do here the following:
//  - we keep a dictionary between file names and their contents.
//  - we allow streaming access for file contents (both read wnd write).
//  - we check filenames and redirect to usual file system requests
//    when we encounter file names that do not start with "eide:" prefix.
// We don't here:
//  - locking, arbitrary access, etc. All the usual stuff of operating system.

package com.prosoft.vhdl.fs;

import java.util.*;
import java.io.*;

// The implementation.
public class FileSystem {

	// our distinguished prefix:
	public static final String prefix = "eide_file__";

	static String onlyFileName(String fn) {
		File f = new File(fn);
		//System.err.println("fn "+fn);
		//System.err.println("getName "+f.getName());
		return f.getName();
	}

	// Check if filename belongs to our FS.
	public static final boolean isFSName (String fn) {
		return onlyFileName(fn).indexOf(prefix) == 0;
	}

	// Content of our files.
	static HashMap<String,String> fileContent =
		new HashMap<String,String>();

	// Setting the content of the file.
	// We don't check for correct filename!
	static public void setFileContent(String name, String content) {
		fileContent.put(name,content);
	}

	// check if file is a file.
	static public boolean isFile(File f) {
		//System.err.println("Checking if "+f+" is a file.");
		if (isFSName(f.getName()))
			return fileContent.containsKey(onlyFileName(f.getName()));
		//System.err.println("Fall to Java checking.");
		return f.isFile();
	}

	// Opening a file for reading.
	static public LineNumberReader openRead(String fileName) throws IOException  {
		Reader rd;
		//System.err.println("opening "+fileName+"("+onlyFileName(fileName)+")");
		if (isFSName(fileName)) {
			String content = fileContent.get(onlyFileName(fileName));
			//System.err.println("managed file, content:\n---------\n"+content+"--------\n");
			rd = new StringReader(content);
		} else {
			rd = new FileReader(new File(fileName));
		}
		return new LineNumberReader(rd);
	}

}

