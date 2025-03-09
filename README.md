# DApp-EcoToken

## 📌 Project Description  
DApp-EcoToken is a **decentralized application (DApp)** designed to reward users for performing environmentally friendly activities. The project consists of:  

- **Smart Contracts** (Solidity) for the token logic (minting, transferring, etc.).  
- **Backend** (Node.js/Express) to handle business logic (work-in-progress).  
- **Frontend** (React) for user interactions (not yet connected to backend).  

> ⚠️ The smart contracts are deployed and working, but backend and frontend are not fully integrated.

---

## 🚀 Features  

- ✅ **Blockchain Contracts**  
  - Smart contract-based token distribution for eco-friendly actions.  
  - Includes `AdminVerification`, `StakeholderRegistration`, and `Factory` logic.  

- ✅ **Minimal Backend (WIP)**  
  - Node.js/Express structure to handle API requests.  
  - Not yet deployed or connected.  

- ✅ **Frontend (React - WIP)**  
  - Web-based UI to display token balance and submit eco-action claims.  
  - Currently not linked to backend or contracts.

---

## 📂 Project Structure  

```plaintext
DApp-EcoToken/
│── backend/                # Backend code (Node.js/Express)
│── contracts/              # Solidity smart contracts
│── frontend/               # Frontend (React)
│── .gitignore
│── README.md
```
## 🔧 Prerequisites  

- **Node.js** (LTS version recommended)  
- **npm** (or **yarn**)  
- **Truffle** (or **Hardhat**) for smart contract deployment  
- **Ganache** or a testnet (e.g., Ropsten, Goerli, Mumbai, etc.)  

---

## 🔧 Install Dependencies  

For each folder (**backend**, **contracts**, **frontend**), install the required dependencies:  

```sh
cd backend && npm install  
cd ../contracts && npm install  
cd ../frontend && npm install  
```

## ❗ Known Issues & Future Plans  

- ✅ **Integration:** Backend and frontend are unfinished, so they don’t interact with contracts yet.  
- ✅ **Smart Contracts:** Deployed and tested—minting, transferring, and verification work.  

### 🚀 Roadmap  

- 🔗 Connect backend to smart contracts via Web3.  
- 🛠️ Add backend endpoints for user token actions.  
- 🎨 Improve UI/UX for smoother interaction and user experience.  

---

## 📜 License  

This project is open-source. Use any license you prefer (MIT, Apache, etc.).  


### 1️⃣ Clone the repository  

```sh
git clone https://github.com/basarzaim/DApp-EcoToken.git
cd DApp-EcoToken
