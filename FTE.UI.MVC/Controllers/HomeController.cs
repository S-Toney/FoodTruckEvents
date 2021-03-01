using FTE.DATA.EF;
using FTE.UI.MVC.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;

namespace FTE.UI.MVC.Controllers
{
    public class HomeController : Controller
    {
        private FTEDBEntities db = new FTEDBEntities();

        public ActionResult Index()
        {

            var ev = db.Events1.Include(r => r.Reservations.Where(e => e.EventID == r.EventID));

            var res = db.OwnerAssets.Include(r => r.Reservations.Where(oa => oa.OwnerAssetID == r.OwnerAssetID ));

            //var resMade = db.Reservations.Where(r => r.ReservationDate == ev.EventDate && r.OwnerAssetID == reservation.OwnerAsset);


            var events1 = db.Events1.Include(l => l.Location).Where(e => e.EventDate > DateTime.UtcNow).OrderBy(e => e.EventDate);
            return View(events1, res);







        }

        public ActionResult About()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Contact()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Contact(ContactViewModel cvm)
        {
            if (!ModelState.IsValid)
            {
                return View(cvm);
            }

            string emailBody = $"Email From: {cvm.Name}\nSubject: {cvm.Subject}\nRespond To: {cvm.Email}\nMessage: {cvm.Message}";

            MailMessage msg = new MailMessage
                (
                //From
                "no-reply@tessatoney.com",
                //To (Where the actual message is sent)
                "stacy.toney@protonmail.com",
                //Subject
                "Email from FTE's Contact Form",
                //Body
                emailBody
                );

            msg.IsBodyHtml = true;
            SmtpClient client = new SmtpClient("mail.tessatoney.com");
            client.Credentials = new NetworkCredential("no-reply@tessatoney.com", "24qBIjF@d0");//Change to ******** before pushing to GitHub but use password for deploy

            try
            {
                client.Send(msg);
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMessage = $"Sorry, something went wrong. Error Message: {ex.Message}<br />{ex.StackTrace}";
                return View(cvm);
            }

            return View("EmailConfirmation", cvm);
        }

        [HttpGet]
        public ActionResult EmailConfirmation()
        {
            return View();
        }
    }
}