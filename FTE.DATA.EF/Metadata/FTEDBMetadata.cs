using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FTE.DATA.EF//.Metadata
{
    class FTEDBMetadata
    {
        #region Events Metadata
        public class EventsMetadata
        {
            [Required(ErrorMessage = "* Event Name is required")]
            [Display(Name = "Event Name")]
            [StringLength(100, ErrorMessage = "* Event Name must be 100 characters or less")]
            public string EventName { get; set; }
            [Required(ErrorMessage = "* Location is required")]
            [Display(Name = "Location Name")]
            public int LocationID { get; set; }
            [Required(ErrorMessage = "* Event Date is required")]
            [Display(Name = "Event Date")]
            [DisplayFormat(DataFormatString ="{0:d}", ApplyFormatInEditMode = true)]
            public System.DateTime EventDate { get; set; }
            [Display(Name = "Event is Cancelled")]
            public bool IsCancelled { get; set; }
            [UIHint("MultilineText")]
            [DisplayFormat(NullDisplayText="none")]
            [StringLength(300, ErrorMessage = "* Notes must be 300 characters or less")]
            public string Notes { get; set; }
        }

        [MetadataType(typeof(EventsMetadata))]
        public partial class Events { }
        #endregion

        #region Location Metadata
        public class LocationMetadata
        {
            [Required (ErrorMessage ="* Location is required")]
            [Display(Name ="Location")]
            [StringLength(50, ErrorMessage ="* Location Name must be 50 characters or less")]
            public string LocationName { get; set; }
            [Required(ErrorMessage = "* Address is required")]
            public string Address { get; set; }
            [Required(ErrorMessage = "* State is required")]
            [StringLength(2, ErrorMessage = "* State abbreviation must be 2 characters")]
            public string State { get; set; }
            [Required(ErrorMessage = "* Zip Code is required")]
            [Display(Name ="Zip Code")]
            [StringLength(5, ErrorMessage = "* Zip Code must be 5 characters")]
            public string ZipCode { get; set; }
            [Required(ErrorMessage = "* Reservation is required")]
            [Display(Name ="Reservation Limit")]
            [Range(0, 255, ErrorMessage ="* Reservation Limit must be a number between 0 and 255")]
            public byte ReservationLimit { get; set; }
        }

        [MetadataType(typeof(LocationMetadata))]
        public partial class Location { }
        #endregion

        #region Owner Assets Metadata
        public class OwnerAssetMetadata
        {
            [Required(ErrorMessage = "* Truck Name is required")]
            [Display(Name = "Truck Name")]
            [StringLength(50, ErrorMessage = "* Truck Name must be 50 characters or less")]
            public string TruckName { get; set; }
            [UIHint("_DropDownList")]
            [Required(ErrorMessage = "* Truck Food Type is required")]
            [Display(Name ="Food Truck Type")]
            public int TruckFoodTypeID { get; set; }
            [Display(Name = "Truck Photo")]
            [DisplayFormat(NullDisplayText = "n/a")]
            public string TruckPhoto { get; set; }
            [Required(ErrorMessage = "* Owner ID is required")]
            [Display(Name ="Owner ID")]
            [StringLength(128, ErrorMessage = "* Owner ID must be 128 characters or less")]
            public string OwnerID { get; set; }
            [UIHint("MultilineText")]
            [DisplayFormat(NullDisplayText = "none")]
            [StringLength(100, ErrorMessage = "* Specialty Notes must be 300 characters or less")]
            [Display(Name ="Specialty Notes")]
            public string SpecialNotes { get; set; }
            [Display(Name ="Truck is Active")]
            public bool IsActive { get; set; }
            //[Required(ErrorMessage ="Date Added is required")]
            [Display(Name ="Date Added")]
            public System.DateTime DateAdded { get; set; }
        }

        [MetadataType(typeof(OwnerAssetMetadata))]
        public partial class OwnerAsset { }
        #endregion

        #region Reservation Metadata
        public class ReservationMetadata
        {
            [Required(ErrorMessage ="* Truck is Required")]
            [Display(Name ="Truck")]
            public int OwnerAssetID { get; set; }
            [Required(ErrorMessage ="* Event is Required")]
            [Display(Name ="Event")]
            public int EventID { get; set; }
            [Required(ErrorMessage ="* Reservation Date is Required")]
            [Display(Name ="Reservation Date")]
            public System.DateTime ReservationDate { get; set; }
        }

        [MetadataType(typeof(ReservationMetadata))]
        public partial class Reservation { }
        #endregion

        #region Truck Food Types
        public class TruckFoodTypesMetadata
        {
            [Required(ErrorMessage ="Cusine Type is Required")]
            public string Cuisine { get; set; }
            [UIHint("MultilineText")]
            [DisplayFormat(NullDisplayText = "none")]
            [StringLength(250, ErrorMessage = "* Description must be 250 characters or less")]
            [Display(Name = "Specialty Notes")]
            public string Description { get; set; }
        }

        [MetadataType(typeof(TruckFoodTypesMetadata))]
        public partial class TruckFoodTypes { }
        #endregion

        #region User Details
        public class UserDetailsMetadata
        {
            [Required(ErrorMessage = "* First Name is required")]
            [Display(Name = "First Name")]
            [StringLength(50, ErrorMessage = "* First Name must be 50 characters or less")]
            public string FirstName { get; set; }
            [Required(ErrorMessage = "* Last Name is required")]
            [Display(Name = "Last Name")]
            [StringLength(50, ErrorMessage = "* Last Name must be 50 characters or less")]
            public string LastName { get; set; }
        }

        [MetadataType(typeof(UserDetailsMetadata))]
        public partial class UserDetails { }
        #endregion
    }
}
