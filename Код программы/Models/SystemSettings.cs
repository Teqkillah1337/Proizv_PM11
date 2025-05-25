using System;
using System.ComponentModel.DataAnnotations;

namespace LibraryManagementSystem.Models
{
    public class SystemSettings
    {
        [Key]
        public int Id { get; set; } // Первичный ключ для таблицы настроек

        [Required]
        [Range(1, 100)] // Ограничиваем значение от 1 до 100
        [Display(Name = "Максимальное количество книг")]
        public int MaxBooksPerReader { get; set; } = 5; // Значение по умолчанию

        internal static object FirstOrDefault()
        {
            throw new NotImplementedException();
        }
    }
}