<%@ Page Language="C#" AutoEventWireup="true" Async="true" CodeBehind="WebForm1.aspx.cs" Inherits="Currency_Converter___ASP.NET4._8___Eng_Maged_Ali.WebForm1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Currency Converter - Eng Maged Ali</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    <style>
        .container {
            margin-top: 50px;
        }
        h2, h3 {
            color: #007bff;
        }
        #btnConvert {
            background-color: #007bff;
            color: white;
            border: none;
        }
        #btnConvert:hover {
            background-color: #0056b3;
        }
        .result-box {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-top: 20px;
        }
        .down-arrow, .up-arrow {
            position: fixed;
            font-size: 36px; /* Arrow size */
            cursor: pointer;
            color: #007bff;
            display: none; /* Hidden by default */
            background-color: rgba(255, 255, 255, 0.8); /* Light background for visibility */
            padding: 10px;
            border-radius: 5px; /* Rounded corners */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2); /* Shadow for better visibility */
            transition: background-color 0.3s; /* Smooth background color transition */
        }
        .down-arrow {
            left: 20px; /* Positioned on the left */
            bottom: 20px;
        }
        .up-arrow {
            right: 20px; /* Positioned on the right */
            bottom: 20px;
        }
        .down-arrow:hover, .up-arrow:hover {
            background-color: #e0e0e0; /* Change background on hover */
        }
        .toggle-button {
            margin-top: 20px;
            background-color: #007bff;
            color: white;
            border: none;
        }
        .toggle-button:hover {
            background-color: #0056b3;
        }
        .space {
            margin-top: 20px; /* Add space above the Get Exchange Rates button */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center">
                    <h2 class="text-center">Currency Converter - Eng Maged Ali</h2>
                    <p>Select one or more currencies from the list below and press "Get Exchange Rates".</p>

                    <!-- Toggle Button -->
                    <button type="button" class="toggle-button" id="toggleButton">Show Select Currency</button>

                    <div id="currencySection" style="display: none;">
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>Select Currency</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <div class="checkbox-container" id="pnlCurrencies" runat="server">
                                            <!-- Dynamic checkboxes will be added here -->
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="space">
                        <asp:Button ID="btnConvert" runat="server" Text="Get Exchange Rates" CssClass="btn btn-primary btn-block" OnClick="btnConvert_Click" />
                    </div>

                    <div class="result-box">
                        <h3>Exchange Rates:</h3>
                        <asp:Literal ID="litExchangeRates" runat="server"></asp:Literal>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Down Arrow -->
        <div class="down-arrow" id="downArrow">
            <i class="fas fa-chevron-down"></i>
        </div>

        <!-- Up Arrow -->
        <div class="up-arrow" id="upArrow">
            <i class="fas fa-chevron-up"></i>
        </div>
    </form>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        // Show the down arrow when the user scrolls down the page
        $(window).scroll(function () {
            if ($(this).scrollTop() > 100) {
                $('#downArrow').fadeIn();
                $('#upArrow').fadeIn(); // Show up arrow when scrolled down
            } else {
                $('#downArrow').fadeOut();
                $('#upArrow').fadeOut(); // Hide up arrow when at the top
            }
        });

        // Smooth scroll to the bottom of the page when the down arrow is clicked
        $('#downArrow').click(function () {
            $('html, body').animate({ scrollTop: $(document).height() }, 1000);
        });

        // Smooth scroll to the top of the page when the up arrow is clicked
        $('#upArrow').click(function () {
            $('html, body').animate({ scrollTop: 0 }, 1000);
        });

        // Toggle visibility of the currency selection section
        $('#toggleButton').click(function () {
            $('#currencySection').toggle(); // Toggle visibility
            $(this).text($(this).text() === 'Show Select Currency' ? 'Hide Select Currency' : 'Show Select Currency');
        });
    </script>
</body>
</html>
