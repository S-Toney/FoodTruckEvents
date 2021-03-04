using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FTE.UI.MVC.Models
{
    public class ReservationViewModel
    {
        public IEnumerable<FTE.DATA.EF.Reservation> ReservationData { get; set; }
        public IEnumerable<FTE.DATA.EF.Location> Locations { get; set; }
        public IEnumerable<FTE.DATA.EF.OwnerAsset> Trucks { get; set; }
        public string SelectedLocation { get; set; }


    }
}