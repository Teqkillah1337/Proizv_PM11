using System;
using System.Linq;
using System.Windows;
using LibraryManagementSystem.Models;

namespace LibraryManagementSystem
{
    public partial class LibrarianWindow : Window
    {
        private LibraryDBEntities _dbContext;

        public LibrarianWindow()
        {
            InitializeComponent();
            _dbContext = new LibraryDBEntities();
            LoadCatalog();
        }

        private void LoadCatalog()
        {
            //BooksDataGrid.ItemsSource = _dbContext.Books.Include("Genres").ToList();
        }

        private void IssueBook_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(ReaderIdTextBox.Text) || string.IsNullOrEmpty(BookIsbnTextBox.Text))
            {
                MessageBox.Show("Please enter Reader ID and Book ISBN", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            try
            {
                int readerId = int.Parse(ReaderIdTextBox.Text);
                string isbn = BookIsbnTextBox.Text;

                var reader = _dbContext.Readers.Find(readerId);
                var book = _dbContext.Books.Find(isbn);

                if (reader == null || book == null)
                {
                    MessageBox.Show("Reader or book not found", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                var issue = new BookIssues
                {
                    ReaderID = readerId,
                    ISBN = isbn,
                    IssueDate = DateTime.Now,
                    DueDate = DateTime.Now.AddDays(14),
                    ReturnDate = null
                };

                _dbContext.BookIssues.Add(issue);
                _dbContext.SaveChanges();

                MessageBox.Show("Book issued successfully", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error issuing book: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void ReturnBook_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(IssueIdTextBox.Text))
            {
                MessageBox.Show("Please enter Issue ID", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            try
            {
                int issueId = int.Parse(IssueIdTextBox.Text);
                var issue = _dbContext.BookIssues.Find(issueId);

                if (issue == null)
                {
                    MessageBox.Show("Issue not found", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                issue.ReturnDate = DateTime.Now;
                _dbContext.SaveChanges();

                MessageBox.Show("Book returned successfully", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error returning book: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void RegisterReader_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(ReaderNameTextBox.Text))
            {
                MessageBox.Show("Please enter reader name", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            try
            {
                var reader = new Readers
                {
                    //FullName = ReaderNameTextBox.Text,
                    Email = ReaderEmailTextBox.Text,
                    Phone = ReaderPhoneTextBox.Text,
                    Address = ReaderAddressTextBox.Text,
                    RegistrationDate = DateTime.Now
                };

                _dbContext.Readers.Add(reader);
                _dbContext.SaveChanges();

                MessageBox.Show($"Reader registered successfully with ID: {reader.ReaderID}", "Success",
                    MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error registering reader: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void ApplyFine_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(FineReaderIdTextBox.Text) || string.IsNullOrEmpty(FineAmountTextBox.Text))
            {
                MessageBox.Show("Please enter Reader ID and Amount", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            try
            {
                int readerId = int.Parse(FineReaderIdTextBox.Text);
                decimal amount = decimal.Parse(FineAmountTextBox.Text);

                var fine = new Fines
                {
                    ReaderID = readerId,
                    Amount = amount,
                    Reason = FineReasonTextBox.Text,
                    IssueDate = DateTime.Now,
                    Paid = false
                };

                Models.Fines.Add(fine);
                _dbContext.SaveChanges();

                MessageBox.Show("Fine applied successfully", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error applying fine: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void RefreshCatalog_Click(object sender, RoutedEventArgs e)
        {
            LoadCatalog();
        }

        private void Logout_Click(object sender, RoutedEventArgs e)
        {
            MainWindow mainWindow = new MainWindow();
            mainWindow.Show();
            this.Close();
        }
    }
}