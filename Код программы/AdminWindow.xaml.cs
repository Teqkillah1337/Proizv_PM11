using System;
using System.Windows;
using System.Windows.Controls;

namespace LibraryManagementSystem
{
    public partial class AdminWindow : Window
    {
        private LibraryDBEntities _dbContext;

        public AdminWindow()
        {
            InitializeComponent();
            _dbContext = new LibraryDBEntities();
        }

        protected override void OnClosed(EventArgs e)
        {
            _dbContext.Dispose();
            base.OnClosed(e);
        }

        //private void SystemSettings_Click(object sender, RoutedEventArgs e)
        //{
        //    CurrentViewHeader.Text = "System Settings";
        //    CurrentViewContent.Content = new SystemSettingsView(_dbContext);
        //}

        private void ManageUsers_Click(object sender, RoutedEventArgs e)
        {
            CurrentViewHeader.Text = "Manage Users";
            CurrentViewContent.Content = new ManageUsersView(_dbContext);
        }

        private void GenerateReport_Click(object sender, RoutedEventArgs e)
        {
            CurrentViewHeader.Text = "Generate Report";
            CurrentViewContent.Content = new GenerateReportView();
        }

        private void MonitorActivity_Click(object sender, RoutedEventArgs e)
        {
            //    CurrentViewHeader.Text = "Monitor Activity";

            //    try
            //    {
            //        var activityLogs = _dbContext.ActivityLogs;
            //            //.OrderByDescending(a => a.Timestamp)
            //            //.Take(50)
            //            //.Select(a => new
            //            //{
            //            //    a.Timestamp,
            //            //    a.Username,
            //            //    a.ActivityType,
            //            //    a.Details
            //            //})
            //            //.ToList();

            //        DataGrid activityGrid = new DataGrid();
            //        activityGrid.AutoGenerateColumns = true;
            //        //activityGrid.ItemsSource = activityLogs;
            //        activityGrid.IsReadOnly = true;

            //        CurrentViewContent.Content = activityGrid;
            //    }
            //    catch (Exception ex)
            //    {
            //        MessageBox.Show($"Error loading activity logs: {ex.Message}", "Error",
            //            MessageBoxButton.OK, MessageBoxImage.Error);
            //    }
        }

        private void Logout_Click(object sender, RoutedEventArgs e)
        {
            MainWindow mainWindow = new MainWindow();
            mainWindow.Show();
            this.Close();
        }
    }
}