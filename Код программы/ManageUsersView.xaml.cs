using System.Linq;
using System.Windows.Controls;
using LibraryManagementSystem.Models;

namespace LibraryManagementSystem
{
    public partial class ManageUsersView : UserControl
    {
        private LibraryDBEntities _dbContext;

        public ManageUsersView(LibraryDBEntities dbContext)
        {
            InitializeComponent();
            _dbContext = dbContext;
            LoadUsers();
        }

        private void LoadUsers()
        {
            UsersDataGrid.ItemsSource = _dbContext.Users.ToList();
        }
    }
}