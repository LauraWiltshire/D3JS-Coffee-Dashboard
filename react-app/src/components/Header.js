export default function Header() {
  return (
    <div className="headerContainer">
      <div className="logoContainer">
        <img src="/logo.png" alt="Coffee Beans" />
        <p>D3JS Coffee Dashboard</p>
      </div>
      <div className="linkContainer">
        <p>Home</p>
        <p>About</p>
        <p>Contact</p>
      </div>
    </div>
  );
}
