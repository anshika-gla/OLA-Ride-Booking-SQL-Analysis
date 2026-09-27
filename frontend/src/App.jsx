import { useEffect, useState } from "react";
import "./App.css";

function App() {
  const [stats, setStats] = useState({
    total_bookings: 10000,
    successful_rides: 7815,
    cancelled_rides: 2185,
    cancellation_rate: 21.85,
  });

  const [activePage, setActivePage] = useState("Dashboard");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch("http://localhost:5000/api/stats")
      .then((res) => {
        if (!res.ok) throw new Error("API request failed");
        return res.json();
      })
      .then((data) => {
        console.log("Backend data:", data);
        setStats(data);
      })
      .catch((error) => {
        console.error("Backend connection error:", error);
      })
      .finally(() => setLoading(false));
  }, []);

  const vehicles = [
    { name: "Mini", rides: 1919, revenue: "₹3.88L", rating: "4.30" },
    { name: "Auto", rides: 1619, revenue: "₹3.09L", rating: "4.25" },
    { name: "Prime Sedan", rides: 1402, revenue: "₹3.40L", rating: "4.27" },
    { name: "Prime SUV", rides: 1124, revenue: "₹3.37L", rating: "4.27" },
    { name: "Bike", rides: 999, revenue: "₹1.54L", rating: "4.26" },
    { name: "Prime Plus", rides: 752, revenue: "₹2.61L", rating: "4.28" },
  ];

  const months = [
    ["Jan", 21.9],
    ["Feb", 24.29],
    ["Mar", 21.9],
    ["Apr", 20.48],
    ["May", 21.08],
    ["Jun", 22.45],
    ["Jul", 22.28],
    ["Aug", 21.53],
    ["Sep", 21.09],
    ["Oct", 22.55],
    ["Nov", 21.74],
    ["Dec", 21.02],
  ];

  const goTo = (page) => setActivePage(page);

  const successRate = (
    (Number(stats.successful_rides) / Number(stats.total_bookings)) *
    100
  ).toFixed(2);

  const totalRevenue = 19.06;
  const averageRide = 243.87;

  const KPI = ({
    title,
    value,
    subtitle,
    icon,
    color,
    onClick,
  }) => (
    <button className="card kpi kpiButton" onClick={onClick}>
      <div className="kpiTop">
        <span>{title}</span>
        <div className={`icon ${color}`}>{icon}</div>
      </div>
      <h2>{value}</h2>
      <p>{subtitle}</p>
    </button>
  );

  const MonthlyChart = () => (
    <div className="card chartCard">
      <div className="sectionHeader">
        <div>
          <h3>Monthly Cancellation Rate</h3>
          <p>Cancellation trend throughout 2025</p>
        </div>
        <span className="pill">2025</span>
      </div>

      <div className="chart">
        {months.map(([month, value]) => (
          <div className="barItem" key={month}>
            <div className="barValue">{value}%</div>
            <div
              className="bar"
              style={{ height: `${value * 7}px` }}
              title={`${month}: ${value}% cancellation rate`}
            />
            <small>{month}</small>
          </div>
        ))}
      </div>
    </div>
  );

  const VehicleTable = () => (
    <section className="card tableCard">
      <div className="sectionHeader">
        <div>
          <h3>Vehicle Performance</h3>
          <p>Successful rides, revenue and customer ratings</p>
        </div>
        <button onClick={() => goTo("Vehicles")}>Vehicle Analysis →</button>
      </div>

      <div className="table">
        <div className="tableRow tableHead">
          <span>Vehicle Type</span>
          <span>Successful Rides</span>
          <span>Revenue</span>
          <span>Rating</span>
          <span>Performance</span>
        </div>

        {vehicles.map((vehicle, index) => (
          <div className="tableRow" key={vehicle.name}>
            <span className="vehicleName">
              <i>{index + 1}</i>
              {vehicle.name}
            </span>
            <span>{vehicle.rides.toLocaleString()}</span>
            <span className="revenue">{vehicle.revenue}</span>
            <span>★ {vehicle.rating}</span>
            <span>
              <div className="progress">
                <div
                  style={{
                    width: `${(vehicle.rides / 1919) * 100}%`,
                  }}
                />
              </div>
            </span>
          </div>
        ))}
      </div>
    </section>
  );

  const Insights = () => (
    <div className="card insightCard">
      <div className="sectionHeader">
        <div>
          <h3>Key Insights</h3>
          <p>Highlights from the analysis</p>
        </div>
      </div>

      <div className="insight">
        <span className="insightIcon green">✓</span>
        <div>
          <strong>Mini leads successful rides</strong>
          <p>1,919 successful bookings</p>
        </div>
      </div>

      <div className="insight">
        <span className="insightIcon purple">₹</span>
        <div>
          <strong>Mini generates highest revenue</strong>
          <p>₹3.88L total revenue</p>
        </div>
      </div>

      <div className="insight">
        <span className="insightIcon red">!</span>
        <div>
          <strong>Driver availability is a concern</strong>
          <p>478 cancellations due to no driver</p>
        </div>
      </div>

      <div className="insight">
        <span className="insightIcon blue">↑</span>
        <div>
          <strong>February had highest cancellations</strong>
          <p>24.29% cancellation rate</p>
        </div>
      </div>
    </div>
  );

  const DashboardPage = () => (
    <>
      <section className="kpis">
        <KPI
          title="Total Bookings"
          value={Number(stats.total_bookings).toLocaleString()}
          subtitle={<><b>100%</b> of all rides</>}
          icon="↗"
          color="blue"
          onClick={() => goTo("Bookings")}
        />

        <KPI
          title="Successful Rides"
          value={Number(stats.successful_rides).toLocaleString()}
          subtitle={<><b>{successRate}%</b> success rate</>}
          icon="✓"
          color="green"
          onClick={() => goTo("Bookings")}
        />

        <KPI
          title="Cancelled Rides"
          value={Number(stats.cancelled_rides).toLocaleString()}
          subtitle={<><b>{stats.cancellation_rate}%</b> cancellation rate</>}
          icon="×"
          color="red"
          onClick={() => goTo("Cancellations")}
        />

        <KPI
          title="Total Revenue"
          value={`₹${totalRevenue.toFixed(2)}L`}
          subtitle={<><b>₹{averageRide}</b> avg. successful ride</>}
          icon="₹"
          color="purple"
          onClick={() => goTo("Vehicles")}
        />
      </section>

      <section className="gridTwo">
        <MonthlyChart />
        <Insights />
      </section>

      <VehicleTable />

      <section className="bottomGrid">
        <button className="card locationCard bottomButton" onClick={() => goTo("Bookings")}>
          <p className="eyebrow">TOP LOCATION</p>
          <h2>Gurgaon</h2>
          <p>Highest number of successful pickup rides</p>
          <div className="locationStats">
            <strong>1,000+</strong>
            <span>successful rides</span>
          </div>
        </button>

        <button className="card cancellationCard bottomButton" onClick={() => goTo("Cancellations")}>
          <p className="eyebrow">TOP CANCELLATION REASON</p>
          <h2>No driver available</h2>
          <p>System-related cancellations</p>
          <div className="reasonBar"><div /></div>
          <span>478 cancellations</span>
        </button>

        <button className="card paymentCard bottomButton" onClick={() => goTo("Bookings")}>
          <p className="eyebrow">PAYMENT INSIGHT</p>
          <h2>UPI</h2>
          <p>Most-used successful payment method</p>
          <div className="paymentIcon">₹</div>
        </button>
      </section>
    </>
  );

  const BookingsPage = () => (
    <>
      <div className="pageIntro">
        <p className="eyebrow">BOOKINGS</p>
        <h2>Booking Analysis</h2>
        <p>Overview of ride booking activity from the MySQL dataset.</p>
      </div>

      <section className="kpis">
        <KPI
          title="Total Bookings"
          value={Number(stats.total_bookings).toLocaleString()}
          subtitle={<><b>100%</b> total records</>}
          icon="↗"
          color="blue"
          onClick={() => goTo("Bookings")}
        />
        <KPI
          title="Successful"
          value={Number(stats.successful_rides).toLocaleString()}
          subtitle={<><b>{successRate}%</b> success rate</>}
          icon="✓"
          color="green"
          onClick={() => goTo("Bookings")}
        />
        <KPI
          title="Cancelled"
          value={Number(stats.cancelled_rides).toLocaleString()}
          subtitle={<><b>{stats.cancellation_rate}%</b> cancellation rate</>}
          icon="×"
          color="red"
          onClick={() => goTo("Cancellations")}
        />
        <KPI
          title="Avg. Ride Revenue"
          value={`₹${averageRide}`}
          subtitle="per successful ride"
          icon="₹"
          color="purple"
          onClick={() => goTo("Vehicles")}
        />
      </section>

      <section className="gridTwo">
        <MonthlyChart />
        <div className="card insightCard">
          <div className="sectionHeader">
            <div>
              <h3>Booking Summary</h3>
              <p>Current dataset summary</p>
            </div>
          </div>
          <div className="insight">
            <span className="insightIcon green">✓</span>
            <div><strong>7,815 rides completed</strong><p>Successful bookings</p></div>
          </div>
          <div className="insight">
            <span className="insightIcon red">×</span>
            <div><strong>2,185 rides cancelled</strong><p>Needs operational attention</p></div>
          </div>
          <div className="insight">
            <span className="insightIcon purple">₹</span>
            <div><strong>₹19.06L revenue</strong><p>Successful ride revenue</p></div>
          </div>
        </div>
      </section>
    </>
  );

  const VehiclesPage = () => (
    <>
      <div className="pageIntro">
        <p className="eyebrow">VEHICLES</p>
        <h2>Vehicle Performance</h2>
        <p>Compare successful rides, revenue and customer ratings.</p>
      </div>

      <VehicleTable />

      <div className="bottomGrid">
        <div className="card locationCard">
          <p className="eyebrow">TOP PERFORMER</p>
          <h2>Mini</h2>
          <p>Highest successful ride count and revenue.</p>
          <div className="locationStats">
            <strong>1,919</strong><span>successful rides</span>
          </div>
        </div>
        <div className="card paymentCard">
          <p className="eyebrow">HIGHEST REVENUE</p>
          <h2>Mini</h2>
          <p>Total revenue generated by Mini.</p>
          <div className="paymentIcon">₹</div>
        </div>
      </div>
    </>
  );

  const DriversPage = () => (
    <>
      <div className="pageIntro">
        <p className="eyebrow">DRIVERS</p>
        <h2>Driver Availability</h2>
        <p>Operational insights related to driver availability.</p>
      </div>

      <section className="bottomGrid">
        <div className="card locationCard">
          <p className="eyebrow">ISSUE</p>
          <h2>No driver available</h2>
          <p>This is the highest cancellation reason in the analysis.</p>
          <div className="locationStats">
            <strong>478</strong><span>cancellations</span>
          </div>
        </div>

        <div className="card cancellationCard">
          <p className="eyebrow">ACTION AREA</p>
          <h2>Driver supply</h2>
          <p>Monitor driver availability during high-demand periods.</p>
          <div className="reasonBar"><div /></div>
        </div>

        <div className="card paymentCard">
          <p className="eyebrow">DATA SOURCE</p>
          <h2>MySQL</h2>
          <p>Insights are calculated from the ride booking dataset.</p>
          <div className="paymentIcon">SQL</div>
        </div>
      </section>

      <MonthlyChart />
    </>
  );

  const CancellationsPage = () => (
    <>
      <div className="pageIntro">
        <p className="eyebrow">CANCELLATIONS</p>
        <h2>Cancellation Analysis</h2>
        <p>Track cancellation trends and major cancellation reasons.</p>
      </div>

      <section className="kpis">
        <KPI
          title="Cancelled Rides"
          value={Number(stats.cancelled_rides).toLocaleString()}
          subtitle={<><b>{stats.cancellation_rate}%</b> cancellation rate</>}
          icon="×"
          color="red"
          onClick={() => goTo("Cancellations")}
        />
        <KPI
          title="Highest Month"
          value="February"
          subtitle={<><b>24.29%</b> cancellation rate</>}
          icon="↑"
          color="purple"
          onClick={() => goTo("Cancellations")}
        />
        <KPI
          title="Top Reason"
          value="No Driver"
          subtitle="478 cancellations"
          icon="!"
          color="red"
          onClick={() => goTo("Drivers")}
        />
        <KPI
          title="Successful Rides"
          value={Number(stats.successful_rides).toLocaleString()}
          subtitle={<><b>{successRate}%</b> success rate</>}
          icon="✓"
          color="green"
          onClick={() => goTo("Bookings")}
        />
      </section>

      <MonthlyChart />

      <div className="card tableCard">
        <div className="sectionHeader">
          <div>
            <h3>Cancellation Findings</h3>
            <p>Important findings from the SQL analysis</p>
          </div>
        </div>
        <div className="insight">
          <span className="insightIcon red">!</span>
          <div><strong>No driver available</strong><p>478 cancellations were linked to driver availability.</p></div>
        </div>
        <div className="insight">
          <span className="insightIcon purple">↑</span>
          <div><strong>February peak</strong><p>February recorded the highest monthly cancellation rate at 24.29%.</p></div>
        </div>
      </div>
    </>
  );

  const renderPage = () => {
    switch (activePage) {
      case "Bookings":
        return <BookingsPage />;
      case "Vehicles":
        return <VehiclesPage />;
      case "Drivers":
        return <DriversPage />;
      case "Cancellations":
        return <CancellationsPage />;
      default:
        return <DashboardPage />;
    }
  };

  return (
    <div className="app">
      <aside className="sidebar">
        <div className="logo">
          <div className="logoIcon">O</div>
          <div>
            <h2>OLA Analytics</h2>
            <span>Business Intelligence</span>
          </div>
        </div>

        <nav>
          {[
            ["Dashboard", "▦"],
            ["Bookings", "↗"],
            ["Vehicles", "🚕"],
            ["Drivers", "◉"],
            ["Cancellations", "⚠"],
          ].map(([page, icon]) => (
            <a
              key={page}
              className={activePage === page ? "active" : ""}
              onClick={() => goTo(page)}
            >
              {icon} <span>{page}</span>
            </a>
          ))}
        </nav>

        <div className="sidebarBottom">
          <div className="sqlBadge">SQL</div>
          <p>MySQL Analytics</p>
          <small>10,000 records analyzed</small>
        </div>
      </aside>

      <main className="main">
        <header className="header">
          <div>
            <p className="eyebrow">{activePage.toUpperCase()}</p>
            <h1>
              {activePage === "Dashboard"
                ? "Ride Booking Dashboard"
                : `${activePage} Analysis`}
            </h1>
            <p className="subtitle">
              Business insights from OLA ride booking data
            </p>
          </div>

          <div className="headerRight">
            <div className="status">
              <span></span>
              {loading ? "Connecting..." : "Data Connected"}
            </div>
            <div className="avatar">AK</div>
          </div>
        </header>

        {renderPage()}

        <footer>
          OLA Ride Booking SQL Analysis · Built with React + Node.js + MySQL
        </footer>
      </main>
    </div>
  );
}

export default App;
