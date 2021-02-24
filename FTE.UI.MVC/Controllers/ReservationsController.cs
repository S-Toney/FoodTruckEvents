using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FTE.DATA.EF;
using FTE.UI.MVC.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;

namespace FTE.UI.MVC.Controllers
{
    [Authorize]
    public class ReservationsController : Controller
    {
        //Getting Roles & Users
        private ApplicationUserManager _userManager;
        public ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ?? HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
            set
            {
                _userManager = value;
            }
        }

        private ApplicationRoleManager _roleManager;
        public ApplicationRoleManager RoleManager
        {
            get
            {
                return _roleManager ?? HttpContext.GetOwinContext().Get<ApplicationRoleManager>();
            }
            private set
            {
                _roleManager = value;
            }
        }

        private FTEDBEntities db = new FTEDBEntities();

        // GET: Reservations
        public ActionResult Index(string selectedLocation = "All")
        {
            var userName = User.Identity.GetUserId();
            var reservations = db.Reservations.Include(r => r.Event).Include(r => r.OwnerAsset);

            #region Further Filtering
            // TODO Search for Reservation
            //if (!String.IsNullOrEmpty(searching))
            //{
            //    var resSearch = from r in db.Reservations.Where(s => s.)

            //}

            //TODO Add dropdown filtering
            //var rvm = new ReservationViewModel();
            //rvm.Locations = db.Locations.ToList();
            //var reservationData = db.Reservations;
            //if (!String.IsNullOrEmpty(selectedLocation))
            //{
            //    reservationData = db.Reservations.AsQueryable(.Where(s => s.Event.EventName == selectedLocation));
            //}
            //rvm.ReservationData.ToList();
            //return View(rvm);
            #endregion

            if (User.IsInRole("Owner"))
            {
                List<Reservation> userRes = new List<Reservation>();
                List<OwnerAsset> ListOwnerAsset = db.OwnerAssets.Where(x => x.OwnerID == userName).ToList();
                foreach (OwnerAsset oa in ListOwnerAsset)
                {
                    userRes.AddRange(db.Reservations.Where(x => x.OwnerAssetID == oa.OwnerAssetID));
                }
                return View(userRes);
            }
            else
            {
                return View(reservations);
            }

        }

