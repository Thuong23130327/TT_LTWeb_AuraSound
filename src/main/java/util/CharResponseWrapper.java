package util;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;

import java.io.CharArrayWriter;
import java.io.PrintWriter;

public class CharResponseWrapper extends HttpServletResponseWrapper {
    private CharArrayWriter output = new CharArrayWriter();
    public CharResponseWrapper(HttpServletResponse response) {
        super(response);
    }

    public PrintWriter getWriter() {
        return new PrintWriter(output);
    }

    public String toString() {
        return output.toString();
    }
}
