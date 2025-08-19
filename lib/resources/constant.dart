const String song1 = "https://gennii.com/test_audio/1_copy.mpeg";
const String song2 = "https://gennii.com/test_audio/2_copy.mpeg";
const String song3 = "https://gennii.com/test_audio/3_copy.mpeg";
const String song4 = "https://gennii.com/test_audio/4_copy.mpeg";
const String song5 = "https://gennii.com/test_audio/5_copy.mpeg";

const String clientId = "d62111b1";
const String clientSecretId = "56ee384fc386b9e59c364c05c279cd64";

String baseUrl =
    "https://api.jamendo.com/v3.0/tracks/?client_id=$clientId&format=json&limit=5";

// 📊 Monthly Sales Report
const aiResponse = """
# 📊 **Monthly Sales Report**

Here's the performance summary for **Q1 2025** 🚀

---

## 🌟 **Key Highlights**
- 📦 **January:** Strong performance in **electronics**.  
- 🌧 **February:** Slight dip due to supply chain delays.  
- 🎉 **March:** *Record-breaking month* with **new product launch**.

---

## 📅 **Sales Table**
| 📆 Month   | 💵 Sales (\$) | 📈 Growth (%) |
|------------|--------------|---------------|
| 🗓 January | **20,000**   | 🔼 10%         |
| 🗓 February| **18,000**   | 🔽 -10%        |
| 🗓 March   | **25,000**   | 🚀 39%         |


## 📉 **Chart Data**
```json
{
  "labels": ["January", "February", "March"],
  "values": [20000, 18000, 25000]
}
""";
const weatherReport = """
## Weekly Weather Forecast

Here's the 7-day forecast for **New York City**:

### Key Points
- **Monday:** Sunny, high of 28°C.
- **Tuesday:** Light showers in the afternoon.
- **Wednesday:** Thunderstorms likely in the evening.
- **Thursday:** Clear skies, perfect for outdoor activities.
- **Friday:** Slightly cloudy but warm.
- **Saturday:** Light drizzle expected in the morning.
- **Sunday:** Sunny and pleasant.

### Temperature Table
| Day       | Temp (°C) | Condition       |
|-----------|-----------|----------------|
| Monday    | 28        | Sunny           |
| Tuesday   | 25        | Light showers   |
| Wednesday | 23        | Thunderstorms   |
| Thursday  | 27        | Clear           |
| Friday    | 26        | Cloudy          |
| Saturday  | 24        | Drizzle         |
| Sunday    | 29        | Sunny           |

### Temperature Chart Data
```json
{
  "labels": ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
  "values": [28, 25, 23, 27, 26, 24, 29]
}```
""";

const fitnessReport = """
## Monthly Fitness Progress

Tracking results for **John Doe** in **March 2025**:

### Achievements
- **Weight Loss:** 3.2 kg.
- **Workout Days:** 20 days.
- **Calories Burned:** Avg 500/day.
- **Best Activity:** Running.

### Workout Table
| Week | Distance Run (km) | Calories Burned |
|------|------------------|-----------------|
| 1    | 15               | 3,500           |
| 2    | 18               | 3,800           |
| 3    | 20               | 4,000           |
| 4    | 22               | 4,200           |

### Distance Chart Data
```json
{
  "labels": ["Week 1", "Week 2", "Week 3", "Week 4"],
  "values": [15, 18, 20, 22]
}
```
""";

const financeReport = """
## Q2 2025 Portfolio Analysis

### Highlights
- **Top Performer:** Tesla (TSLA) +15% growth.
- **Lowest Performer:** Meta (META) -4%.
- **Overall Growth:** +7% this quarter.

### Portfolio Table
| Stock  | Value (\$) | Growth (%) |
|--------|-----------|------------|
| TSLA   | 12,000    | 15%        |
| AAPL   | 9,500     | 8%         |
| META   | 7,200     | -4%        |
| AMZN   | 10,000    | 5%         |

### Portfolio Chart Data
```json
{
  "labels": ["TSLA", "AAPL", "META", "AMZN"],
  "values": [12000, 9500, 7200, 10000]
}```
""";

