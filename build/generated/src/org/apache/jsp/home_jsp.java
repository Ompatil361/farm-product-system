package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class home_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write('\n');
      out.write('\n');

    // Redirect to login if the user is not logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <title>Home - Farm Product Marketing</title>\n");
      out.write("    \n");
      out.write("    <!-- Bootstrap CSS -->\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\">\n");
      out.write("    \n");
      out.write("    <!-- Custom CSS -->\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            font-family: Arial, sans-serif;\n");
      out.write("            background: url('home.jpg') no-repeat center center fixed;\n");
      out.write("            background-size: cover;\n");
      out.write("            display: flex;\n");
      out.write("            flex-direction: column;\n");
      out.write("            justify-content: center;\n");
      out.write("            align-items: center;\n");
      out.write("            height: 100vh;\n");
      out.write("            margin: 0;\n");
      out.write("        }\n");
      out.write("        .container {\n");
      out.write("            margin-top: 50px;\n");
      out.write("        }\n");
      out.write("        .panel {\n");
      out.write("            text-align: center;\n");
      out.write("            padding: 20px;\n");
      out.write("            border-radius: 10px;\n");
      out.write("            transition: 0.3s;\n");
      out.write("            cursor: pointer;\n");
      out.write("        }\n");
      out.write("        .panel:hover {\n");
      out.write("            transform: scale(1.05);\n");
      out.write("        }\n");
      out.write("        .customer { background: #ff7043; color: white; }\n");
      out.write("        .stock { background: #42a5f5; color: white; }\n");
      out.write("        .supplier { background: #66bb6a; color: white; }\n");
      out.write("        .invoice { background: #ab47bc; color: white; }\n");
      out.write("        .profile { background: #ffa726; color: white; }\n");
      out.write("        .logout { background: #ef5350; color: white; }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("    <div class=\"container\">\n");
      out.write("        <h2 class=\"text-center\">Welcome, ");
      out.print( session.getAttribute("username") );
      out.write("!</h2>\n");
      out.write("        <div class=\"row mt-4\">\n");
      out.write("            \n");
      out.write("            <div class=\"col-md-4 mb-3\">\n");
      out.write("                <div class=\"panel customer\" onclick=\"location.href='customer.jsp'\">\n");
      out.write("                    <h4>Customer </h4>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div class=\"col-md-4 mb-3\">\n");
      out.write("                <div class=\"panel stock\" onclick=\"location.href='stock.jsp'\">\n");
      out.write("                    <h4>Stock</h4>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div class=\"col-md-4 mb-3\">\n");
      out.write("                <div class=\"panel supplier\" onclick=\"location.href='supplier.jsp'\">\n");
      out.write("                    <h4>Supplier</h4>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div class=\"col-md-4 mb-3\">\n");
      out.write("                <div class=\"panel invoice\" onclick=\"location.href='invoice.jsp'\">\n");
      out.write("                    <h4>Invoice</h4>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div class=\"col-md-4 mb-3\">\n");
      out.write("                <div class=\"panel profile\" onclick=\"location.href='myprofile.jsp'\">\n");
      out.write("                    <h4>My Profile</h4>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div class=\"col-md-4 mb-3\">\n");
      out.write("                <div class=\"panel logout\" onclick=\"location.href='logout.jsp'\">\n");
      out.write("                    <h4>Logout</h4>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <!-- Bootstrap JS -->\n");
      out.write("    <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
