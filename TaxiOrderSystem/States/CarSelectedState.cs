using System;
namespace TaxiOrderSystem.States
{
    public class CarSelectedState : BaseState
    {
        public override void SelectCar() => Console.WriteLine("Автомобиль уже выбран.");
        public override void ConfirmOrder() { Console.WriteLine("Заказ подтвержден, автомобиль в пути."); _context.TransitionTo(new OrderConfirmedState()); }
        public override void CarArrived() => Console.WriteLine("Автомобиль еще не в пути.");
        public override void StartTrip() => Console.WriteLine("Поездка не началась.");
        public override void CompleteTrip() => Console.WriteLine("Поездка не началась.");
        public override void CancelOrder() { Console.WriteLine("Заказ отменен."); _context.TransitionTo(new TripCancelledState()); }
    }
}
