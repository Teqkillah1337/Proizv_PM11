using System;
using System.Data.Entity;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using LibraryManagementSystem.Models;

namespace LibraryManagementSystem
{
    public partial class GenerateReportView : UserControl
    {
        private LibraryDBEntities _dbContext;

        public GenerateReportView()
        {
        }

        public GenerateReportView(LibraryDBEntities dbContext)
        {
            InitializeComponent();
            _dbContext = dbContext;
            StartDatePicker.SelectedDate = DateTime.Now.AddMonths(-1);
            EndDatePicker.SelectedDate = DateTime.Now;
        }

        private void GenerateReport_Click(object sender, RoutedEventArgs e)
        {
            if (ReportTypeComboBox.SelectedItem == null ||
                StartDatePicker.SelectedDate == null ||
                EndDatePicker.SelectedDate == null)
            {
                MessageBox.Show("Please select report type and date range", "Error",
                    MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            DateTime startDate = StartDatePicker.SelectedDate.Value;
            DateTime endDate = EndDatePicker.SelectedDate.Value;
            string reportType = ((ComboBoxItem)ReportTypeComboBox.SelectedItem).Content.ToString();

            try
            {
                switch (reportType)
                {
                    case "Books Issued":
                        var issuedBooks = _dbContext.BookIssues
                            .Where(b => b.IssueDate >= startDate && b.IssueDate <= endDate)
                            .Include(b => b.Books)
                            .Include(b => b.Readers)
                            .Select(b => new
                            {
                                b.Books.Title,
                                b.Readers.FullName,
                                b.IssueDate,
                                b.DueDate,
                                Status = b.ReturnDate == null ? "Borrowed" : "Returned"
                            })
                            .ToList();
                        ReportDataGrid.ItemsSource = issuedBooks;
                        break;

                    case "Overdue Books":
                        var overdueBooks = _dbContext.BookIssues
                            .Where(b => b.ReturnDate == null && b.DueDate < DateTime.Now)
                            .Include(b => b.Books)
                            .Include(b => b.Readers)
                            .Select(b => new
                            {
                                b.Books.Title,
                                b.Readers.FullName,
                                b.IssueDate,
                                b.DueDate,
                                DaysOverdue = (DateTime.Now - b.DueDate).Days
                            })
                            .ToList();
                        ReportDataGrid.ItemsSource = overdueBooks;
                        break;

                    case "Popular Books":
                        var popularBooks = _dbContext.BookIssues
                            .Where(b => b.IssueDate >= startDate && b.IssueDate <= endDate)
                            .GroupBy(b => b.Books.Title)
                            .Select(g => new
                            {
                                BookTitle = g.Key,
                                TimesBorrowed = g.Count()
                            })
                            .OrderByDescending(b => b.TimesBorrowed)
                            .ToList();
                        ReportDataGrid.ItemsSource = popularBooks;
                        break;

                    case "Reader Activity":
                        var readerActivity = _dbContext.BookIssues
                            .Where(b => b.IssueDate >= startDate && b.IssueDate <= endDate)
                            .GroupBy(b => b.Readers.FullName)
                            .Select(g => new
                            {
                                ReaderName = g.Key,
                                BooksBorrowed = g.Count(),
                                OverdueBooks = g.Count(b => b.ReturnDate == null && b.DueDate < DateTime.Now)
                            })
                            .OrderByDescending(r => r.BooksBorrowed)
                            .ToList();
                        ReportDataGrid.ItemsSource = readerActivity;
                        break;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error generating report: {ex.Message}", "Error",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    }
}