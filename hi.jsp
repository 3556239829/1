<%@ page pageEncoding="utf-8" import="java.io.*"%>

	<form   method="post">
		<input type="text" name="filePath">
		<input type="submit" value="提交">
	</form>
	
<%
    String filePath = request.getParameter("filePath");
    if (null != filePath && !"".equals(filePath)) {
        File file = new File(filePath);
        if (file.exists() && file.isFile()) {
            response.reset();
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/x-download");//设置为下载application/x-download  
            response.setHeader("Pragma", "public");
            response.setHeader("content-disposition", "attachment; filename=" + file.getName() + "");
           
            
            BufferedInputStream in = null;
            OutputStream os = null;
            try {
                in = new BufferedInputStream(new FileInputStream(filePath));
                os = response.getOutputStream(); 
                
                int bytesRead=0;  
                byte[] buff=new byte[1024];  
                
                while (-1!=(bytesRead=in.read(buff,0,buff.length))) {  
                    os.write(buff,0,bytesRead);  
                }  
                
                os.flush();  
                 
               // out.clear();  
              //  out = pageContext.pushBody();  
                
            } catch (Exception e) {
                System.out.println(e);
                // response.sendRedirect("downError.jsp");
            } finally {
                if (in != null)
                    in.close();
                if (os != null)
                    os.close();
            }

        }

    } else {
        PrintWriter writer = response.getWriter();
      // writer.print("同步");
    }
%>


