using LibraryManagementSystem.Models;
using System;
using System.Configuration;
using System.Data.Entity;
using System.Diagnostics;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace LibraryManagementSystem
{
    public partial class ReaderWindow : Window
    {
        private LibraryDBEntities _dbContext;
        private int _currentReaderId;

        public ReaderWindow(int readerId)
        {
            InitializeComponent();
            //string connectionString = ConfigurationManager.ConnectionStrings["LibraryDBEntities"].ConnectionString;
            //Debug.WriteLine("Connection string: " + connectionString);

            _dbContext = new LibraryDBEntities();
            _currentReaderId = readerId;
            LoadCatalog();
            LoadMyBooks();
        }

        private void LoadCatalog()
        {
            CatalogDataGrid.ItemsSource = _dbContext.Books.Include("Genres").ToList();
        }

        private void LoadMyBooks()
        {
            var myBooks = _dbContext.BookIssues
                .Where(b => b.ReaderID == _currentReaderId)
                .Include("Book")
                .ToList()
                .Select(b => new
                {
                    b.Books,
                    b.IssueDate,
                    b.DueDate,
                    Status = b.ReturnDate == null ?
                        (b.DueDate < DateTime.Now ? "Overdue" : "Borrowed") :
                        "Returned"
                });

            MyBooksDataGrid.ItemsSource = myBooks;
        }

        private void SearchBook_Click(object sender, RoutedEventArgs e)
        {
            string searchTerm = SearchTextBox.Text.ToLower();

            var results = _dbContext.Books
                .Where(b => b.Title.ToLower().Contains(searchTerm) ||
                           b.ISBN.ToLower().Contains(searchTerm) ||
                           b.Genres.GenreName.ToLower().Contains(searchTerm))
                .ToList();

            SearchResultsDataGrid.ItemsSource = results;
        }

        private void SubmitReview_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(ReviewBookIsbnTextBox.Text) ||
                RatingComboBox.SelectedItem == null ||
                string.IsNullOrEmpty(ReviewTextBox.Text))
            {
                MessageBox.Show("Please fill all fields", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            try
            {
                var review = new BookReviews
                {
                    ISBN = ReviewBookIsbnTextBox.Text,
                    ReaderID = _currentReaderId,
                    Rating = int.Parse(((ComboBoxItem)RatingComboBox.SelectedItem).Content.ToString()),
                    ReviewText = ReviewTextBox.Text,
                    ReviewDate = DateTime.Now
                };

                _dbContext.BookReviews.Add(review);
                _dbContext.SaveChanges();

                MessageBox.Show("Review submitted successfully", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error submitting review: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void RefreshCatalog_Click(object sender, RoutedEventArgs e)
        {
            LoadCatalog();
        }

        private void RefreshMyBooks_Click(object sender, RoutedEventArgs e)
        {
            LoadMyBooks();
        }

        private void Logout_Click(object sender, RoutedEventArgs e)
        {
            MainWindow mainWindow = new MainWindow();
            mainWindow.Show();
            this.Close();
        }
    }
}