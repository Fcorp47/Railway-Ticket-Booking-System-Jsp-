<%-- 
    Document   : AdminController
    Created on : 6 Nov, 2022, 10:41:24 PM
    Author     : Asus
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.RTS.Model.TrainModel"%>
<%@page import="com.RTS.DAO.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%


int trainno = Integer.parseInt(request.getParameter("trainno"));
            int nostack = Integer.parseInt(request.getParameter("txtstack"));
            String seat_type = request.getParameter("stacktype");
            
            UserDAO objdao = new UserDAO();
            TrainModel m = new TrainModel();
            m.setTID(trainno);
            
            List tlist = new ArrayList();
            for(int i=1; i<=nostack; i++)
            {
                tlist.add(i);
            }
            String Stackf = tlist.toString();
            int i = objdao.updateTrain(trainno, seat_type, Stackf);
            
            if(i==1)
            {
                out.print("updated success");
            }
            else
            {
                out.print("update failed");
            }
            


%>