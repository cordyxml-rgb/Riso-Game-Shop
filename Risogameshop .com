<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Riso Game Shop - MLBB Top Up</title>
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background-color: #0f172a;
      color: white;
      margin: 0;
      padding: 0;
    }
    header {
      background: #1e293b;
      text-align: center;
      padding: 20px;
      border-bottom: 2px solid #38bdf8;
    }
    header h1 {
      margin: 0;
      color: #38bdf8;
      font-weight: 700;
    }
    header p {
      color: #94a3b8;
    }
    .login-box, .payment-box, .game-card {
      background: #1e293b;
      border-radius: 12px;
      padding: 20px;
      margin: 20px auto;
      width: 90%;
      max-width: 500px;
      box-shadow: 0 0 15px rgba(0,0,0,0.4);
    }
    h2 {
      color: #38bdf8;
      margin-bottom: 15px;
    }
    label {
      display: block;
      margin-bottom: 5px;
    }
    input {
      width: 100%;
      padding: 10px;
      margin-bottom: 15px;
      border: none;
      border-radius: 6px;
      background: #334155;
      color: white;
    }
    input::placeholder {
      color: #94a3b8;
    }
    .btn {
      width: 100%;
      background: #38bdf8;
      color: black;
      padding: 12px;
      border: none;
      border-radius: 6px;
      font-weight: bold;
      cursor: pointer;
    }
    .btn:hover {
      background: #0ea5e9;
    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    th, td {
      padding: 10px;
      text-align: left;
    }
    tr:nth-child(even) {
      background: #334155;
    }
    footer {
      text-align: center;
      padding: 20px;
      color: #94a3b8;
      background: #1e293b;
      margin-top: 20px;
      font-size: 14px;
      line-height: 1.6;
    }
    .contact {
      color: #38bdf8;
      font-weight: bold;
    }
  </style>
</head>
<body>

  <header>
    <h1>🎮 Riso Game Shop</h1>
    <p>Trusted MLBB Top-Up Service</p>
  </header>

  <!-- Login Box -->
  <div class="login-box">
    <h2>🔐 Account Login</h2>
    <form>
      <label for="email">Gmail</label>
      <input type="email" id="email" placeholder="Enter your Gmail" required>

      <label for="password">Password</label>
      <input type="password" id="password" placeholder="Enter your password" required>

      <button type="submit" class="btn">Login</button>
    </form>
  </div>

  <!-- Payment Box -->
  <div class="payment-box">
    <h2>💰 Payment Information</h2>
    <form>
      <p>Wave Pay Name: <b>Ei Ei Thander</b></p>
      <p>Wave Pay Number: <b>09779454083</b></p>
      <input type="text" placeholder="Enter your payment name" required>
      <input type="text" placeholder="Enter your payment phone number" required>
      <button type="submit" class="btn">Confirm Payment</button>
    </form>
  </div>

  <!-- Game Card -->
  <div class="game-card">
    <h2>💎 MLBB Diamonds</h2>
    <table id="diamondTable">
      <tr><th>Amount</th><th>Price (Ks)</th></tr>
      <tr data-amount="Weekly Pass"><td>Weekly Pass</td><td>5950</td></tr>
      <tr data-amount="86"><td>86</td><td>4950</td></tr>
      <tr data-amount="172"><td>172</td><td>9700</td></tr>
      <tr data-amount="257"><td>257</td><td>14150</td></tr>
      <tr data-amount="343"><td>343</td><td>19750</td></tr>
      <tr data-amount="429"><td>429</td><td>24300</td></tr>
      <tr data-amount="600"><td>600</td><td>33800</td></tr>
    </table>
    <button class="btn" onclick="orderDiamond()">Order Now</button>
  </div>

  <footer>
    © 2025 Riso Game Shop | Payment via WavePay (Ei Ei Thander - 09779454083)<br>
    💎 If your Diamonds don’t arrive, please contact <span class="contact">09779454083</span>
  </footer>

  <script>
    function orderDiamond() {
      const username = prompt("Enter your Telegram username (without @):");
      const userId = prompt("Enter your ID:");
      const amount = prompt("Enter Diamond amount you want:");

      if(!username || !userId || !amount) {
        alert("All fields are required!");
        return;
      }

      // Telegram Bot Info
      const botToken = "YOUR_BOT_TOKEN_HERE";  // @Riso_Prd_list_bot token
      const chatId = "YOUR_CHAT_ID_HERE";      // Telegram chat ID to receive orders
      const message = `Order လုပ်လိုက်ပါတယ်!\n\nUser Name - ${username}\nId - ${userId}\nAmount - ${amount}\nCommand: /prdzs`;

      fetch(`https://api.telegram.org/bot${botToken}/sendMessage`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          chat_id: chatId,
          text: message
        })
      })
      .then(res => res.json())
      .then(data => {
        if(data.ok) {
          alert("Order sent successfully to @Riso_Prd_list_bot!");
        } else {
          alert("Failed to send order. Check bot token and chat ID.");
        }
      })
      .catch(err => {
        console.error(err);
        alert("Error sending order.");
      });
    }
  </script>

</body>
</html>
