using System;
namespace TaxiOrderSystem.States
{
    public class OrderConfirmedState : BaseState
    {
        public override void SelectCar() => Console.WriteLine("Автомобиль уже выбран.");
        public override void ConfirmOrder() => Console.WriteLine("Заказ уже подтвержден.");
        public override void CarArrived() { Console.WriteLine("Автомобиль прибыл."); _context.TransitionTo(new CarArrivedState()); }
        public override void StartTrip() => Console.WriteLine("Поездка еще не началась.");
        public override void CompleteTrip() => Console.WriteLine("Поездка не началась.");
        public override void CancelOrder() { Console.WriteLine("Заказ отменен."); _context.TransitionTo(new TripCancelledState()); }
    }
}