        // GET: Reservations/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Reservation reservation = db.Reservations.Find(id);
            if (reservation == null)
            {
                return HttpNotFound();
            }
            return View(reservation);
        }

        // GET: Reservations/Create
        [Authorize(Roles = "SysAdmin, Admin, Owner")]
        public ActionResult Create()
        {
            //Only show owner's trucks for options in the dropdown
            var userName = User.Identity.GetUserId();
            var events1 = db.Events1.Include(l => l.Location).Where(e => e.EventDate > DateTime.UtcNow).OrderBy(e => e.EventDate);
            if (User.IsInRole("Owner"))
            {
                //TODO Only allow events that are tomorrow or forward to show in the reservation dropdown
                ViewBag.EventID = new SelectList(events1, "EventID", "SelectRes");
                ViewBag.OwnerAssetID = new SelectList(db.OwnerAssets.Where(x => x.OwnerID == userName), "OwnerAssetID", "TruckName");
                return View();
            }
            //TODO Only allow events that are tomorrow or forward to show in the reservation dropdown
            ViewBag.EventID = new SelectList(events1, "EventID", "SelectRes");
            ViewBag.OwnerAssetID = new SelectList(db.OwnerAssets, "OwnerAssetID", "TruckName");
            return View();
        }

        // POST: Reservations/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ReservationID,OwnerAssetID,EventID,ReservationDate")] Reservation reservation)
        {
            #region Commented out
            // Code below enforces the location's reservatio limit
            //var limit = from l in db.Locations
            //            where l.LocationID == reservation.Event.LocationID
            //            select l.ReservationLimit;

            //Location limit = db.Locations.FirstOrDefault (x => x.LocationID == reservation.Event.LocationID);
            //int count = 0;
            //if (reservation != null)
            //{
            //foreach (Reservation rd in db.Reservations.Where(x => x.Event.LocationID == reservation.Event.LocationID).Count())
            //{
            //    count++;
            //}
            //}
            #endregion

            if (ModelState.IsValid)
            {
                //get the event associated to the reservation
                var ev = db.Events1.Where(e => e.EventID == reservation.EventID).Single();

                // Code below prevents duplicate reservations
                var duplicateRes = db.Reservations.Where(x => x.ReservationDate == ev.EventDate && x.OwnerAssetID == reservation.OwnerAssetID);
                if (duplicateRes.Count() == 0)
                {

                    if (User.IsInRole("Owner"))
                    {

                        int resLoc = ev.LocationID;
                        //Find the reservation limit for the location
                        int limit = db.Locations.Where(l => l.LocationID == resLoc).Select(l => l.ReservationLimit).Single();
                        //Get the number of reservations at the location for the same date
                        int resNum = db.Reservations.Where(l => l.Event.LocationID == resLoc && ev.EventDate == l.ReservationDate).Count();
                        //See if the number of reservations is less than the limit
                        //If < limit then add changes and redirect to index
                        if (resNum < limit)
                        {
                            //get the reservation ddate from the event
                            reservation.ReservationDate = ev.EventDate;

                            db.Reservations.Add(reservation);
                            db.SaveChanges();
                            return RedirectToAction("Index");
                        }
                        else
                        {
                            // Otherwise, error message that reservation limit for day & location has been reached
                            ViewBag.ErrorMessageLimit = $"* {ev.EventName} has reached it's reservation limit for {ev.EventDate:d}.";
                        }
                    }
                    else
                    {
                        //Admin can add reservation regardless of limit
                        reservation.ReservationDate = ev.EventDate;
                        db.Reservations.Add(reservation);
                        db.SaveChanges();
                        return RedirectToAction("Index");
                    }
                }
                else
                {
                    ViewBag.ErrorMessageDup = $"* This truck already has a reservation on {ev.EventDate:d}.";
                }

            }
            if (User.IsInRole("Owner"))
            {
                var userName = User.Identity.GetUserId();
                ViewBag.EventID = new SelectList(db.Events1, "EventID", "SelectRes", reservation.EventID);
                ViewBag.OwnerAssetID = new SelectList(db.OwnerAssets.Where(x => x.OwnerID == userName), "OwnerAssetID", "TruckName");
                return View();
            }
            ViewBag.EventID = new SelectList(db.Events1, "EventID", "SelectRes", reservation.EventID);
            ViewBag.OwnerAssetID = new SelectList(db.OwnerAssets, "OwnerAssetID", "TruckName", reservation.OwnerAssetID);
            return View(reservation);
        }

        // GET: Reservations/Edit/5
        [Authorize(Roles = "SysAdmin, Admin, Owner")]
        public ActionResult Edit(int? id)
        {
            var events1 = db.Events1.Include(l => l.Location).Where(e => e.EventDate > DateTime.UtcNow).OrderBy(e => e.EventDate);
            //Only show owner's trucks for options in the dropdown
            //var userName = User.Identity.GetUserId();
            //if (User.IsInRole("Owner"))
            //{
            //    List<Reservation> userRes = new List<Reservation>();
            //    List<OwnerAsset> ListOwnerAsset = db.OwnerAssets.Where(x => x.OwnerID == userName).ToList();
            //    foreach (OwnerAsset oa in ListOwnerAsset)
            //    {
            //        userRes.AddRange(db.Reservations.Where(x => x.OwnerAssetID == oa.OwnerAssetID));
            //    }
            //    return View(userRes);
            //}

            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Reservation reservation = db.Reservations.Find(id);
            if (reservation == null)
            {
                return HttpNotFound();
            }
            else
            {
                //Reservation reservation = db.Reservations.Find(id);
                ViewBag.EventID = new SelectList(events1, "EventID", "SelectRes", reservation.EventID);
                ViewBag.OwnerAssetID = new SelectList(db.OwnerAssets, "OwnerAssetID", "TruckName", reservation.OwnerAssetID);
                return View(reservation);
            }
        }

        // POST: Reservations/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ReservationID,OwnerAssetID,EventID,ReservationDate")] Reservation reservation)
        {

            //TODO Add checks for duplicate reservations and reservation limit to Edit
            var ev = db.Events1.Where(e => e.EventID == reservation.EventID).Single();
            if (ModelState.IsValid)
            {
                var duplicateRes = db.Reservations.Where(x => x.ReservationDate == ev.EventDate && x.OwnerAssetID == reservation.OwnerAssetID);
                if (duplicateRes.Count() == 0)
                {

                    if (User.IsInRole("Owner"))
                    {
                        int resLoc = ev.LocationID;
                        //Find the reservation limit for the location
                        int limit = db.Locations.Where(l => l.LocationID == resLoc).Select(l => l.ReservationLimit).Single();
                        //Get the number of reservations at the location for the same date
                        int resNum = db.Reservations.Where(l => l.Event.LocationID == resLoc && ev.EventDate == l.ReservationDate).Count();
                        //See if the number of reservations is less than the limit
                        //If < limit then add changes and redirect to index
                        if (resNum < limit)
                        {
                            reservation.ReservationDate = ev.EventDate;
                            db.Entry(reservation).State = EntityState.Modified;
                            db.SaveChanges();
                            return RedirectToAction("Index");
                        }
                        else
                        {
                            // Otherwise, error message that reservation limit for day & location has been reached
                            ViewBag.ErrorMessageLimit = $"* {ev.EventName} has reached it's reservation limit for {ev.EventDate:d}.";
                        }
                        //return View(reservation);
                    }
                    else
                    {
                        reservation.ReservationDate = ev.EventDate;
                        db.Entry(reservation).State = EntityState.Modified;
                        db.SaveChanges();
                        return RedirectToAction("Index");
                    }
                    //return View(reservation);
                }
                else
                {
                    ViewBag.ErrorMessageDup = $"* This truck already has a reservation on {ev.EventDate:d}.";
                }
                ViewBag.EventID = new SelectList(db.Events1, "EventID", "SelectRes", reservation.EventID);
                ViewBag.OwnerAssetID = new SelectList(db.OwnerAssets, "OwnerAssetID", "TruckName", reservation.OwnerAssetID);
                return View(reservation);
            }
            return RedirectToAction("Index", "Reservations");
        }

        // GET: Reservations/Delete/5
        [Authorize(Roles = "SysAdmin, Admin, Owner")]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Reservation reservation = db.Reservations.Find(id);
            if (reservation == null)
            {
                return HttpNotFound();
            }
            return View(reservation);
        }

        // POST: Reservations/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Reservation reservation = db.Reservations.Find(id);
            db.Reservations.Remove(reservation);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
