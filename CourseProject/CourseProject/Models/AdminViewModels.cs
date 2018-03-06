using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CourseProject.Models
{
    public class HotelViewModel
    {
        [Required(ErrorMessage = "Please input Name")]
        [StringLength(20, ErrorMessage = "The value must contain at least 3 characters", MinimumLength = 3)]
        [Display(Name = "Name")]
        public string Name { get; set; }
        [Required(ErrorMessage = "Please input Address")]
        [StringLength(50, ErrorMessage = "The value must contain at least 5 characters", MinimumLength = 5)]
        [Display(Name = "Address")]
        public string Address { get; set; }
        [Required(ErrorMessage = "Please input City")]
        [StringLength(50, ErrorMessage = "The value must contain at least 5 characters", MinimumLength = 5)]
        [Display(Name = "City")]
        public string City { get; set; }
        [Required(ErrorMessage = "Please input Phone Number")]
        [StringLength(50, ErrorMessage = "The value must contain at least 5 characters", MinimumLength = 5)]
        [Display(Name = "Phone Number")]
        public string PhoneNumber { get; set; }
        [Required(ErrorMessage = "Please input web site")]
        [StringLength(50, ErrorMessage = "The value must contain at least 5 characters", MinimumLength = 5)]
        [Display(Name = "web site")]
        public string WebSite { get; set; }
        [Required(ErrorMessage = "Please input description")]
        [StringLength(200, ErrorMessage = "The value must contain at least 5 characters", MinimumLength = 5)]
        [Display(Name = "description")]
        public string Description { get; set; }
    }
    public class RoomViewModel
    {
        [Required(ErrorMessage = "Please input Price")]
        [StringLength(20, ErrorMessage = "The value must contain at least 3 characters", MinimumLength = 3)]
        [Display(Name = "Price")]
        public string Price { get; set; }
        [StringLength(200, ErrorMessage = "The value must contain at least 5 characters", MinimumLength = 5)]
        [Display(Name = "Descriptions")]
        public string Descriptions { get; set; }
        [Required(ErrorMessage = "Please input Number")]
        [StringLength(4, ErrorMessage = "The value must contain at least 3 characters", MinimumLength = 1)]
        [Display(Name = "Number")]
        public string Number { get; set; }
        [Required(ErrorMessage = "Please input Status")]
        [StringLength(10, ErrorMessage = "The value must contain at least 5 characters", MinimumLength = 3)]
        [Display(Name = "status")]
        public string Status { get; set; }
        public string HotelId { get; set; }
        public string CategoryId { get; set; }
    }

    public class HallViewModel
    {
        [Required(ErrorMessage = "Please input Name")]
        [StringLength(20, ErrorMessage = "The value must contain at least 3 characters", MinimumLength = 3)]
        [Display(Name = "Name")]
        public string Name { get; set; }
        [Required(ErrorMessage = "Please input CountPlace")]
        [StringLength(4, ErrorMessage = "The value must contain at least 3 characters", MinimumLength = 1)]
        [Display(Name = "CountPlace")]
        public string CountPlace { get; set; }
        [Required(ErrorMessage = "Please input Price")]
        [StringLength(20, ErrorMessage = "The value must contain at least 3 characters", MinimumLength = 3)]
        [Display(Name = "Price")]
        public string Price { get; set; }
        public string Status { get; set; }
        public string Description { get; set; }
        public string HotelId { get; set; }
    }
}