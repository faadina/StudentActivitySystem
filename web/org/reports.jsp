<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports & Analytics - UiTM Activity</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .main-content { background-color: #f8f9fa; min-height: 100vh; }
        .page-header { background: white; border-bottom: 1px solid #dee2e6; padding: 20px 0; margin-bottom: 30px; }
        .stats-card { background: white; border-radius: 12px; padding: 25px; text-align: center; box-shadow: 0 2px 10px rgba(0,0,0,0.07); }
        .stats-icon { font-size: 2rem; margin-bottom: 15px; color: #6c757d; }
        .stats-number { font-size: 2.5rem; font-weight: bold; }
        .chart-container { background: white; border-radius: 12px; padding: 25px; box-shadow: 0 2px 10px rgba(0,0,0,0.07); margin-bottom: 25px; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="organizationSidebar.jsp" />

            <div class="col-md-9 col-lg-10 main-content">
                <div class="page-header">
                    <div class="container-fluid d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="mb-0"><i class="fas fa-chart-bar me-2 text-primary"></i> Reports & Analytics</h2>
                            <p class="text-muted mb-0">Overview of your organization's activities.</p>
                        </div>
                        <div class="col-auto">
                           <a href="${pageContext.request.contextPath}/organization?action=exportReport&format=csv" class="btn btn-primary">
                               <i class="fas fa-download me-2"></i>Export Summary (CSV)
                           </a>
                        </div>
                    </div>
                </div>

                <div class="container-fluid">
                    <div class="row mb-4">
                        <div class="col-md-3 mb-3"><div class="stats-card"><i class="fas fa-calendar-alt stats-icon"></i><div class="stats-number text-primary">${totalEvents}</div><div class="text-muted">Total Events</div></div></div>
                        <div class="col-md-3 mb-3"><div class="stats-card"><i class="fas fa-users stats-icon"></i><div class="stats-number text-success">${totalParticipants}</div><div class="text-muted">Total Participants</div></div></div>
                        <div class="col-md-3 mb-3"><div class="stats-card"><i class="fas fa-building stats-icon"></i><div class="stats-number text-warning">${venueBookings}</div><div class="text-muted">Venue Bookings</div></div></div>
                        <div class="col-md-3 mb-3"><div class="stats-card"><i class="fas fa-boxes stats-icon"></i><div class="stats-number text-info">${resourceBookings}</div><div class="text-muted">Resource Bookings</div></div></div>
                    </div>

                    <div class="row">
                        <div class="col-lg-8">
                            <div class="chart-container">
                                <h5 class="mb-3">Monthly Event Creation</h5>
                                <canvas id="monthlyEventsChart"></canvas>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="chart-container">
                                <h5 class="mb-3">Events by Category</h5>
                                <canvas id="categoryChart"></canvas>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-12">
                             <div class="chart-container">
                                <h5 class="mb-3">Top 10 Most Booked Venues</h5>
                                <canvas id="topVenuesChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Data for Monthly Events Chart
            const monthlyEventLabels = ${monthlyEventLabels};
            const monthlyEventData = ${monthlyEventData};
            const monthlyEventsCtx = document.getElementById('monthlyEventsChart').getContext('2d');
            new Chart(monthlyEventsCtx, {
                type: 'line',
                data: {
                    labels: monthlyEventLabels,
                    datasets: [{
                        label: 'Events Created',
                        data: monthlyEventData,
                        borderColor: '#667eea',
                        backgroundColor: 'rgba(102, 126, 234, 0.1)',
                        fill: true,
                        tension: 0.3
                    }]
                },
                options: { responsive: true, maintainAspectRatio: true, plugins: { legend: { display: false } } }
            });

            // Data for Category Chart
            const categoryLabels = ${categoryLabels};
            const categoryData = ${categoryData};
            const categoryCtx = document.getElementById('categoryChart').getContext('2d');
            new Chart(categoryCtx, {
                type: 'doughnut',
                data: {
                    labels: categoryLabels,
                    datasets: [{
                        data: categoryData,
                        backgroundColor: ['#667eea', '#764ba2', '#ff8c42', '#ffc107', '#28a745', '#20c997'],
                        hoverOffset: 4
                    }]
                },
                options: { responsive: true, maintainAspectRatio: true }
            });
            
            // Data for Top Venues Chart
            const topVenueLabels = ${topVenueLabels};
            const topVenueData = ${topVenueData};
            const topVenuesCtx = document.getElementById('topVenuesChart').getContext('2d');
            new Chart(topVenuesCtx, {
                type: 'bar',
                data: {
                    labels: topVenueLabels,
                    datasets: [{
                        label: 'Number of Bookings',
                        data: topVenueData,
                        backgroundColor: 'rgba(118, 75, 162, 0.7)',
                        borderColor: 'rgba(118, 75, 162, 1)',
                        borderWidth: 1
                    }]
                },
                options: { responsive: true, maintainAspectRatio: true, plugins: { legend: { display: false } }, indexAxis: 'y' }
            });
        });
    </script>
</body>
</html>