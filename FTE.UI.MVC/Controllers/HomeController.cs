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
            var events1 = db.Events1.Include(l => l.Location).OrderBy(e => e.EventDate);
            return View(events1);
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
            client.Credentials = new NetworkCredential("no-reply@tessatoney.com", "20Cen$us20");//Change to ******** before pushing to GitHub but use password for deploy

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