using CourseProject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CourseProject.Controllers
{
    public class HomeController : Controller
    {
        ApplicationDbContext db = new ApplicationDbContext();
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult SearchHotel()
        {
            ViewBag.Hotels = db.Hotels.ToList();
            ViewBag.Sortable = db.Hotels.ToList().Select(i => i.City); 
            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        [HttpGet]
        public ActionResult GetInfo(string Id)
        {
          
            return View(db.Hotels.Find(Id));
        }
        
        [HttpPost]
        public ActionResult BookingRoom(string Id)
        {
            ViewBag.Rooms = db.Hotels.Find(Id).Rooms.ToList();
            return View();
        }

        [HttpPost]
        public ActionResult BookingHall(string Id)
        {
            ViewBag.BanquetingHall = db.Hotels.Find(Id).Halls.ToList();
            return View();
        }

        [HttpGet]
        public ActionResult BookingRoomModal(string Id)
        {
            BookingViewModel bookingViewModel = new BookingViewModel { RoomId = db.Rooms.Find(Id).Id };
            return PartialView(bookingViewModel);
        }

        [HttpGet]
        public ActionResult BookingHallModal(string Id)
        {
            BookingViewModel bookingViewModel = new BookingViewModel { RoomId = db.BanquetingHall.Find(Id).Id };
            return PartialView(bookingViewModel);
        }

        [HttpPost]
        public ActionResult SearchHotel(string Id)
        {
            ViewBag.Hotels = db.Hotels.Where(i => i.Name.Contains(Id) == true).ToList();
            if (ViewBag.Hotels != null)
            {
                ViewBag.Sortable = db.Hotels.ToList().Select(i => i.City);
                return View();
            }
            TempData["Message"] = "Ничего не найдено";
            return RedirectToAction("SearchHotel");
        }

        [HttpGet]
        public ActionResult SearchHotelList()
        {
            ViewBag.Sortable = db.Hotels.ToList().Select(i => i.City);
            return View();
        }
        

        [HttpGet]
        public ActionResult Sortable(string Id)
        {
            if (Id == "allId") ViewBag.Hotels = db.Hotels.ToList();
            else ViewBag.Hotels = db.Hotels.Where(i => i.City == Id).ToList();
            return PartialView();

        }
        //[HttpPost]
        //public ActionResult SearchHotelByName(string Id)
        //{
        //    var hotel = db.Hotels.FirstOrDefault(i => i.Name == Id);
        //    if(hotel!=null)
        //    {
        //        return View(hotel);
        //    }
        //    TempData["Message"] = "Ничего не найдено";
        //    return RedirectToAction("SearchHotel");
        //}

        //[HttpPost]
        //public ActionResult Hotel(RegisterHotelModel model)
        //{
        //    Hotels hotel = new Hotels
        //    {
        //        Id = Guid.NewGuid().ToString(),
        //        Name = model.Name

        //    }
        //    db.Hotels.Add(hotel);
        //    db.SaveChanges();
        //    return View();
        //}
    }
}