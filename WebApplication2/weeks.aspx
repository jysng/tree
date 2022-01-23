<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="weeks.aspx.cs" Inherits="WebApplication2.weeks" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>weeks in life</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script>

        function weeksBetween(d1, d2) {
            return Math.round((d2 - d1) / (7 * 24 * 60 * 60 * 1000));
        }

        //var btn = document.createElement("div");
        window.onload = function () {
            var dv = document.getElementById("weeks");
            alert(dv.innerHTML);
            total_weeks = weeksBetween(new Date(1988, 2, 8), new Date());
            for (var i = 0; i < total_weeks - 1; i++) {
                var btn = document.createElement("div");
                btn.className = "col bg-warning text-warning m-1";

                btn.innerHTML = 0;
                dv.append(btn);
            }
        };




    </script>
</head>
<body>
    <div class="container">
        <div class="row" id="weeks">
        </div>
    </div>

    <form>
    </form>
</body>
</html>