const bitcoinVsEtherium = """
# 💰 Bitcoin vs 🌐 Ethereum - The Crypto Showdown

---

## 🏁 Introduction
Both **Bitcoin (₿)** and **Ethereum (Ξ)** are cryptocurrency giants, but they shine in different arenas:

- **Bitcoin:** 🪙 *Digital gold* - focused on payments & store of value.  
- **Ethereum:** ⚙️ *World computer* - powering smart contracts & decentralized apps.

---

## 📊 Quick Comparison Table

| Feature              | 💰 Bitcoin (BTC)              | 🌐 Ethereum (ETH)            |
|----------------------|------------------------------|------------------------------|
| 🚀 Launch Year       | 2009                         | 2015                         |
| 👨‍💻 Founder         | Satoshi Nakamoto              | Vitalik Buterin & Team       |
| 🎯 Main Purpose      | Digital currency, value store| Smart contracts, DApps       |
| 🛡️ Consensus        | Proof-of-Work (PoW)           | Proof-of-Stake (PoS)         |
| ⏱ Block Time         | ⏳ ~10 mins                   | ⚡ ~12 secs                   |
| 📦 Max Supply        | 21M BTC                      | No fixed limit               |
| 🛠 Languages         | Script                       | Solidity, Vyper              |

---

## 🔍 Key Differences
1. **Purpose**  
   - *Bitcoin:* 🪙 Secure, borderless peer-to-peer money.  
   - *Ethereum:* ⚙️ Programmable blockchain for endless possibilities.

2. **Supply**  
   - *Bitcoin:* 📉 Fixed at 21 million - scarcity drives value.  
   - *Ethereum:* ♾ Adaptive supply for network growth.

3. **Speed**  
   - *Bitcoin:* 🐢 Slower but more secure.  
   - *Ethereum:* 🚀 Faster & ideal for dApps.

4. **Ecosystem**  
   - *Bitcoin:* 💳 Focused on payments & transfers.  
   - *Ethereum:* 🎨 Home to NFTs, DeFi, DAOs.

---

## 👍 Pros & 👎 Cons

**Bitcoin 🪙**
✅ Strong brand & adoption  
✅ Proven security over time  
✅ Deflationary supply  
❌ Limited functionality beyond payments  
❌ Slower transactions  

**Ethereum 🌐**
✅ Supports smart contracts & dApps  
✅ Faster transaction speed  
✅ Expanding ecosystem (NFTs, DeFi)  
❌ No max supply cap  
❌ More complex & evolving

---

## 📈 Price Trend Snapshot

```json
{
  "labels": ["Jan 2025", "Feb 2025", "Mar 2025"],
  "bitcoin": [42000, 45000, 47000],
  "ethereum": [2300, 2500, 2700]
}
```

""";
const bitcoinDetails = """
# Bitcoin (BTC) - Overview

## 1. Introduction
Bitcoin is the **first decentralized cryptocurrency**, created in 2009 by an unknown person or group of people using the pseudonym **Satoshi Nakamoto**.  
It operates on a peer-to-peer network without the need for intermediaries like banks.

---

## 2. Key Features
- **Decentralized:** No central authority controls it.
- **Limited Supply:** Maximum supply capped at **21 million BTC**.
- **Secure:** Uses blockchain technology and cryptographic algorithms.
- **Transparent:** All transactions are recorded on a public ledger.

---

## 3. Technical Details
| Property            | Details                               |
|---------------------|---------------------------------------|
| Launch Year         | 2009                                  |
| Consensus Mechanism | Proof-of-Work (PoW)                   |
| Block Time          | ~10 minutes                           |
| Supply Limit        | 21 million BTC                        |
| Smallest Unit       | Satoshi (0.00000001 BTC)              |

---

## 4. Advantages
1. **Borderless Transactions** - Send and receive anywhere in the world.
2. **Low Transaction Fees** - Especially for cross-border payments.
3. **Transparency** - Public blockchain ledger.
4. **Security** - Highly resistant to fraud and hacking.

---

## 5. Risks & Challenges
- **Price Volatility** - Value can fluctuate rapidly.
- **Regulatory Uncertainty** - Different countries have different laws.
- **Irreversible Transactions** - Mistaken transfers cannot be undone.
- **Energy Consumption** - Mining requires significant electricity.

---

## 6. Recent Price Trends
```json
{
  "labels": ["Jan 2025", "Feb 2025", "Mar 2025"],
  "values": [42000, 45000, 47000]
}```
""";

const mathSolution = """
## Math Problem

**Question:** What is 2 + 2?

---

### Step-by-Step Solution
1. **Identify the numbers:** 2 and 2.
2. **Operation:** Addition (`+`).
3. **Add them together:**
2+2=4

4. **Result:** The sum is **4**.

---

### Quick Table
| Number 1 | Number 2 | Operation | Result |
|----------|----------|-----------|--------|
| 2        | 2        | +         | 4      |

---

### Final Answer
**✅ 2 + 2 = 4**
""";
