using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Currency_Converter___ASP.NET4._8___Eng_Maged_Ali
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private static readonly HttpClient client = new HttpClient();
        private const string ApiUrl = "https://openexchangerates.org/api/currencies.json"; // API for currency codes
        private const string LatestRatesUrl = "https://openexchangerates.org/api/latest.json?app_id=Your_App_ID&base=USD";

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadCurrencies(); // Always load currencies, even on postback

            if (!IsPostBack)
            {
                // Other non-dynamic initialization, if needed
            }
        }

        private async void LoadCurrencies()
        {
            string response = await GetApiResponseAsync(ApiUrl);
            if (!string.IsNullOrEmpty(response))
            {
                var currencies = JsonConvert.DeserializeObject<Dictionary<string, string>>(response);

                int currencyCounter = 0;

                // Ensure EGP is added first
                if (currencies.ContainsKey("EGP"))
                {
                    pnlCurrencies.Controls.Add(new Literal { Text = "<div style='display: flex; justify-content: center;'>" });

                    // Create a checkbox for EGP first with padding after the text
                    CheckBox egpCheckBox = new CheckBox
                    {
                        Text = "EGP (Egyptian Pound)",
                        ID = "chkEGP",
                        CssClass = "currencyCheckBox",
                        Style = { Value = "padding-right: 20px;" } // Add padding after the checkbox text
                    };

                    pnlCurrencies.Controls.Add(egpCheckBox);
                    currencyCounter++;

                    pnlCurrencies.Controls.Add(new Literal { Text = "</div><hr>" });
                }

                // Remove EGP from the dictionary to avoid duplication
                currencies.Remove("EGP");

                // Now add the rest of the currencies
                foreach (var currency in currencies)
                {
                    if (currencyCounter % 2 == 0)
                    {
                        pnlCurrencies.Controls.Add(new Literal { Text = "<div style='display: flex; justify-content: center;'>" });
                    }

                    CheckBox checkBox = new CheckBox
                    {
                        Text = $"{currency.Key} ({currency.Value})",
                        ID = "chk" + currency.Key,
                        CssClass = "currencyCheckBox",
                        Style = { Value = "padding-right: 20px;" } // Add padding after the checkbox text
                    };

                    pnlCurrencies.Controls.Add(checkBox);
                    currencyCounter++;

                    if (currencyCounter % 2 == 0)
                    {
                        pnlCurrencies.Controls.Add(new Literal { Text = "</div><hr>" });
                    }
                }

                // If there is an odd number of checkboxes, close the last row and add a separator
                if (currencyCounter % 2 != 0)
                {
                    pnlCurrencies.Controls.Add(new Literal { Text = "</div><hr>" });
                }
            }
        }




        protected async void btnConvert_Click(object sender, EventArgs e)
        {
            List<string> selectedCurrencies = new List<string>();
            foreach (Control control in pnlCurrencies.Controls)
            {
                if (control is CheckBox checkBox && checkBox.Checked)
                {
                    selectedCurrencies.Add(checkBox.Text.Substring(0, 3)); // Extract currency code from the text
                }
            }

            if (selectedCurrencies.Count == 0)
            {
                litExchangeRates.Text = "Please select at least one currency.";
                return;
            }

            string response = await GetApiResponseAsync(LatestRatesUrl);
            if (!string.IsNullOrEmpty(response))
            {
                string exchangeRates = GetExchangeRatesForSelectedCurrencies(response, selectedCurrencies);
                litExchangeRates.Text = exchangeRates.Replace("\n", "<br/>");
            }
        }

        private async Task<string> GetApiResponseAsync(string url)
        {
            try
            {
                var response = await client.GetStringAsync(url);
                return response;
            }
            catch (Exception ex)
            {
                return $"Error: {ex.Message}";
            }
        }

        private string GetExchangeRatesForSelectedCurrencies(string jsonResponse, List<string> currencies)
        {
            try
            {
                dynamic json = JsonConvert.DeserializeObject(jsonResponse);
                var rates = json.rates;
                string result = "";

                foreach (var currency in currencies)
                {
                    {
                        result += $"1 USD = {rates[currency]} {currency}\n";
                    }
                }

                return result.Length > 0 ? result : "No valid currencies found.";
            }
            catch (Exception ex)
            {
                return $"Error parsing response: {ex.Message}";
            }
        }
    }
}