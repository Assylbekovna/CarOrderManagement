using System;
namespace TaxiOrderSystem.States
{
    public class CarArrivedState : BaseState
    {
        public override void SelectCar() => Console.WriteLine("Автомобиль уже выбран.");
        public override void ConfirmOrder() => Console.WriteLine("Заказ уже подтвержден.");
        public override void CarArrived() => Console.WriteLine("Автомобиль уже прибыл.");
        public override void StartTrip() { Console.WriteLine("Поездка началась."); _context.TransitionTo(new InTripState()); }
        public override void CompleteTrip() => Console.WriteLine("Поездка не началась.");
        public override void CancelOrder() { Console.WriteLine("Заказ отменен."); _context.TransitionTo(new TripCancelledState()); }
    }
}
