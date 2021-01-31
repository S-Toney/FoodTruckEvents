using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FTE.DATA.EF;

namespace FTE.UI.MVC.Controllers
{
    public class ReservationsController : Controller
    {
        private FTEDBEntities db = new FTEDBEntities();

        // GET: Reservations
        public ActionResult Index()
        {
            var reservations = db.Reservations.Include(r => r.Event).Include(r => r.OwnerAsset);
            return View(reservations.ToList());
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
        [Authorize(Roles ="SysAdmin, Admin, Owner")]
        public ActionResult Create()
        {
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
            //var limit = from l in db.Locations
            //            select l.ReservationLimit;
            //var resdate = from r in db.Reservations
            //              select r.ReservationDate;
            //int count = 0;
            //foreach (Reservation r in db.Reservations)
            //{
            //    count++;
            //}
 
            //Code below enforces reservation limit set in db
            //if (User.IsInRole("Owner") || User.IsInRole("Employee") && count > limit)
            //{
            //    ViewBag.errorMessage = $"This Truck limit for {reservation.Event.Location} has been reached on {reservation.ReservationDate}";
            //}

            // Code below prevents duplicate reservations
            //if (truckid == )
            //{
            //    ViewBag.errorMessage = $"{OwnerAssetID} already has a reservation at {EventName}."
            //}

            if (ModelState.IsValid)
            {
                db.Reservations.Add(reservation);
                db.SaveChanges();
                return RedirectToAction("Index");
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
