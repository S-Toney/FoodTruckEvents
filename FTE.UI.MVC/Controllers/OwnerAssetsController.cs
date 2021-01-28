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
    public class OwnerAssetsController : Controller
    {
        private FTEDBEntities db = new FTEDBEntities();

        // GET: OwnerAssets
        public ActionResult Index()
        {
            var ownerAssets = db.OwnerAssets.Include(o => o.TruckFoodType).Include(o => o.UserDetail);
            return View(ownerAssets.ToList());
        }

        // GET: OwnerAssets/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            OwnerAsset ownerAsset = db.OwnerAssets.Find(id);
            if (ownerAsset == null)
            {
                return HttpNotFound();
            }
            return View(ownerAsset);
        }

        // GET: OwnerAssets/Create
        public ActionResult Create()
        {
            ViewBag.TruckFoodTypeID = new SelectList(db.TruckFoodTypes, "TruckFoodTypeID", "Cuisine");
            ViewBag.OwnerID = new SelectList(db.UserDetails1, "UserID", "FirstName");
            return View();
        }

        // POST: OwnerAssets/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "OwnerAssetID,TruckName,TruckFoodTypeID,TruckPhoto,OwnerID,SpecialNotes,IsActive,DateAdded")] OwnerAsset ownerAsset)
        {
            if (ModelState.IsValid)
            {
                db.OwnerAssets.Add(ownerAsset);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.TruckFoodTypeID = new SelectList(db.TruckFoodTypes, "TruckFoodTypeID", "Cuisine", ownerAsset.TruckFoodTypeID);
            ViewBag.OwnerID = new SelectList(db.UserDetails1, "UserID", "FirstName", ownerAsset.OwnerID);
            return View(ownerAsset);
        }

        // GET: OwnerAssets/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            OwnerAsset ownerAsset = db.OwnerAssets.Find(id);
            if (ownerAsset == null)
            {
                return HttpNotFound();
            }
            ViewBag.TruckFoodTypeID = new SelectList(db.TruckFoodTypes, "TruckFoodTypeID", "Cuisine", ownerAsset.TruckFoodTypeID);
            ViewBag.OwnerID = new SelectList(db.UserDetails1, "UserID", "FirstName", ownerAsset.OwnerID);
            return View(ownerAsset);
        }

        // POST: OwnerAssets/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "OwnerAssetID,TruckName,TruckFoodTypeID,TruckPhoto,OwnerID,SpecialNotes,IsActive,DateAdded")] OwnerAsset ownerAsset)
        {
            if (ModelState.IsValid)
            {
                db.Entry(ownerAsset).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.TruckFoodTypeID = new SelectList(db.TruckFoodTypes, "TruckFoodTypeID", "Cuisine", ownerAsset.TruckFoodTypeID);
            ViewBag.OwnerID = new SelectList(db.UserDetails1, "UserID", "FirstName", ownerAsset.OwnerID);
            return View(ownerAsset);
        }

        // GET: OwnerAssets/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            OwnerAsset ownerAsset = db.OwnerAssets.Find(id);
            if (ownerAsset == null)
            {
                return HttpNotFound();
            }
            return View(ownerAsset);
        }

        // POST: OwnerAssets/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            OwnerAsset ownerAsset = db.OwnerAssets.Find(id);
            db.OwnerAssets.Remove(ownerAsset);
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
