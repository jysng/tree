<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="titan-tracer.aspx.cs" Inherits="WebApplication2.titan_tracer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Titan Tracer</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script type="text/javascript" id="tailwind">
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        clifford: '#da373d',
                    }
                }
            }
        }
    </script>
</head>
<body>
    <div class="container mx-auto">
        <div class="max-w-xl p-5 mx-auto my-10 bg-white rounded-md shadow-sm">
            <div class="text-center">
                <h1 class="my-3 text-3xl font-semibold text-gray-700">titan tracer</h1>
                <p class="text-gray-400">Log bugs,solutions and future enhancments</p>
            </div>
            <br />
            <div>
                <form runat="server">
                    <div class="mb-6">
                        <label for="ddlSolutions" class="block mb-2 text-sm text-gray-600">
                            choose solution name</label>
                        <asp:DropDownList OnSelectedIndexChanged="ddlSolutions_SelectedIndexChanged"
                            runat="server"
                            ID="ddlSolutions"
                            AutoPostBack="true"
                            class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md  focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300">
                            <asp:ListItem Text="Select" />
                        </asp:DropDownList>
                    </div>
                    <div class="mb-6">
                        <label for="ddlProjects" class="block mb-2 text-sm text-gray-600">
                            choose project name</label>
                        <asp:DropDownList
                            runat="server"
                            ID="ddlProjects"
                            
                            AutoPostBack="true"
                            OnSelectedIndexChanged="ddlProjects_SelectedIndexChanged"
                            class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md  focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300">
                            <asp:ListItem Text="Select" />
                        </asp:DropDownList>
                    </div>

                    <div class="mb-6">
                        <label for="ddlActivities" class="block mb-2 text-sm text-gray-600">
                            choose activity name</label>
                        <asp:DropDownList
                            runat="server"
                            AutoPostBack="true"
                            ID="ddlActivities"
                            class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md  focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300">
                            <asp:ListItem Text="Select" />
                        </asp:DropDownList>
                    </div>
                    <div class="mb-6">
                        <label for="ddlTraceType" class="block mb-2 text-sm text-gray-600">
                            describe issue
                        </label>
                        <asp:DropDownList
                            runat="server"
                            ID="ddlTraceType"
                            class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md  focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300">
                            <asp:ListItem Text="Issue" Value="1" />
                            <asp:ListItem Text="Enhancment" Value="2" />
                        </asp:DropDownList>
                    </div>
                    <div class="mb-6">
                        <label for="txtIssue" class="block mb-2 text-sm text-gray-600">
                            describe issue
                        </label>
                        <asp:TextBox
                            runat="server"
                            ID="txtIssue"
                            class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md  focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300"></asp:TextBox>
                    </div>

                    <div class="mb-6">
                        <label for="txtSolution" class="block mb-2 text-sm text-gray-600">
                            describe solution
                        </label>
                        <asp:TextBox
                            runat="server"
                            ID="txtSolution"
                            class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md  focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300"></asp:TextBox>
                    </div>
                    
                    <div class="mb-6">
                        <asp:Button Text="save trace info"
                            ID="btnSave" OnClick="btnSave_Click"
                            runat="server"
                            class="w-full px-2 py-4 text-white bg-indigo-500 rounded-md  focus:bg-indigo-600 focus:outline-none"></asp:Button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
