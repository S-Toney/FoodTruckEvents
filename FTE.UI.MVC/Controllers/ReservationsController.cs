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
        public ActionResult Index()
        {
            var userName = User.Identity.GetUserId();
            //var userRes = db.Reservations.Include(r => r.Event).Include(r => r.OwnerAsset).Include(OwnerAssets, d => d.UserDetail).Where(u => u.UserDetail.UserID == userName).ToList();
            //var assets = db.OwnerAssets.Include(o => o.TruckFoodType).Include(o => o.UserDetail).Where(u => u.UserDetail.UserID == userName).ToList();

            //var userRes = (from r in db.Reservations
            //               join ow in db.OwnerAssets on r.OwnerAssetID equals ow.OwnerAssetID
            //               join ud in db.UserDetails1 on ow.OwnerID equals ud.UserID
            //               where ud.UserID == userName 
            //               select new { r.Event, r.OwnerAsset }).ToList;

            var reservations = db.Reservations.Include(r => r.Event).Include(r => r.OwnerAsset);
            // List<Reservation> userRes = new List<Reservation>();

            if (!User.IsInRole("Admin") && (!User.IsInRole("SysAdmin")))
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





            //else (user is in role of Owner/customer

            //get a list of the current owner Assets (using the userID above)

            //loop through the reservatations

            //inside ^ loop loop through owner assets

            //if res.OwnerAssetID == ownerAsset.ID then add the reservation to the userRes collection

            //If userRese is Null - send to create

            //Else return the view with (userRes)

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
            //Only show owner's trucks for options
            var userName = User.Identity.GetUserId();
            if (User.IsInRole("Owner"))
            {
                ViewBag.EventID = new SelectList(db.Events1, "EventID", "EventName");
                ViewBag.OwnerAssetID = new SelectList(db.OwnerAssets.Where(x => x.OwnerID == userName), "OwnerAssetID", "TruckName");
                return View();
            }

            ViewBag.EventID = new SelectList(db.Events1, "EventID", "EventName");
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
            if (ModelState.IsValid)
            {
                //get the event associated to the reservation
                var ev = db.Events1.Where(e => e.EventID == reservation.EventID).Single();

                // Code below prevents duplicate reservations
                var duplicateRes = db.Reservations.Where(x => x.ReservationDate == reservation.ReservationDate && x.OwnerAssetID == reservation.OwnerAssetID);
                if (duplicateRes.Count() == 0)
                {

                    if (User.IsInRole("Owner"))
                    {

                        int resLoc = ev.LocationID;
                        //Find the reservation limit for the location
                        int limit = db.Locations.Where(l => l.LocationID == resLoc).Select(l => l.ReservationLimit).Single();
                        //Get the number of reservations at the location for the same date
                        int resNum = db.Reservations.Where(l => l.Event.LocationID == resLoc && reservation.ReservationDate == l.ReservationDate).Count();
                        //See if the number of reservations is less than the limit
                        //If < limit then add changes and redirect to index
                        if (resNum < limit)
                        {
                            db.Reservations.Add(reservation);
                            db.SaveChanges();
                            return RedirectToAction("Index");
                        }
                        else
                        {
                            // Otherwise, error message that reservation limit for day & location has been reached
                            ViewBag.ErrorMessageLimit = $"* {ev.EventName} has reached it's reservation limit for {reservation.ReservationDate:d}.";
                        }
                    }
                    else
                    {
                        //Admin can add reservation regardless of limit
                        db.Reservations.Add(reservation);
                        db.SaveChanges();
                        return RedirectToAction("Index");
                    }
                }
                else
                {
                    ViewBag.ErrorMessageDup = $"* This truck already has a reservation on {reservation.ReservationDate:d}.";
                    //return View();
                }
                //db.Reservations.Add(reservation);
                //db.SaveChanges();
                //return RedirectToAction("Index");
            }
            if (User.IsInRole("Owner"))
            {
                var userName = User.Identity.GetUserId();
                ViewBag.EventID = new SelectList(db.Events1, "EventID", "EventName", reservation.EventID);
                ViewBag.OwnerAssetID = new SelectList(db.OwnerAssets.Where(x => x.OwnerID == userName), "OwnerAssetID", "TruckName");
                return View();
            }
            ViewBag.EventID = new SelectList(db.Events1, "EventID", "EventName", reservation.EventID);
            ViewBag.OwnerAssetID = new SelectList(db.OwnerAssets, "OwnerAssetID", "TruckName", reservation.OwnerAssetID);
            return View(reservation);
        }

        // GET: Reservations/Edit/5
        [Authorize(Roles = "SysAdmin, Admin, Owner")]
        public ActionResult Edit(int? id)
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
            ViewBag.EventID = new SelectList(db.Events1, "EventID", "EventName", reservation.EventID);
            ViewBag.OwnerAssetID = new SelectList(db.OwnerAssets, "OwnerAssetID", "TruckName", reservation.OwnerAssetID);
            return View(reservation);
        }

        // POST: Reservations/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ReservationID,OwnerAssetID,EventID,ReservationDate")] Reservation reservation)
        {
            if (ModelState.IsValid)
            {
                db.Entry(reservation).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.EventID = new SelectList(db.Events1, "EventID", "EventName", reservation.EventID);
            ViewBag.OwnerAssetID = new SelectList(db.OwnerAssets, "OwnerAssetID", "TruckName", reservation.OwnerAssetID);
            return View(reservation);
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
