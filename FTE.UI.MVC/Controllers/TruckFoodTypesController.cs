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
    public class TruckFoodTypesController : Controller
    {
        private FTEDBEntities db = new FTEDBEntities();

        // GET: TruckFoodTypes
        public ActionResult Index()
        {
            return View(db.TruckFoodTypes.ToList());
        }

        // GET: TruckFoodTypes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TruckFoodType truckFoodType = db.TruckFoodTypes.Find(id);
            if (truckFoodType == null)
            {
                return HttpNotFound();
            }
            return View(truckFoodType);
        }

        // GET: TruckFoodTypes/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: TruckFoodTypes/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "TruckFoodTypeID,Cuisine,Description")] TruckFoodType truckFoodType)
        {
            if (ModelState.IsValid)
            {
                db.TruckFoodTypes.Add(truckFoodType);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(truckFoodType);
        }

        // GET: TruckFoodTypes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TruckFoodType truckFoodType = db.TruckFoodTypes.Find(id);
            if (truckFoodType == null)
            {
                return HttpNotFound();
            }
            return View(truckFoodType);
        }

        // POST: TruckFoodTypes/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "TruckFoodTypeID,Cuisine,Description")] TruckFoodType truckFoodType)
        {
            if (ModelState.IsValid)
            {
                db.Entry(truckFoodType).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(truckFoodType);
        }

        // GET: TruckFoodTypes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TruckFoodType truckFoodType = db.TruckFoodTypes.Find(id);
            if (truckFoodType == null)
            {
                return HttpNotFound();
            }
            return View(truckFoodType);
        }

        // POST: TruckFoodTypes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TruckFoodType truckFoodType = db.TruckFoodTypes.Find(id);
            db.TruckFoodTypes.Remove(truckFoodType);
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
