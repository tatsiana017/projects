namespace CourseProject.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class dbm : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.BanquetingHalls",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        Name = c.String(),
                        CountPlace = c.Int(nullable: false),
                        Price = c.String(),
                        HotelId = c.String(maxLength: 128),
                        Status = c.String(),
                        Description = c.String(),
                        ImageData = c.Binary(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Hotels", t => t.HotelId, cascadeDelete: true)
                .Index(t => t.HotelId);
            
            CreateTable(
                "dbo.Hotels",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        Name = c.String(),
                        City = c.String(),
                        Adress = c.String(),
                        PhoneNumber = c.String(),
                        WebSite = c.String(),
                        ImageData = c.Binary(),
                        Description = c.String(),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.Rooms",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        HotelId = c.String(maxLength: 128),
                        CategoryId = c.String(maxLength: 128),
                        Number = c.Int(nullable: false),
                        Price = c.String(),
                        Status = c.String(),
                        Description = c.String(),
                        ImageData = c.Binary(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Categories", t => t.CategoryId)
                .ForeignKey("dbo.Hotels", t => t.HotelId, cascadeDelete: true)
                .Index(t => t.HotelId)
                .Index(t => t.CategoryId);
            
            CreateTable(
                "dbo.Categories",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        Name = c.String(),
                        CountPlace = c.Int(),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.BookedRooms",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        RoomsId = c.String(maxLength: 128),
                        DateTo = c.DateTime(nullable: false),
                        DateFrom = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Rooms", t => t.RoomsId, cascadeDelete: true)
                .Index(t => t.RoomsId);
            
            CreateTable(
                "dbo.Bookings",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        Check = c.String(),
                        UserId = c.String(maxLength: 128),
                        EventId = c.String(maxLength: 128),
                        BookedRoomId = c.String(maxLength: 128),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.BookedRooms", t => t.BookedRoomId, cascadeDelete: true)
                .ForeignKey("dbo.Events", t => t.EventId)
                .ForeignKey("dbo.AspNetUsers", t => t.UserId)
                .Index(t => t.UserId)
                .Index(t => t.EventId)
                .Index(t => t.BookedRoomId);
            
            CreateTable(
                "dbo.Events",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        DateTo = c.DateTime(nullable: false),
                        DateFrom = c.DateTime(nullable: false),
                        HallId = c.String(maxLength: 128),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.BanquetingHalls", t => t.HallId)
                .Index(t => t.HallId);
            
            CreateTable(
                "dbo.AspNetUsers",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        Surname = c.String(),
                        Name = c.String(),
                        City = c.String(),
                        Adress = c.String(),
                        Email = c.String(maxLength: 256),
                        EmailConfirmed = c.Boolean(nullable: false),
                        PasswordHash = c.String(),
                        SecurityStamp = c.String(),
                        PhoneNumber = c.String(),
                        PhoneNumberConfirmed = c.Boolean(nullable: false),
                        TwoFactorEnabled = c.Boolean(nullable: false),
                        LockoutEndDateUtc = c.DateTime(),
                        LockoutEnabled = c.Boolean(nullable: false),
                        AccessFailedCount = c.Int(nullable: false),
                        UserName = c.String(nullable: false, maxLength: 256),
                    })
                .PrimaryKey(t => t.Id)
                .Index(t => t.UserName, unique: true, name: "UserNameIndex");
            
            CreateTable(
                "dbo.AspNetUserClaims",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        UserId = c.String(nullable: false, maxLength: 128),
                        ClaimType = c.String(),
                        ClaimValue = c.String(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.AspNetUsers", t => t.UserId, cascadeDelete: true)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.AspNetUserLogins",
                c => new
                    {
                        LoginProvider = c.String(nullable: false, maxLength: 128),
                        ProviderKey = c.String(nullable: false, maxLength: 128),
                        UserId = c.String(nullable: false, maxLength: 128),
                    })
                .PrimaryKey(t => new { t.LoginProvider, t.ProviderKey, t.UserId })
                .ForeignKey("dbo.AspNetUsers", t => t.UserId, cascadeDelete: true)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.AspNetUserRoles",
                c => new
                    {
                        UserId = c.String(nullable: false, maxLength: 128),
                        RoleId = c.String(nullable: false, maxLength: 128),
                    })
                .PrimaryKey(t => new { t.UserId, t.RoleId })
                .ForeignKey("dbo.AspNetUsers", t => t.UserId, cascadeDelete: true)
                .ForeignKey("dbo.AspNetRoles", t => t.RoleId, cascadeDelete: true)
                .Index(t => t.UserId)
                .Index(t => t.RoleId);
            
            CreateTable(
                "dbo.Favorites",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        UserId = c.String(maxLength: 128),
                        RoomsId = c.String(maxLength: 128),
                        HallId = c.String(maxLength: 128),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.BanquetingHalls", t => t.HallId)
                .ForeignKey("dbo.Rooms", t => t.RoomsId)
                .ForeignKey("dbo.AspNetUsers", t => t.UserId)
                .Index(t => t.UserId)
                .Index(t => t.RoomsId)
                .Index(t => t.HallId);
            
            CreateTable(
                "dbo.AspNetRoles",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        Name = c.String(nullable: false, maxLength: 256),
                    })
                .PrimaryKey(t => t.Id)
                .Index(t => t.Name, unique: true, name: "RoleNameIndex");
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.AspNetUserRoles", "RoleId", "dbo.AspNetRoles");
            DropForeignKey("dbo.Favorites", "UserId", "dbo.AspNetUsers");
            DropForeignKey("dbo.Favorites", "RoomsId", "dbo.Rooms");
            DropForeignKey("dbo.Favorites", "HallId", "dbo.BanquetingHalls");
            DropForeignKey("dbo.Bookings", "UserId", "dbo.AspNetUsers");
            DropForeignKey("dbo.AspNetUserRoles", "UserId", "dbo.AspNetUsers");
            DropForeignKey("dbo.AspNetUserLogins", "UserId", "dbo.AspNetUsers");
            DropForeignKey("dbo.AspNetUserClaims", "UserId", "dbo.AspNetUsers");
            DropForeignKey("dbo.Bookings", "EventId", "dbo.Events");
            DropForeignKey("dbo.Events", "HallId", "dbo.BanquetingHalls");
            DropForeignKey("dbo.Bookings", "BookedRoomId", "dbo.BookedRooms");
            DropForeignKey("dbo.BookedRooms", "RoomsId", "dbo.Rooms");
            DropForeignKey("dbo.Rooms", "HotelId", "dbo.Hotels");
            DropForeignKey("dbo.Rooms", "CategoryId", "dbo.Categories");
            DropForeignKey("dbo.BanquetingHalls", "HotelId", "dbo.Hotels");
            DropIndex("dbo.AspNetRoles", "RoleNameIndex");
            DropIndex("dbo.Favorites", new[] { "HallId" });
            DropIndex("dbo.Favorites", new[] { "RoomsId" });
            DropIndex("dbo.Favorites", new[] { "UserId" });
            DropIndex("dbo.AspNetUserRoles", new[] { "RoleId" });
            DropIndex("dbo.AspNetUserRoles", new[] { "UserId" });
            DropIndex("dbo.AspNetUserLogins", new[] { "UserId" });
            DropIndex("dbo.AspNetUserClaims", new[] { "UserId" });
            DropIndex("dbo.AspNetUsers", "UserNameIndex");
            DropIndex("dbo.Events", new[] { "HallId" });
            DropIndex("dbo.Bookings", new[] { "BookedRoomId" });
            DropIndex("dbo.Bookings", new[] { "EventId" });
            DropIndex("dbo.Bookings", new[] { "UserId" });
            DropIndex("dbo.BookedRooms", new[] { "RoomsId" });
            DropIndex("dbo.Rooms", new[] { "CategoryId" });
            DropIndex("dbo.Rooms", new[] { "HotelId" });
            DropIndex("dbo.BanquetingHalls", new[] { "HotelId" });
            DropTable("dbo.AspNetRoles");
            DropTable("dbo.Favorites");
            DropTable("dbo.AspNetUserRoles");
            DropTable("dbo.AspNetUserLogins");
            DropTable("dbo.AspNetUserClaims");
            DropTable("dbo.AspNetUsers");
            DropTable("dbo.Events");
            DropTable("dbo.Bookings");
            DropTable("dbo.BookedRooms");
            DropTable("dbo.Categories");
            DropTable("dbo.Rooms");
            DropTable("dbo.Hotels");
            DropTable("dbo.BanquetingHalls");
        }
    }
}
