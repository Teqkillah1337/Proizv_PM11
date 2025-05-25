namespace LibraryManagementSystem
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class LibraryDBEntities : DbContext
    {
        public LibraryDBEntities()
            : base("name=LibraryDBEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Users> Users { get; set; }
        public virtual DbSet<Authors> Authors { get; set; }
        public virtual DbSet<BookAuthors> BookAuthors { get; set; }
        public virtual DbSet<BookIssues> BookIssues { get; set; }
        public virtual DbSet<BookReviews> BookReviews { get; set; }
        public virtual DbSet<Books> Books { get; set; }
        public virtual DbSet<Genres> Genres { get; set; }
        public virtual DbSet<Readers> Readers { get; set; }
    
        public virtual int AddBook(string iSBN, string title, Nullable<int> publishYear, Nullable<int> genreID)
        {
            var iSBNParameter = iSBN != null ?
                new ObjectParameter("ISBN", iSBN) :
                new ObjectParameter("ISBN", typeof(string));
    
            var titleParameter = title != null ?
                new ObjectParameter("Title", title) :
                new ObjectParameter("Title", typeof(string));
    
            var publishYearParameter = publishYear.HasValue ?
                new ObjectParameter("PublishYear", publishYear) :
                new ObjectParameter("PublishYear", typeof(int));
    
            var genreIDParameter = genreID.HasValue ?
                new ObjectParameter("GenreID", genreID) :
                new ObjectParameter("GenreID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("AddBook", iSBNParameter, titleParameter, publishYearParameter, genreIDParameter);
        }
    }
}
